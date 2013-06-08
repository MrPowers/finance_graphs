FinanceCharts::Application.routes.draw do
  root to: "shiller_data_months#cape_data"
  match 'cape_data' => 'shiller_data_months#cape_data'
  match 'interest_rates_dividends' => 'shiller_data_months#interest_rates_dividends'
end
