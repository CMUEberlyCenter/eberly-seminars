$ ->
  # TODO: such a hack; see seminar_spreadsheet.html.erb
  $('table.spreadsheet').dataTable({"iDisplayLength": 25, "oSearch": {"sSearch": default_filter }})
  $('#participants-spreadsheet td a.registrations_popup').live('click',
    (event) ->
      $(this).parent('td').children('div').slideToggle()
      event.stopPropagation()
      event.preventDefault()
  )

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