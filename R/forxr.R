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
retrieve_data <- function(output) {
  print("retrieve_data_function")
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
  print("TBD")
}


#' This function takes currency exchange rates data as input and returns a
#' list of two strings containing the fastest and slowest growing currency
#' exchange rate in relation to Canadian Dollar.
#' The data provided contains currency code in the format FX***CAD,
#' the average exchange rate and the date.
#'
#' @param start_date inputted starting date in the format specified '%YYYY-%mm-%dd'
#' @param end_date inputted ending date in the format specified '%YYYY-%mm-%dd'
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

  # Check for invalid date range
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
  tepm <- rbind(df[1,], df[nrow(df),])
  diff <- abs(diff(tepm))

  nums <- as.numeric(diff[2,-c(1,2)])
  fastestcurr <- names(which.max(nums))
  slowestcurr <- names(which.min(nums))

  # calculates and stores the increase and decrease overall
  fastdiff <- max(nums)
  slowdiff <- min(nums)

  # Extracting the current rate of the slowest and the fastest currencies
  slow_current_rate <- data[nrow(data),slowestcurr]
  fast_current_rate <- data[nrow(data),fastestcurr]

  # returning the computed values
  return(list(list(fastestcurr, fast_current_rate), list(slowestcurr, slow_current_rate)))
}
