check_option_budget_end_date <- function() {
  if (getOption("budget_end_date")|> is.null()) {
    stop("`budget_end_date` option must be defined.")
  }
}
