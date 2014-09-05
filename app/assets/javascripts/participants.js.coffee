$ ->
  #$("section.participant input[type='submit']").hide()
  $("section.participant #note-submit").hide()

  $("#add-activity-link").click (event) ->
       $("#add-activity-form input[type=\"text\"]").val("")
       $("#add-activity-form textarea").val("")
       $("#add-activity-form").slideDown()
       $(this).toggle()
       event.preventDefault()

  $("#add-observation-link").click (event) ->
       $("#add-observation-form input[type=\"text\"]").val("")
       #$("#add-observation-form textarea").val("")
       $("#add-observation-form").slideDown()
       $(this).toggle()
       event.preventDefault()

  $("#add-project-link").click (event) ->
       $("#add-project-form input[type=\"text\"]").val("")
       #$("#add-project-form textarea").val("")
       $("#add-project-form").slideDown()
       $(this).toggle()
       event.preventDefault()

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

  $('.best_in_place').best_in_place()

  $.datepicker.setDefaults({ dateFormat: 'M dd, yy' });