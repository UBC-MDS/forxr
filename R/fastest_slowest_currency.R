#' fastest_slowest_currency
#'
#' @description
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
#'
#' @export
#'
#' @examples
#' fastest_slowest_currency('2019-05-23', '2022-05-30')
#'
fastest_slowest_currency <- function(start_date, end_date) {
  options(warn = -1)
  library(tidyr)
  library(tidyverse)

  # Unit tests for the function
  # Check for invalid date format
  if (!grepl("^\\d{4}-\\d{2}-\\d{2}$", start_date) || !grepl("^\\d{4}-\\d{2}-\\d{2}$", end_date))
  {
    stop("Invalid date format. Please enter dates in the format '%YYYY-%mm-%dd'.")
  }

  # Check for invalid range of dates
  start <- as.Date(start_date, format = "%Y-%m-%d")
  end <- as.Date(end_date, format = "%Y-%m-%d")
  if (start > end)
  {
    stop("Invalid date range. Please ensure that the start date is before the end date.")
  }

  # Extracting the data split to calculate the fastest and slowest currency for the given range
  data <- retrieve_data()
  df <- data[data$date >= start & data$date <= end,]

  # Check for empty data
  if (nrow(df) == 0)
  {
    stop("No data available for the specified date range.")
  }

  # Computing the fastest growing currency and the slowest growing currency for the given range
  tepm <- df[1,]
  tepm <- rbind(tepm, df[nrow(df),])
  diff <- tepm[nrow(tepm),] - tepm[1,]
  nums <- diff %>% select(-c("date", "CAD"))
  nums <- abs(nums)

  fastestcurr <- names(which.max(nums))
  slowestcurr <- names(which.min(nums))

  # calculates and stores the increase and decrease overall - user can use this later on
  fastdiff <- max(nums)
  slowdiff <- min(nums)

  # Extracting the current rate of the slowest and the fastest currencies
  slow_current_rate <- data[nrow(data), slowestcurr]
  fast_current_rate <- data[nrow(data), fastestcurr]

  return(list(list(fastestcurr, fast_current_rate), list(slowestcurr, slow_current_rate)))
}
