#' Retrieve historical daily currency exchange rates data for Canadian Dollar in CSV format from Bank of Canada website.
#' The function pre-processes and cleans the data to transform it into a more usable format.
#' 
#' @param output if the value is False then only display the data frame, if the value is True then write the file to the current working directory 
#'
#' @return cleaned and processed csv data file that includes historical data on currency exchange rates
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