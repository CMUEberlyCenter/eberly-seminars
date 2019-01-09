$( document ).ready(function() {
    $(".attendancea").on("click",
                        function() {
                            attr = $(this).attr("data-icon");
                            if(attr == "fa-check-circle") { attr = "fa-adjust"; }
                            else if(attr == "fa-ban") { attr = "fa-check-circle"; }
                            else if(attr == "fa-adjust") { attr = "fa-times-circle" }
                            else if(attr == "fa-times-circle") { attr = "fa-times" }
                            else { attr = "fa-ban"; }

                            $(this).attr("data-icon", attr);
                            $(this).html("<i class=\"fas fa-2x " + attr + "\"></i>");
                        });

    $("#all_participants").change(
        function() {
            if(this.checked) {
                $(".participant").prop('checked', true);
            }
            else { $(".participant").prop('checked', false );
                 }
        }
    );

    $("#mark_all").click(
        function() {
            $(".attendance").attr("data-icon", "fa-check-circle");
            $(".attendance").html("<i class=\"fas fa-2x fa-check-circle\"></i>");
        }
    );

    $("#unmark_all").click(
        function() {
            $(".attendance").attr("data-icon", "fa-ban");
            $(".attendance").html("<i class=\"fas fa-2x fa-ban\"></i>");
        }
    );
});
