$ ->
  $('.seminar-group.confirmed a.seminar-registration-cancel').bind( 'click',
    -> 
      $(this).fadeOut(300).html('Registration Canceled').addClass('inactive').fadeIn(300)
  )

  $('.seminar-group.pending a.seminar-request-cancel').bind( 'click',
    -> 
      $(this).fadeOut(300).html('Request Canceled').addClass('inactive').fadeIn(300)
  )

  $('.seminar-group.offering a.seminar-request').bind( 'click',
    -> 
      $(this).fadeOut(300).html('Request Received').addClass('inactive').fadeIn(300)
  )
