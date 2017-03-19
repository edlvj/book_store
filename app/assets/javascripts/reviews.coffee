document.addEventListener 'turbolinks:load', ->
  
  $('#stars li').on('mouseover', ->
    onStar = parseInt($(this).data('value'), 10)
    $(this).parent().children('li.star').each (e) ->
      if e < onStar
        $(this).addClass 'hover'
      else
        $(this).removeClass 'hover'
      return
    return
  ).on 'mouseout', ->
    $(this).parent().children('li.star').each (e) ->
      $(this).removeClass 'hover'
      return
    return
  
  $('#stars li').on 'click', ->
    onStar = parseInt($(this).data('value'), 10)
    stars = $(this).parent().children('li.star')
    i = 0
    while i < stars.length
      $(stars[i]).removeClass 'selected'
      i++
    i = 0
    while i < onStar
      $(stars[i]).addClass 'selected'
      i++
    ratingValue = parseInt($('#stars li.selected').last().data('value'), 10)
    $('#review_rate').val ratingValue
    return
  return