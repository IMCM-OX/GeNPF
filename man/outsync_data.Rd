% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/outsync_data.R
\name{outsync_data}
\alias{outsync_data}
\title{Synchronizing persistent disk contents into google bucket}
\usage{
outsync_data(destination_bucket, folder_name = "data")
}
\arguments{
\item{destination_bucket}{A string representing the destination bucket id such as \verb{gs://fc-12345cfd-756f-5e19-b0c5-fbc6b26a067d}}

\item{folder_name}{The folder name as it appears in the persistent disk AND Terra workspace that contains data and files to sync back.}
}
\value{
Side effect, syncs data into google bucket
}
\description{
Synchronizing persistent disk contents into google bucket
}
