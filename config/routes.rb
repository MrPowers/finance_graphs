FinanceCharts::Application.routes.draw do
  root to: "shiller_data_months#cape_data"

  match 'cape_data' => 'shiller_data_months#cape_data'
  match 'interest_rates_dividends' => 'shiller_data_months#interest_rates_dividends'
  match 'sp_index' => 'shiller_data_months#sp_index'
  match 'historic_returns' => 'shiller_data_months#historic_returns'
  match 'returns_calculator' => 'shiller_data_months#returns_calculator'

  match 'future_value' => 'financial_calculators#future_value'
  match 'mortgage_amortization' => 'financial_calculators#mortgage_amortization'
end
