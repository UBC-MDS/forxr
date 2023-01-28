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
  df <- retrieve_data()

  names <- c('AUD','BRL','CNY', 'EUR', 'HKD', 'INR', 'IDR', 'JPY', 'MXN', 'NZD', 'NOK', 'PEN',
             'RUB', 'SAR', 'SGD', 'ZAR', 'KRW', 'SEK', 'CHF', 'TWD', 'TRY', 'GBP', 'USD')
  if (!(currency1 %in% names)){
    if (!(currency1 =='CAD')){
      stop("The currency to be converted is invalid!")
    }
  }

  if (!(currency2 %in% names)){
    if (!(currency2 =='CAD')){
      stop("The currency to be converted to is invalid!")
    }
  }

  if (value<=0){
    stop("Please enter an positive amount!!")
  }

  if (currency2 =='CAD'){
    if(currency1 == 'CAD'){
      return(round(value,3))
    }else{
      pos1 <- match(currency1,names)+1 #the col index of the currency1 in the df
      rt1 <- df[length(df[,1]),pos1] #find the conversion rate of the currency1
      return(round(value*rt1,3))
    }
  }
  if (currency1 =='CAD'){
    if(currency2 == 'CAD'){
      return(round(value,3))
    }else{
      pos2 <- match(currency2,names)+1 #the col index of the currency2 in the df
      rt2 <- df[length(df[,1]),pos2] #find the conversion rate of the currency2
      return(round(value/rt2,3))
    }
  }
  if (currency1!='CAD'&currency2!='CAD'){
    pos1 <- match(currency1,names)+1 #the col index of the currency1 in the df
    rt1 <- df[length(df[,1]),pos1] #find the conversion rate of the currency1
    pos2 <- match(currency2,names)+1 #the col index of the currency2 in the df
    rt2 <- df[length(df[,1]),pos2] #find the conversion rate of the currency2
    return(round(value*rt1/rt2,3))
  }
}
