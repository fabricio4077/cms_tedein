<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/25/11
  Time: 12:11 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame" />
        <title>CMS - NTH</title>

        <style type="text/css">
        .fila {
            width  : 325px;
            height : 40px;
            float  : none;
        }

        .label {
            font-weight : bold;
            width       : 120px;
        }

        .valor {
            width : 200px;
        }

        .input, .error {
            width : 200px;
        }

        .error {
            display     : none;
            margin-left : 10px;
            display     : block;
            color       : red;
            border      : dotted #710909 1px;
        }

        * {
            margin  : 0;
            padding : 0;
        }

        body {
            font    : 10px Arial, Verdana, Sans-Serif;
            padding : 0 20px;
        }

        h4 {
            margin : 15px 0 5px 0;
        }

        h4, p {
            font-size : 1.2em;
        }

        ul li {
            display : inline;
        }

        .wide {
            border-bottom : 1px #000 solid;
            width         : 4000px;
        }
        </style>

    </head>

    <body>
        <ul class="topnav ui-corner-all" style="position:absolute; top:2px;z-index:1999;">
            <li><a href="#" id="guardar">Guardar</a></li>
        </ul>

        <g:form action="saveTipo" method="POST" name="frmTipoPag" style="height: 200px; margin-top: 45px;">
            <div id="col1" style="width: 330px; float:left; height: 170px;">
                <div class="fila">
                    <div class="label">
                        Nombre Publicaci&oacute;n:
                    </div>

                    <div class="valor">
                        <g:textField name="nombre" id="nombre" value=""
                                     class="input ui-corner-all required" />
                    </div>
                </div>

                <div class="fila" style="height: 105px;">
                    <div class="label">
                        Descripci&oacute;n:
                    </div>

                    <div class="valor">
                        <g:textArea name="descripcion" rows="5" cols="23"
                                    class="input ui-corner-all"></g:textArea>
                    </div>
                </div>

                <div class="fila">
                    <div class="label">
                        Layout Publicaci&oacute;n:
                    </div>

                    <div class="valor">
                        <g:select id="cmbLayouts" name="cmbLayouts" from="${layouts}" optionKey="id"
                                  optionValue="nombre" class="input ui-corner-all required"
                                  noSelection="['':'-Seleccione-']" />
                    </div>
                </div>
            </div>

            <div id="col2" style="width: 330px; float:left; height: 170px;">
                <div class="fila">
                    <div class="label">
                        Nombre p&aacute;gina:
                    </div>

                    <div class="valor">
                        <g:textField name="nombrePag" id="nombrePag" value=""
                                     class="input ui-corner-all required nowhitespace" />
                    </div>
                </div>

                <div class="fila">
                    <div class="label">
                        Men&uacute;:
                    </div>

                    <div class="valor">
                        <g:textField name="menu" id="menu" value="" class="input ui-corner-all" />
                    </div>
                </div>

                <div class="fila">
                    <div class="label">
                        Orden
                    </div>

                    <div class="valor">
                        <g:select from="${1..20}" name="orden" id="orden"
                                  class="input ui-corner-all" />
                    </div>
                </div>

                <div class="fila">
                    <div class="label">
                        Layout P&aacute;gina:
                    </div>

                    <div class="valor">
                        <g:select id="cmbLayoutPag" name="cmbLayoutPag" from="${layoutsPag}" optionKey="id"
                                  optionValue="nombre" class="input ui-corner-all required"
                                  noSelection="['':'-Seleccione-']" />
                    </div>
                </div>

            </div>
        </g:form>

        <div id="divLayout" style="position: relative; width: 100%; height: 1000px;"></div>
        <script type="text/javascript">
            $(function() {

                $("#guardar").click(function() {
                    $("[name=frmTipoPag]").submit();
                });

                $("[name=frmTipoPag]").validate({
                            messages: {
                                nombre: "Ingrese el nombre",
                                descripcion: "Ingrese la descripción",
                                cmbLayouts: "Seleccione un layout",
                                nombrePag: {
                                    required: "Ingrese el nombre de la página",
                                    nowhitespace: "No ingrese espacios en blanco"
                                }
                            }
                        });

                $("#cmbLayouts, #cmbLayoutPag").change(function() {
                    $.ajax({
                                type: "POST",
                                url: "${createLink(action: 'getLayout')}",
                                data: {
                                    id: $(this).val()
                                },
                                success: function(msg) {
                                    $("#divLayout").html(msg);
                                }
                            });
                });
            });
        </script>
    </body>
</html>