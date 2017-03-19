document.addEventListener 'turbolinks:load', ->
  $('.in-grey-600.small.line-height-2').shorten
    'showChars': 150
    'moreText': 'Read More'
    'lessText': 'Less'
    'classMore': 'in-gold-500 ml-10'
