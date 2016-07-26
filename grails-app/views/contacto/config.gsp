<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 3/4/12
  Time: 11:45 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="nth.Idioma" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Configurar formulario de contacto</title>
    </head>

    <body>
        <div id="dlgConfig" title="Configurar formulario de contacto (${session.idioma.nombre})">
            <table border="1" cellpadding="4" style="border-collapse: collapse;">
                <g:if test="${session.idioma.abreviacion == 'es'}">
                    <thead>
                        <tr class="ui-widget-header">
                            <th>Orden</th>
                            <th>Nombre del campo</th>
                            <th>Tipo de campo</th>       
                            <th>&nbsp;</th>
                        </tr>
                        <tr>
                            <td style="text-align:center;">
                                <input type="text" class="ui-corner-all" id="fieldOrder" style="width: 30px;"/>
                            </td>
                            <td>
                                <input type="text" class="ui-corner-all" id="fieldName"/>
                            </td>
                            <td>
                                <select id="fieldType" class="ui-corner-all">
                                    <option value="textfield">Campo de texto</option>
                                    <option value="textarea">Area de texto</option>
                                    <option value="boton">Bot&oacute;n Guardar</option>
                                </select>
                            </td>
                            <td style="text-align:center;">
                                <a href="#" id="btnAgregar">Agregar</a>
                            </td>
                        </tr>
                    </thead>
                </g:if>
                <tbody id="tb" class="ui-widget-content">
                    ${tb}
                </tbody>
            </table>

            <br/>

            <a href="#" id="btnTerminar">Guardar</a>

        </div>

        <script type="text/javascript">
            $(function () {

                $("#btnTerminar").button({
                    icons:{
                        primary:"ui-icon-disk"
                    }
                }).click(function () {
                            window.close();
                        });

                var o = $("#tb tr").length + 1;
                $("#fieldOrder").val(o);

                $("#btnAgregar").button({
                    icons:{
                        primary:"ui-icon-plusthick"
                    },
                    text:false
                }).click(function () {

                            var field = $("#fieldName").val();
                            var tipo = $("#fieldType").val();
                            var l = $("#tb tr[frase=" + field + "]").length;

                            if (tipo == "boton") {
                                if (l == 0) {
                                    l = $("#tb tr[tipo=" + tipo + "]").length;
                                }
                            }

                            if (l == 0) {
                                $.ajax({
                                    url:'${createLink(action: "addField")}',
                                    data:{
                                        field:field,
                                        tipo:tipo,
                                        seccion:"${seccion.id}",
                                        orden:$("#fieldOrder").val()
                                    },
                                    success:function (msg) {
                                        $("#fieldName").val("");
                                        $("#fieldType").val("textfield");
                                        $("#tb").html(msg);
                                        o = $("#tb tr").length + 1;
                                        $("#fieldOrder").val(o);
                                    }
                                });
                            } else {
                                console.log("REPETIDO!");
                            }
                        });

                $("#dlgConfig").dialog({
                    width:555,
                    position:[0, 0],
                    closeOnEscape:false,
                    open:function (event, ui) {
                        $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
                    }
                });
            });
        </script>

    </body>
</html>