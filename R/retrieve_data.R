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
