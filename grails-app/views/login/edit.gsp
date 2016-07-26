<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/5/11
  Time: 11:16 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Simple GSP page</title>

        <style type="text/css">
        .tabla {
            display : table;
        }

        .fila {
            display : table-row;
        }

        .celda {
            display : table-cell;
        }

        .label {
            font-weight : bold;
            width       : 80px;
        }
        </style>

    </head>

    <body>

        <g:if test="${flash.message}">
            <div id="divMsg" style="margin-top: 20px; padding: 0 .7em;" class="ui-state-${flash.clase} ui-corner-all">
                <p>
                    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-${flash.icon}"></span>
                    ${flash.message}
                </p>
            </div>
        </g:if>
        <g:else>
            <div id="divMsg" class="ui-helper-hidden"></div>
        </g:else>

        <div id="dlgCuenta">
            <g:form name="frmCuenta" action="saveCuenta" controller="usuario">
                <fieldset>
                    <legend>Datos de ingreso</legend>

                    <div class="tabla">
                        <div class="fila">
                            <div class="celda label">
                                Usuario:
                            </div>

                            <div class="celda">
                                <g:textField name="login" class="ui-widget-content ui-corner-all" value="${session.usuario.login}"/>
                            </div>
                        </div>

                        <div class="fila">
                            <div class="celda label">
                                Contrase&ntilde;a:
                            </div>

                            <div class="celda">
                                <g:passwordField name="pass" class="ui-widget-content ui-corner-all" value="${session.usuario.pass?'******':''}"/>
                            </div>
                        </div>
                    </div>
                </fieldset>

                <fieldset>
                    <legend>Datos personales</legend>

                    <div class="tabla">
                        <div class="fila">
                            <div class="celda label">
                                Nombre:
                            </div>

                            <div class="celda">
                                <g:textField name="nombre" class="ui-widget-content ui-corner-all" value="${session.usuario.nombre}"/>
                            </div>
                        </div>

                        <div class="fila">
                            <div class="celda label">
                                Apellido:
                            </div>

                            <div class="celda">
                                <g:textField name="apellido" class="ui-widget-content ui-corner-all" value="${session.usuario.apellido}"/>
                            </div>
                        </div>

                        <div class="fila">
                            <div class="celda label">
                                E-mail:
                            </div>

                            <div class="celda">
                                <g:textField name="email" class="ui-widget-content ui-corner-all" value="${session.usuario.email}"/>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </g:form>
        </div>

        <script type="text/javascript">
            $(function () {


                if ($("#divMsg").is("visible")) {
                    console.log("SI");
                    $("#divMsg").effect("pulsate", {}, 1500, function () {
                        $("#divMsg").hide;
                    });
                }

                $("#dlgCuenta").dialog({
                    title:"Datos de la cuenta",
                    position:[20, 90],
                    width:300,
                    closeOnEscape:false,
                    open:function (event, ui) {
                        $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
                    },
                    buttons:{
                        "Guardar":function () {
                            $("#frmCuenta").submit();
                        }
                    }
                });
            });
        </script>

    </body>
</html>