# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

  $ ->
    drpOptions = drop: (event, ui) ->
      @append ui.draggable.html()
    $("#registered-participants, #waitlisted_participants").sortable(
      connectWith: ".connected-sortable"
      items: "li:not(.cant-drag)"
      placeholder: "ui-draggable-dragging"
      receive: (event, ui) ->
        ui.item.addClass("moved")
        $.ajax
          type: "PUT"
          url: $(this).attr("action")
          dataType: "script"
          data: 
            registered: $("#registered-participants").sortable("serialize")
            waitlisted: $("#waitlisted_participants").sortable("serialize")
        false
    )

