#' plot_historical
#'
#' @description
#'
#' Plots the historical rate of the entered currencies within a specific
#' period of time.
#'
#' @param start_date Entered starting date in the format specified '%YYYY-%mm-%dd'.
#' @param end_date Entered ending date in the format specified '%YYYY-%mm-%dd'.
#' @param currency1 The type of based currency asked for plotting.
#' @param currency2 The type of exchange currency asked for plotting.
#'
#' @return A plot showing the performance of the currency.
#' @export
#'
#' @examples
#' plot_historical('2020-05-23', '2022-05-30', 'USD', 'CAD')
#'
plot_historical <-function(start_date, end_date, currency1, currency2){
  library(tidyverse)
  library(ggplot2)
  library(plotly)

  # Check for invalid range of dates
  start <- as.Date(start_date, format = "%Y-%m-%d")
  end <- as.Date(end_date, format = "%Y-%m-%d")
  if (start > end){
    stop("Invalid date range. Please ensure that the start date is before the end date.")
  }

  # Data filtration
  ratio <- paste0(currency1, '/', currency2)
  data <- retrieve_data()
  data[ratio] = data[currency1]/data[currency2]
  df <- data |> filter(date >= start & date <= end)

  # Plotting
  plt_title = paste0('How many ', currency2, ' does 1 ', currency1, ' worth?')
  plt <- df |> ggplot() +
    aes(
      x = date, y = .data[[ratio]]) +
    geom_line() +
    theme_bw() +
    labs(
      title = plt_title,
      x = "Date") +
    theme(
      plot.title = element_text(size = 12, face = "bold"),
      axis.text = element_text(size = 10),
      axis.title = element_text(size = 12),
      legend.text = element_text(size = 10, margin = margin(r = 1, unit = "cm")),
      legend.title = element_text(size = 10, face = "bold")
    )


  return(ggplotly(plt))
}
