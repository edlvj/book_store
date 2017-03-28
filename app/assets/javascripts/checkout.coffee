document.addEventListener 'turbolinks:load', ->
  $('#use_billing').change ->
    if this.checked
      $('#shipping_address').hide()
    else
      $('#shipping_address').show() 