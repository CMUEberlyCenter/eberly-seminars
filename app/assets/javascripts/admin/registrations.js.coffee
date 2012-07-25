$ ->
  

  $('#registration_form .participant').bind('contextmenu', (e) ->

    e.stopImmediatePropagation()


    $(document).bind('keyup.show_attendance_form', (event) ->
        escape = 27
        if( event.keyCode == escape )
          $('#registration_form .attendance-form').fadeOut(300)
          $(document).unbind('.show_attendance_form')
          $(document).find('*').unbind('.show_attendance_form')
    )



    $(document).bind('mousedown.show_attendance_form', (event) ->
      $('#registration_form .attendance-form').fadeOut(300)
      $(document).unbind('.show_attendance_form')
      $(document).find('*').unbind('.show_attendance_form')
    )

    $('#registration_form .participant').bind('click.show_attendance_form', (event) ->
      event.preventDefault()
      event.stopPropagation()
    )

    $(this).children('.attendance-form').show()

    e.preventDefault()
    false
  )

  $('#registration_form .attendance-form input').bind('change',
    ->  $.ajax
          type: "PUT"
          url: $(this).attr("action")
          dataType: "script"
          data: 
            attendance_status: $(this).attr('value')
            registration_id: $(this).parent().children('#registration').attr('value')
          done: $('.attendance-form').fadeOut(300)
  )

