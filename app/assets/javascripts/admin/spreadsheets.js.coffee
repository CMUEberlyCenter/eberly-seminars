$ ->
  $('table.spreadsheet').dataTable({"iDisplayLength": 25})
  $('td a').live('click', -> $(this).parent('td').children('div').slideToggle() );

  $('.truncate').live( 'click',
    -> 
      $(this).children('.preview').hide()
      $(this).children('.truncated').slideDown()
  )
  $('.truncate > .truncated > a.hide-text').live( 'click',
    (event) ->
      $(this).parent().slideUp()
      $(this).parent().prev('.preview').show()
      event.stopPropagation()
      event.preventDefault()
  )