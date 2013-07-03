class window.NumberToString
  this.number_with_commas = (number) ->
    Math.round(number).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

  this.percent_formatting = (x) ->
    result = parseFloat(x * 100).toFixed(1)
    return(result + "%")

  this.round_float = (number, num_digits) ->
    (number).toFixed(num_digits)


class window.StringToNumber
  this.convert_to_float = (string) ->
    string = string.replace( /[,$ ]/g, "" )
    parseFloat(string)

  this.convert_to_percent = (string) ->
    string = string.replace( /[,%]/g, "" )
    number = parseFloat(string)
    if number > 1
      number = number / 100
    number
