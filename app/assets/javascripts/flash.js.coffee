$ ->
  animation_speed = 300
  $('.flash').parent().animate(
    (paddingTop: $('.flash').outerHeight(true) ),
    (
      duration: animation_speed,
      queue: false,
      complete: () ->
        $(this).animate( 
          (paddingTop: 0),
          (
            duration: 0,
            queue: false,
          )  
        )
        $('.flash').fadeIn( animation_speed )
    )
  )
