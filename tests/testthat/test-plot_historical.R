# Adding test cases for the plot_historical function
# Defining the function for testing the tests

#' Test that if object base is not set properly
test_that("Plot object base is not set properly", {
  plt <- plot_historical('2020-05-23', '2022-05-30', 'USD', 'CAD')
  pltobj <- as.list(plt, inherit = TRUE)
  expect_equal(pltobj[1]$x$data[[1]]$type, "scatter")
})

#' Test that if the plot type is correct
test_that("Plot type is not correct", {
  plt <- plot_historical('2020-05-23', '2022-05-30', 'USD', 'CAD')
  pltobj <- as.list(plt, inherit = TRUE)
  expect_equal(pltobj[1]$x$data[[1]]$mode, "lines")
})

#' Test that if plot dash type is correct
test_that("The plot properties are not correct", {
  plt <- plot_historical('2020-05-23', '2022-05-30', 'USD', 'CAD')
  pltobj <- as.list(plt, inherit = TRUE)
  expect_equal(pltobj[1]$x$data[[1]]$line$dash, "solid")
})

#' Test that if the base plot option reads the correct data
test_that("The plot properties are not correct", {
  plt <- plot_historical('2020-05-23', '2022-05-30', 'USD', 'CAD')
  pltobj <- as.list(plt, inherit = TRUE)
  expect_equal(pltobj[1]$x$data[[1]]$hoveron, "points")
})
