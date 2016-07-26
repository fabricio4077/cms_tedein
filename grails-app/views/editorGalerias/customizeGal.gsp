<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/20/11
  Time: 10:55 AM
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

        <div id="opts" title="Opciones">
            <form id="frmProps">
                <table style="width:250px; font-size:12px;">
                    <thead>
                        <th style="border:1px black solid;" class="ui-state-active">Propiedad</th>
                        <th style="border:1px black solid" class="ui-state-active">Valor</th>
                    </thead>
                    <tbody>

                        <tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">
                            <td hover=".gv-panel_wrap">Panel de fotos</td>
                        </tr>
                        <g:each in="${panel}" var="prop">
                            <tr title="${prop.obj.explicacion}">
                                <td style="border:1px black solid;padding-left:5px;" class="ui-state-active">
                                    ${prop.obj.mostrar}
                                </td>
                                <td style="border:1px black solid;">
                                    <elm:item propiedad="${prop.obj}" value="${prop.value}"/>
                                </td>
                            </tr>
                        </g:each>

                        <tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">
                            <td>Animaciones</td>
                            <td></td>
                        </tr>
                        <g:each in="${anim}" var="prop">
                            <tr title="${prop.obj.explicacion}">
                                <td style="border:1px black solid;padding-left:5px;" class="ui-state-active">
                                    ${prop.obj.mostrar}
                                </td>
                                <td style="border:1px black solid;">
                                    <elm:item propiedad="${prop.obj}" value="${prop.value}"/>
                                </td>
                            </tr>
                        </g:each>

                        <tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">
                            <td hover=".gv-strip_wrapper">Miniaturas</td>
                            <td></td>
                        </tr>
                        <g:each in="${film}" var="prop">
                            <tr title="${prop.obj.explicacion}">
                                <td style="border:1px black solid;padding-left:5px;" class="ui-state-active">
                                    ${prop.obj.mostrar}
                                </td>
                                <td style="border:1px black solid;">
                                    <elm:item propiedad="${prop.obj}" value="${prop.value}"/>
                                </td>
                            </tr>
                        </g:each>

                        <tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">
                            <td>Descripci&oacute;n</td>
                            <td></td>
                        </tr>
                        <g:each in="${info}" var="prop">
                            <tr title="${prop.obj.explicacion}">
                                <td style="border:1px black solid;padding-left:5px;" class="ui-state-active">
                                    ${prop.obj.mostrar}
                                </td>
                                <td style="border:1px black solid;">
                                    <elm:item propiedad="${prop.obj}" value="${prop.value}"/>
                                </td>
                            </tr>
                        </g:each>

                    </tbody>
                </table>
            </form>
        </div>


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

                    data += "&" + $("#frmProps").serialize()
                    $("input:not(:checked)").each(function() {
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