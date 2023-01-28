#' Retrieve historical daily currency exchange rates data for Canadian Dollar
#' in CSV format from Bank of Canada website.The function pre-processes and
#' cleans the data to transform it into a more usable format.
#'
#' @param output if the value is False then only display the data frame,
#' if the value is True then write the file to the current working directory
#'
#' @return cleaned and processed csv data file that includes historical
#' data on currency exchange rates
#' @export
#'
#' @examples
#' retrieve_data(output)
retrieve_data <- function(export_csv = FALSE) {
  # Read CSV file and reset the index
  url <- 'https://raw.githubusercontent.com/mrnabiz/forx_source/main/data/raw/raw_data_cad.csv'
  raw_data <- read.csv(url, header = TRUE, skip = 38)
  
  # Setting the first row as column names
  colnames(raw_data) <- raw_data[1,]
  data_frame <- raw_data[-1,]
  
  # Drop "FXMYRCAD", "FXTHBCAD", "FXVNDCAD" columns with many NA values
  data_frame <- data_frame[!(colnames(data_frame) %in% c("FXMYRCAD", "FXTHBCAD", "FXVNDCAD"))]
  
  # Convert date column to datetime format
  data_frame$date <- as.Date(data_frame$date)
  
  # Creating list of column names
  col_list <- colnames(data_frame)
  
  # Remove the date column from the list
  col_list <- col_list[col_list != "date"]
  
  # Convert all columns in the list provided to numeric data type
  data_frame[col_list] <- sapply(data_frame[col_list], as.numeric)
  
  # Wrangling column names
  colnames(data_frame) <- gsub("FX", "", colnames(data_frame))
  colnames(data_frame) <- gsub("CAD", "", colnames(data_frame))
  
  # Add "CAD" column and assign a value of 1.0 to each row
  data_frame$CAD <- 1.0
  
  if (export_csv) {
    # Saving dataframe as CSV file if output=TRUE
    write.csv(data_frame, "data_raw.csv", row.names = FALSE)
  } else {
    # Only display dataframe if output=FALSE
    return(data_frame)
  }
  
  return(data_frame)
}

#' Takes a currency value and the currency type
#'to be converted to as input and returns the converted currency
#'value as per the current conversion rate.
#' @param value The value of the original currency to be converted
#' @param currency1 The type of currency originally
#' @param currency2 The type of currency that the currency1 will be converted to
#'
#' @return Returns converted numeric currency
#' @export
#'
#' @examples
#' currency_convert(23, 'USD', 'CAD')
currency_convert <- function(value, currency1, currency2) {
  df <- retrieve_data()

  names <- c('AUD','BRL','CNY', 'EUR', 'HKD', 'INR', 'IDR', 'JPY', 'MXN', 'NZD', 'NOK', 'PEN', 
          'RUB', 'SAR', 'SGD', 'ZAR', 'KRW', 'SEK', 'CHF', 'TWD', 'TRY', 'GBP', 'USD')
  if (!(currency1 %in% names)){
    if (!(currency1 =='CAD')){
      stop("The currency to be converted is invalid!")
    }
  }
  
  if (!(currency2 %in% names)){
   if (!(currency2 =='CAD')){
     stop("The currency to be converted to is invalid!")
   }
  }
    
  if (value<=0){
     stop("Please enter an positive amount!!")
  }
    
  if (currency2 =='CAD'){
    if(currency1 == 'CAD'){
     return(round(value,3))
    }else{
     pos1 <- match(currency1,names)+1 #the col index of the currency1 in the df
     rt1 <- df[length(df[,1]),pos1] #find the conversion rate of the currency1
     return(round(value*rt1,3))
    }
  }
  if (currency1 =='CAD'){
    if(currency2 == 'CAD'){
      return(round(value,3))
   }else{
     pos2 <- match(currency2,names)+1 #the col index of the currency2 in the df
     rt2 <- df[length(df[,1]),pos2] #find the conversion rate of the currency2
     return(round(value/rt2,3))
    }
  }
  if (currency1!='CAD'&currency2!='CAD'){
   pos1 <- match(currency1,names)+1 #the col index of the currency1 in the df
   rt1 <- df[length(df[,1]),pos1] #find the conversion rate of the currency1
   pos2 <- match(currency2,names)+1 #the col index of the currency2 in the df
   rt2 <- df[length(df[,1]),pos2] #find the conversion rate of the currency2
   return(round(value*rt1/rt2,3))
  }
}


#' This function takes currency exchange rates data as input and returns a
#' list of two strings containing the fastest and slowest growing currency
#' exchange rate in relation to Canadian Dollar.
#' The data provided contains currency code in the format FX***CAD,
#' the average exchange rate and the date.
#'
#' @param start_date inputted starting date in the format 
#' specified '%YYYY-%mm-%dd'
#' @param end_date inputted ending date in the format 
#' specified '%YYYY-%mm-%dd'
#'
#' @return list of lists with fastest and slowest currency and the
#' current exchange rate of the currencies in the given date range
#' @export
#'
#' @examples
#' fastest_slowest_currency('2019-05-23', '2022-05-30')
fastest_slowest_currency <- function(start_date, end_date) {

  # Check for invalid date format
  if (!grepl("^\\d{4}-\\d{2}-\\d{2}$", start_date) || !grepl("^\\d{4}-\\d{2}-\\d{2}$", end_date)){
    stop("Invalid date format. Please enter dates in the format '%YYYY-%mm-%dd'.")
  }

  # Check for invalid range of dates
  start <- as.Date(start_date, format = "%Y-%m-%d")
  end <- as.Date(end_date, format = "%Y-%m-%d")
  if (start > end){
    stop("Invalid date range. Please ensure that the start date is before the end date.")
  }

  # Extracting the data split to calculate the fastest and slowest currency for the given range
  data <- retrieve_data()
  df <- data[data$date >= start & data$date <= end,]

  # Check for empty data
  if (nrow(df) == 0){
    stop("No data available for the specified date range.")
  }

  # Computing the fastest growing currency and the slowest growing currency for the given range
  tepm <- rbind(df[1, ], df[nrow(df), ])
  diff <- abs(diff(tepm))

  nums <- as.numeric(diff[2, -c(1,2)])
  fastestcurr <- names(which.max(nums))
  slowestcurr <- names(which.min(nums))

  # calculates and stores the increase and decrease overall -  user can access this later on
  fastdiff <- max(nums)
  slowdiff <- min(nums)

  # Extracting the current rate of the slowest and the fastest currencies
  slow_current_rate <- data[nrow(data), slowestcurr]
  fast_current_rate <- data[nrow(data), fastestcurr]

  # returning the computed values
  return(list(list(fastestcurr, fast_current_rate), list(slowestcurr, slow_current_rate)))
}


#' Plots the historical rate of the entered currencies within a specific 
#' period of time.
#'
#' @param start_date Entered starting date in the format specified '%YYYY-%mm-%dd'
#' @param end_date Entered ending date in the format specified '%YYYY-%mm-%dd'
#' @param currency1 The type of based currency asked for plotting
#' @param currency2 The type of exchange currency asked for plotting
#'
#' @return A plot showing the performance of the currency.
#' @export
#'
#' @examples
#' plot_historical('2020-05-23', '2022-05-30', 'USD', 'CAD')
plot_historical <-function(start_date, end_date, currency1, currency2){
  print("retrieve_data_function")
}
