% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/retrieve_data.R
\name{retrieve_data}
\alias{retrieve_data}
\title{retrieve_data}
\usage{
retrieve_data(export_csv = FALSE)
}
\arguments{
\item{export_csv}{if the value is False then only display the data frame,
if the value is True then write the file to the current working directory}
}
\value{
cleaned and processed csv data file that includes historical
data on currency exchange rates
}
\description{
Retrieve historical daily currency exchange rates data for Canadian Dollar
in CSV format from Bank of Canada website.The function pre-processes and
cleans the data to transform it into a more usable format.
}
\examples{
retrieve_data(export_csv = FALSE)

}
