$(function() {
  var sp_data = $('#sp_data').data('sp-data');
  sp_data = [{
    name : "S&P 500 Index",
    data : sp_data
  }];

  var linear_settings = { "div_id":"#container", "chart_title":"Real S&P 500 Index", "data":sp_data }
  ShillerDataMonth.create_chart(linear_settings);

  var log_settings = { "div_id":"#sp_index_log_scale", "chart_title":"Real S&P 500 Index Log Scale", "data":sp_data, 'vertical_scale':'logarithmic' }
  ShillerDataMonth.create_chart(log_settings);
});
