#' Test that if currency_convert returns to correct data type
test_that("currency_convert doesn't return the correct object type", {
  result<-currency_convert(2,'CAD','CNY')
  expect_equal(class(result), "numeric")
})

#' Test that if currency_convert can recognize invalid currency type
test_that("currency_convert can't recognize invalid currency type", {
  expect_error(currency_convert(2,'aaa','CNY'), "The currency to be converted is invalid!")
})

#' Test that if currency_convert can recognize invalid transfer value
test_that("currency_convert can't recognize invalid transfer value", {
  expect_error(currency_convert(-2,'CAD','CNY'), "Please enter an positive amount!!")
})

#' Test that if currency_convert can return correct value
test_that("currency_convert doesn't return the correct value", {
  result<-currency_convert(2,'CAD','CNY')
  names <- c('AUD','BRL','CNY', 'EUR', 'HKD', 'INR', 'IDR', 'JPY', 'MXN', 'NZD', 'NOK', 'PEN',
             'RUB', 'SAR', 'SGD', 'ZAR', 'KRW', 'SEK', 'CHF', 'TWD', 'TRY', 'GBP', 'USD')
  df <- retrieve_data()
  pos2 <- match('CNY', names) + 1
  rt2 <- df[length(df[,1]),4]
  val <- round(2/rt2,3)
  expect_equal(result, val)
})
