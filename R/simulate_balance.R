#' Simulate balance
#'
#' @param initial_amount Initial amount
#' @param end_date End date
#' @param ... Named calls to `amt_*` functions
#' @import data.table
#' @importFrom lubridate day Date
#' @importFrom plotly plot_ly add_lines layout
#' @export
simulate_balance <- function(initial_amount, end_date, ...) {
  options("budget_end_date" = end_date)

  in_out <- data.table(
    date = lubridate::Date(),
    description = character(),
    montant = numeric()
  )

  .dots <- list(
    "Initial amount" = data.table(
      date = Sys.Date(),
      amount = initial_amount
    ),
    ...
  )

  trx <- lapply(seq_along(.dots), function(i) {
    x <- copy(.dots[[i]])
    x[!is.na(date), description := names(.dots)[i]]
  }) |>
    rbindlist(
      use.names = TRUE,
      fill = TRUE
    )

  balance <- rbindlist(
    list(
      data.table(
        date = seq.Date(from = Sys.Date() + 1, to = end_date, by = 1),
        amount = 0
      ),
      trx[, .(date, amount)]
    ),
    use.names = TRUE,
    fill = TRUE
  )[
    order(date),
    .(variation = sum(amount)),
    by = .(date)
  ][
    ,
    balance := cumsum(variation)
  ]

  options("budget_end_date" = NULL)

  list(
    "transactions" = trx[order(date, amount < 0, -abs(amount), description)],
    "balance" = balance,
    "plot" = plotly::plot_ly() |>
      plotly::add_lines(data = balance, x = ~date, y = ~balance, name = "Balance") |>
      plotly::layout(yaxis = list(rangemode = "tozero"))
  )
}
