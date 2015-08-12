$ ->
  $("#search").autocomplete
    source:
      (request, response) ->
        $.ajax
          url: "/search.json",
          data: { term: $("#search").val()  }
          success: (data) ->
            response( data )
        return
    minLength: 3,
    select: (event,ui) ->
      $("#search").val(ui.item.value)
      $("#site-search").submit()
      return

  $("#participant_andrewid").autocomplete
    source:
      (request, response) ->
        $.ajax
          url: "/search.json",
          data: { term: $("#participant_andrewid").val()  }
          success: (data) ->
            response( data )
        return
    minLength: 3,
    select: (event,ui) ->
      $("#participant_andrewid").val(ui.item.value)
      $(this).closest("form").submit()
      return
