<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/19/11
  Time: 11:09 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Simple GSP page</title>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/lightbox/css', file: 'prettyPhoto.css')}"
              type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8"/>
        <script src="${resource(dir: 'js/jquery/plugins/lightbox/js', file: 'jquery.prettyPhoto.js')}"
                type="text/javascript" charset="utf-8"></script>

    </head>

    <body>

        <div id="galeria"></div>

        <elm:dialogPropiedades id="opts" title="Propiedades" from="${np}" galeria="${gal}"/>

        <script type="text/javascript">
            $(function () {

                reload();

                $("#opts").dialog({
                    location:["left", "center"],
                    buttons:{
                        "Recargar":function () {
                            reload();
                        }
                    },
                    width:320,
                    height:700,
                    position:[1000, 35],
                    open:function (event, ui) {
                        $(this).prev().children().eq(1).children().first().removeClass("ui-icon-closethick").addClass("ui-icon-circle-triangle-n");
                    },
                    beforeClose:function (event, ui) {
                        $(this).toggle("blind");

                        $(".ui-icon-circle-triangle-s").switchClass("ui-icon-circle-triangle-s", "ui-icon-circle-triangle-n", 1000);
                        $(".ui-icon-circle-triangle-n").switchClass("ui-icon-circle-triangle-n", "ui-icon-circle-triangle-s", 1000);
                        return false;
                    }
                });

                function reload() {
                    var data = "id=${gal.id}";

                    data += "&" /*+ $("#frm_opts").serialize()*/;

                    $("#frm_opts input,select").not(":checkbox").each(function () {
                        //console.log($(this));
                        data += $(this).attr("name") + "=" + $(this).val() + ($(this).attr("sufijo") != null && $(this).attr("sufijo") != "null" ? $(this).attr("sufijo") : "") + "&";
                    });

                    var d = "";
                    //console.log($(":checkbox:not(:checked)"));
                    $(":checkbox:not(:checked)").each(function () {
                        if (data[data.length - 1] != "&") {
                            d += "&";
                        }
                        d += $(this).attr("id") + "=false&";
                    });

                    data += d;
                    //console.log(data);

                    $.ajax({
                        type:"POST",
                        url:"${createLink(action:'renderGal')}",
                        data:data,
                        success:function (res) {
                            $("#galeria").html(res);
                        }
                    });
                }


            });
        </script>

    </body>
</html>