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