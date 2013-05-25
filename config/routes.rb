FinanceCharts::Application.routes.draw do
  match 'cape_data' => 'shiller_data_months#cape_data'
end
