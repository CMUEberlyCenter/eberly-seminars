$ ->
 $("table").dataTable()
 $('td a').bind('click', -> $(this).parent('td').children('div').slideToggle() );
