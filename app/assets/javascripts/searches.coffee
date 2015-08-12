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
