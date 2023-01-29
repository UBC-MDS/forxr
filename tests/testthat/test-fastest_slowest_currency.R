# Adding test cases for the fastest_slowest_currency function
# Defining the function for testing the tests
# fastest_slowest_currency <- function(start_date, end_date) {
#     return(list(c("EUR", 1.2), c("IDR", 0.00008)))
# }

# Tests if the date formats and range are correct and in order
test_that("start and end date are correct", {
  start_date <- "2019-05-23"
  end_date <- "2022-05-30"
  start <- as.Date(start_date, format = "%Y-%m-%d")
  end <- as.Date(end_date, format = "%Y-%m-%d")
  expect_true(as.numeric(difftime(end, start, units = "days")) > 0 )
})

# Tests if the function returns the items in the proper format of lists
test_that("function returns a list", {
  start_date <- "2019-05-23"
  end_date <- "2022-05-30"
  res <- fastest_slowest_currency(start_date, end_date)
  expect_equal(typeof(res), 'list')
})

# Tests if the function returns the correct fastest currency
test_that("function returns correct fastest currency", {
  start_date <- "2019-05-23"
  end_date <- "2022-05-30"
  res <- fastest_slowest_currency(start_date, end_date)
  expect_true(res[[1]][1] == "TWD")
})

# Tests if the function returns the correct slowest currency
test_that("function returns correct slowest currency", {
  start_date <- "2019-05-23"
  end_date <- "2022-05-30"
  res <- fastest_slowest_currency(start_date, end_date)
  expect_true(res[[2]][1] == "TRY")
})
