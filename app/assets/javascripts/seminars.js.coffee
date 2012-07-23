$ ->
  $('.delete-registration').bind( 'click',
    -> $(this).fadeOut(300).html("Registration Canceled").fadeIn(300)
  )

  $('.delete-registration-cancel').bind( 'click',
    (event) -> 
      event.preventDefault()
      $(this).parent().slideToggle()
  )