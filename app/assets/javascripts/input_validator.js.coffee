class window.InputValidator
  this.validate = (inputs) ->
    for input in inputs
      if isNaN(input)
        alert("All fields must be filled in to run the calculator")
        return false
    true
