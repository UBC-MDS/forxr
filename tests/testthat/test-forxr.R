#' Unit tests for retrieve_data function
#' Test that the correct object type of data frame is returned
test_that("retrieve_data doesn't return the correct object type", {
  data_frame <- retrieve_data()
  expect_s3_class(data_frame, "data.frame")
})

#' Test that the date column is of correct type <date>
test_that("Date column is not of the correct type", {
  data_frame <- retrieve_data()
  expect_equal(class(data_frame$date), "Date")
})

#' Test that CAD column has all the 1's in the entire column
test_that("CAD column doesn't have the correct values imputed", {
  data_frame <- retrieve_data()
  expect_true(all(data_frame$CAD == 1.0))
})

#' Test that if export_csv = TRUE then CSV file is exported
test_that("Data frame is not exported as a CSV file", {
  retrieve_data(export_csv = TRUE)
  expect_true(file.exists("data_raw.csv"))
  file.remove("data_raw.csv")
})

#' Test that if export_csv = FALSE, CSV file is not exported
test_that("data frame is exported as CSV file when export_csv = FALSE", {
  retrieve_data(export_csv = FALSE)
  expect_false(file.exists("data_raw.csv"))
})

# Adding test cases for the fastest_slowest_currency function
# Defining the function for testing the tests 
# fastest_slowest_currency <- function(start_date, end_date) {
#     return(list(c("EUR", 1.2), c("IDR", 0.00008)))
# }

# Defining test cases
context("fastest_slowest_currency tests")

# Tests if the date formats are correct and in order
test_that("start and end date are correct", {
    start_date <- "2019-05-23"
    end_date <- "2022-05-30"
    start <- as.Date(start_date, format = "%Y-%m-%d")
    end <- as.Date(end_date, format = "%Y-%m-%d")
    expect_that(as.numeric(difftime(start, end, units = "days")) > 0, is_true())
})

# Tests if the function returns the items in the proper format
test_that("function returns a list", {
    res <- fastest_slowest_currency(start_date, end_date)
    expect_that(is.list(res), is_true())
})

# Tests if the function returns the correct fastest currency
test_that("function returns correct fastest currency", {
    res <- fastest_slowest_currency(start_date, end_date)
    expect_equal(res[[1]][1], "EUR")
})

# Tests if the function returns the correct slowest currency
test_that("function returns correct slowest currency", {
    res <- fastest_slowest_currency(start_date, end_date)
    expect_equal(res[[2]][1], "IDR")
})