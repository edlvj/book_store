# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@decQty =(id) ->
  $("input#"+id)[0].value -= 1 if $("input#"+id)[0].value > 1
  
@incQty =(id) ->
  val = parseInt($("input#"+id)[0].value)
  $("input#"+id)[0].value = val + 1