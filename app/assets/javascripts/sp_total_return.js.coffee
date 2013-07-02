$ = jQuery

$ ->
  $('#return_calculator_button').click ->
    $.ajax ->
      url: "http://localhost:3000/historic_returns.json"
      #contentType: "application/json"
      type: "GET"
      data: {"start_year":"2008","start_month":"1","end_year":"2008","end_month":"12"}
      dataType: "json"
      success: (data) ->
        alert("success #{data}")
      error: ->
        alert("failure")
