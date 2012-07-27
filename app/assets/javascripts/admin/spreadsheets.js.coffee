$ ->
  $('table.spreadsheet').dataTable()
  $('td a').bind('click', -> $(this).parent('td').children('div').slideToggle() );

  $('.truncate').bind( 'click',
    -> 
      $(this).children('.preview').hide()
      $(this).children('.truncated').slideDown()
  )
  $('.truncate > .truncated > a.hide-text').bind( 'click',
    (event) ->
      $(this).parent().slideUp()
      $(this).parent().prev('.preview').show()
      event.stopPropagation()
      event.preventDefault()
  )