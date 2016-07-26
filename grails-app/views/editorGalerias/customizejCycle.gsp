<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/28/11
  Time: 11:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Simple GSP page</title>

    </head>
    <body>

        <div id="galeria"></div>

        <elm:dialogPropiedades id="opts" title="Propiedades" from="${np}" galeria="${gal}"/>

        <script type="text/javascript">
            $(function() {

                reload();

                $("#opts").dialog({
                    location:["left","center"],
                    buttons: {
                        "Recargar": function() {
                            reload();
                        }
                    },
                    width:300,
                    height:400,
                    position: [1000,35],
                    open: function(event, ui) {
                        $(this).prev().children().eq(1).children().first().removeClass("ui-icon-closethick").addClass("ui-icon-circle-triangle-n");
                    },
                    beforeClose: function(event, ui) {
                        $(this).toggle("blind");

                        $(".ui-icon-circle-triangle-s").switchClass("ui-icon-circle-triangle-s", "ui-icon-circle-triangle-n", 1000);
                        $(".ui-icon-circle-triangle-n").switchClass("ui-icon-circle-triangle-n", "ui-icon-circle-triangle-s", 1000);
                        return false;
                    }
                });

                function reload() {
                    var data = "id=${gal.id}";

                    data += "&" + $("#frm_opts").serialize()
                    $(":checkbox:not(:checked)").each(function() {
                        data += "&" + $(this).attr("id") + "=false";
                    });

                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'renderGal')}",
                        data: data,
                        success: function(res) {
                            $("#galeria").html(res);
                        }
                    });
                }

            });
        </script>

    </body>
</html>