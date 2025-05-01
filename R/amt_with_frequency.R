#' Amount every n weeks
#'
#' @param start_date Start date
#' @param amount Amount
#' @param n Number of weeks
#' @param end_date End date
#' @import data.table
#' @export
amt_every_n_weeks <- function(start_date, amount, n = 1L, end_date = as.Date(NA)) {
  check_option_budget_end_date()
  data.table(
    date = seq.Date(
      from = start_date,
      to = min(end_date, getOption("budget_end_date"), na.rm = TRUE),
      by = n * 7L
    ),
    amount = amount
  )[
    date > Sys.Date()
  ]
}

#' Amount once
#'
#' @param date Date
#' @param amount Amount
#' @import data.table
#' @export
amt_once <- function(date, amount) {
  check_option_budget_end_date()
  data.table(
    date = date,
    amount = amount
  )[
    date > Sys.Date() & date <= getOption("budget_end_date")
  ]
}

#' Amount every n months
#'
#' @param start_date Start date
#' @param amount Amount
#' @param n Number of months
#' @param end_date End date
#' @import data.table
#' @importFrom lubridate interval %m+%
#' @export
amt_every_n_months <- function(start_date, amount, n = 1L, end_date = as.Date(NA)) {
  check_option_budget_end_date()

  n_months <- ceiling(
    lubridate::interval(
      start = start_date,
      end = fcoalesce(end_date, getOption("budget_end_date"))
    )/months(1)
  )

  data.table(
    date = start_date %m+% months(n * (0:n_months)),
    amount = amount
  )[
    date > Sys.Date() & date <= min(end_date, getOption("budget_end_date"), na.rm = TRUE)
  ]
}
