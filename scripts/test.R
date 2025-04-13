simulate_balance(
  initial_amount = 4321,
  end_date = as.Date("2025-12-31"),
  "Paie de Simon" = amt_every_n_weeks(
    start_date = Sys.Date(),
    amount = 500,
    n = 3
  ),
  "Paie de JF" = amt_every_n_weeks(
    start_date = Sys.Date(),
    amount = -50,
    n = 1
  ),
  "Paie de Galette" = amt_every_n_weeks(
    start_date = Sys.Date(),
    amount = 750,
    n = 2
  ),
  "Paie de Douglas" = amt_every_n_weeks(
    start_date = Sys.Date(),
    amount = -1000,
    n = 4
  ),
  "Versement 1" = amt_once(
    date = as.Date("2026-12-30"),
    amount = 911
  ),
  "Versement mensuel" = amt_every_n_months(
    start_date = Sys.Date() + 10,
    amount = 111,
    n = 2
  )
)
