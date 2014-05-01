$ ->
  $("section.participant input[type='submit']").hide()

  $("#note").on "click",
    ->
       $(this).css( "color", "#000000" )
       $(this).val('') if $(this).val() == $("#note_default_text").val()

  if $("#note").val() != $("#note_default_text").val()
    $("#note").css("color","#000000")

  $("#note").on "blur",
    ->
      if $("#note_default_text").val() != $("#note_seed_text").val()
        if $(this).val() == ''
          $(this).css( "color", "#999999" )
          $(this).parents("form").submit()
          $(this).val( $("#note_default_text").val() )
          $("#note_seed_text").val( $("#note_default_text").val() )
        else if $(this).val() != $("#note_seed_text").val()
          $(this).parents("form").submit()
      else if $(this).val() != ''
        $(this).parents("form").submit()
        $("#note_seed_text").val( $(this).val() )
      else if $(this).val() == ''
        $(this).css( "color", "#999999" )
        $(this).val( $("#note_default_text").val() )


#  toggleSpinner = -> $("#spinner").toggle()
#
#  $("form[data-remote]")
#    .bind('ajax:before', toggleSpinner)
#    .bind('ajax:complete', toggleSpinner)
#    .bind('ajax:success', (event, data, status, xhr) ->
#      $("#response").html("Saved!").show().fadeOut("slow")
#    )
#    .bind('ajax:error', (xhr, status, error) -> )
