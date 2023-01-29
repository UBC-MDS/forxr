
<!-- README.md is generated from README.Rmd. Please edit that file -->

# forxr

<!-- badges: start -->
<!-- badges: end -->

Package to access daily exchange rates and forex conversion created by Group 6: Dhruvi Nishar, Mohammad Reza Nabizadeh, Hongjian Li, and Stepan Zaiatc.

`forxr` allows users to easily convert currency rates by utilizing data from [Bank of Canada](https://www.bankofcanada.ca/rates/exchange/daily-exchange-rates/). The package supports multiple currencies and provides historical exchange rates. It also has the ability to make currency conversions with the use of a simple function call, making it easy for developers to integrate into their projects. Additionally, it provides a way to get historical exchange rates in a chart, which makes it useful for dashboard building. 

Overall, *forxr* is a powerful and flexible package that provides a comprehensive solution for handling currency conversions in R. Accessing and converting currency rates from authoritative source, supporting multiple currencies convertion to/from CAD, providing historical exchange rates, and its ease of use make it a valuable addition to the R ecosystem.

## Installation

You can install the development version of regexcite from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/forxr")
```

## Usage

- TODO

### Functions included in the package:

- **retrieve_data()**: Retrieve historical daily currency exchange rate data for Canadian Dollars in CSV format from the Bank of Canada website.
- **currency_convert**: The conversion rate is based on the average exchange rate by the 4:00 pm ET of the closest business day.
- **fastest_slowest_currency()**: This function takes currency exchange rates data as input and returns a list of two strings containing the fastest and slowest growing currency exchange rate in relation to Canadian Dollar. The data provided contains currency code in the format FX\*\*\*CAD, the average exchange rate and the date.
- **plot_historical()**:Plots the historical rate of the entered currencies within a specific period of time.

**forxpy** can be a useful tool for many industries that require currency conversions. Here are a few examples:

1. **Finance and Banking**: Banks and financial institutions often need to convert currencies for international transactions, and “forxr” can provide accurate and up-to-date exchange rates for these purposes. 
2. **E-commerce**: Online retailers that sell internationally may need to display prices in multiple currencies, and “forxr” can help them convert the prices in real-time. 
3. **Travel and Tourism**: Travel agencies and booking websites may need to convert currency for pricing and budgeting purposes, and “forxr” can provide them with accurate exchange rates. 4. **Data Analysis**: Companies that conduct global business can use “forxr” to collect and analyze historical exchange rate data, which can be useful for making business decisions and forecasting.

## Where the package fits into the R ecosystem?

There are several packages in the R ecosystem that provide functionality similar to forxr. Some examples are [`fixerapi`](https://docs.evanodell.com/fixerapi/) and [`priceR: Economics and Pricing Tools`](https://cran.r-project.org/web/packages/priceR/index.html). These packages also allow users to access daily exchange rates and perform currency conversions. However, forxr excels at utilizing the data from Bank of Canada data and providing historical exchange rates, making it a more comprehensive currency conversion solution in R for Canadians in particular. Additionally, this package also provides the ability to retrieve historical exchange rates and displaying them on charts, making it useful for creating dashboards. Overall, forxr fits well into the R ecosystem as a powerful and flexible package for handling currency conversions.

## Contributing

**Authors**: Dhruvi Nishar, Mohammad Reza Nabizadeh, Hongjian Li, and Stepan Zaiatc.

Interested in contributing? Check out the contributing guidelines. Please note that this project is released with a Code of Conduct. By contributing to this project, you agree to abide by its terms.

## License

`forxr` was created by Group 6 at UBC MDS - Dhruvi Nishar, Mohammad Reza Nabizadeh, Hongjian Li, and Stepan Zaiatc. It is licensed under the terms of the MIT license.
