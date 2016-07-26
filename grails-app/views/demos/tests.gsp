<script type='text/javascript'>
    $(function () {
        $("#addComment").dialog({
            width:430,
            autoOpen:false,
            modal:true,
            buttons:{
                "Guardar":function () {
                    var data = $("#frmComment").serialize();
                    data += "&seccion.id=11";
                    var url = $("#frmComment").attr("action");
                    $.ajax({
                        type:"POST",
                        url:url,
                        data:data,
                        success:function (msg) {
                            if (msg != "ERROR") {
                                $("#frmComment").reset();
                                $("#addComment").dialog("close");
                                $("#comentarios").html(msg);
                            }
                        }
                    });
                }, "Cancelar":function () {
                    $("#addComment").dialog("close")
                }
            }
        });
        $("#btnAdd").button({
            text:false,
            icons:{
                primary:"ui-icon-plusthick"
            }
        }).click(function () {
                    $("#addComment").dialog("open");
                    return false;
                });
    });
</script>