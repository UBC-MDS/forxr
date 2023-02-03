
# forxr

<!-- badges: start -->
<!-- badges: end -->

Package to access daily exchange rates and forex conversion created by Group 6: Dhruvi Nishar, Mohammad Reza Nabizadeh, Hongjian Li, and Stepan Zaiatc.

`forxpy` allows users to easily convert currency rates by utilizing data from [Bank of Canada](https://www.bankofcanada.ca/rates/exchange/daily-exchange-rates/). The package supports multiple currencies and provides historical exchange rates. It also has the ability to make currency conversions with the use of a simple function call, making it easy for developers to integrate into their projects. Additionally, it provides a way to get historical exchange rates in a chart, which makes it useful for dashboard building. Overall, **forxpy** is a powerful and flexible package for handling currency conversions in Python.

## Installation

You can install the development version of forxr from [GitHub](https://github.com/) with:
      
```{r}
# install.packages("devtools")
devtools::install_github("UBC-MDS/forxr")
```

## Usage

Please note that you can **click** on each of the functions below to see **detailed use case examples**.

One of the most common tasks in many of the industries such as finance, marketing, accounting etc. is currency conversion. Here we outline the steps needed to take in order to be able to utilize this package in R to convert international currencies to/from Canadian Dollar:

1. Install the package by following the steps in **"Installation"** section above.

2. Load the package: After installation, load the package in your R environment by running **library(forxr)**.

```{r}
library(forxr)
```

3. Retrieve exchange rate data: Use the retrieve_data() function to retrieve historical exchange rate data for Canadian Dollar. This function will retrieve historical daily currency exchange rates data for Canadian Dollar in CSV format from Bank of Canada website. You could also specify whether you would like the data frame to be written to a file in your current working directory by changing the value to an argument to TRUE `export_csv = TRUE`, or leave it as FALSE to display the data frame only. The data is drawn from [Bank of Canada](https://www.bankofcanada.ca/rates/exchange/daily-exchange-rates/). The data is updated daily.

```{r}
retrieve_data(export_csv = FALSE)
```

4. Once the data is loaded, `currency_convert()` function will then take a currency value (first argument) and the currency type to be converted **FROM** (second argument) followed by the currency type to be converted **TO** (third argument) as input arguments. This function will calculate the average conversion rate available by 4:00 pm ET of the closest business day of the currency type you are trying to convert to. It will then apply average rate to the currency value specified as the first argument and the return the final .

```{r}
currency_convert(23, 'CAD', 'AUD')
```

5. To further expand on this package we developed the function that returns a **list** of two strings containing the fastest and slowest growing currency exchange rates in relation to Canadian Dollar. The user has to specify the start date as first argument in the following format '%YYYY-%mm-%dd'  and the end date as second argument in the following format the '%YYYY-%mm-%dd'. The returned output is then as follows: **fastest growing currency type**, **fastest growing currency rate**, **slowest growing currency type**, **slowest growing currency rate**.

```{r}
fastest_slowest_currency('2019-05-23', '2022-05-30')
```

6. In order to further analyze currecncy exchange rates, you could plot the historical rate of entered currency types within sepcified period of time. `plot_historical()` will take start date ('%YYYY-%mm-%dd') as first argument, end date ('%YYYY-%mm-%dd') as second argument, currency type to convert **FROM** as third argument and currency type to convert **TO** as forth argument. The object returned will be ggplot line graph with `Date` on the x-axis and `Currency Type` on the y-axis.

```{r}
plot_historical('2020-05-23', '2022-05-30', 'USD', 'CAD')
```

### Functions included in the package:

- **retrieve_data()**: Retrieve historical daily currency exchange rate data for Canadian Dollars in CSV format from the Bank of Canada website.
- **currency_convert**: The conversion rate is based on the average exchange rate by the 4:00 pm ET of the closest business day.
- **fastest_slowest_currency()**: This function takes start and end dates as input and returns a  list of lists containing the fastest and slowest growing currency exchange rate in relation to Canadian Dollar along with the current exchange rates in the given date range. The data provided contains currency code in the format FX***CAD, the average exchange rate and the date.
- **plot_historical()**:Plots the historical rate of the entered currencies within a specific period of time.

**forxpy** can be a useful tool for many industries that require currency conversions. Here are a few examples:
1. **Finance and Banking**: Banks and financial institutions often need to convert currencies for international transactions, and "forxpy" can provide accurate and up-to-date exchange rates for these purposes.
2. **E-commerce**: Online retailers that sell internationally may need to display prices in multiple currencies, and "forxpy" can help them convert the prices in real-time.
3. **Travel and Tourism**: Travel agencies and booking websites may need to convert currency for pricing and budgeting purposes, and "forxpy" can provide them with accurate exchange rates.
4. **Data Analysis**: Companies that conduct global business can use "forxpy" to collect and analyze historical exchange rate data, which can be useful for making business decisions and forecasting.

## Where the package fits into the R ecosystem?

There are several packages in the R ecosystem that provide functionality similar to forxr. Some examples are [`fixerapi`](https://docs.evanodell.com/fixerapi/) and [`priceR: Economics and Pricing Tools`](https://cran.r-project.org/web/packages/priceR/index.html). These packages also allow users to access daily exchange rates and perform currency conversions. However, forxr excels at utilizing the data from Bank of Canada data and providing historical exchange rates, making it a more comprehensive currency conversion solution in R for Canadians in particular. Additionally, this package also provides the ability to retrieve historical exchange rates and displaying them on charts, making it useful for creating dashboards. Overall, forxr fits well into the R ecosystem as a powerful and flexible package for handling currency conversions.

## Contributing

**Authors**: Dhruvi Nishar, Mohammad Reza Nabizadeh, Hongjian Li, and Stepan Zaiatc.

Interested in contributing? Check out the contributing guidelines. Please note that this project is released with a Code of Conduct. By contributing to this project, you agree to abide by its terms.

## License

`forxr` was created by Group 6 at UBC MDS - Dhruvi Nishar, Mohammad Reza Nabizadeh, Hongjian Li, and Stepan Zaiatc. It is licensed under the terms of the MIT license.
