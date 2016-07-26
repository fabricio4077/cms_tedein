<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="frame"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.tag-it.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins', file: 'jquery.ui.autocomplete.custom.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>

        <style type="text/css" media="screen">
        * {
            margin  : 0;
            padding : 0;
        }

        body {
            font    : 12px Arial, Verdana, Sans-Serif;
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
        <title>NTH</title>
    </head>
    <body>
        <div id="cuerpo">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${image}">
                <div class="errors">
                    <g:renderErrors bean="${image}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form action="saveToGal" enctype="multipart/form-data" class="frmUploader">
                <input type="hidden" value="${galeria.id}" name="galeria" id="galeria">
                <input type="hidden" value="${image?.id}" name="imagen">
                <div class="dialog">
                    <div style="width:450px;height:400px;margin-top:15px;">

                        %{--<div class="fila" style="margin-bottom:10px;">--}%
                        %{--<div class="smallLabel" style="text-align:right">Ancho:</div>--}%
                        %{--<div class="valor" style="text-align:left;float:left"><g:textField name="width" value="${image?.width}"/></div>--}%
                        %{--</div>--}%

                        %{--<div class="fila" style="margin-bottom:10px;">--}%
                        %{--<div class="smallLabel" style="text-align:right">Alto:</div>--}%
                        %{--<div class="valor" style="text-align:left;float:left"><g:textField name="height" value="${image?.height}"/></div>--}%
                        %{--</div>--}%

                        <div class="fila" style="margin-bottom:10px;">
                            <div class="smallLabel" style="text-align:right">Imagen:</div>
                            <div class="valor" style="text-align:left;float:left">
                                <input type="file" id="data" name="data"/>
                            </div>
                        </div>

                        <div class="fila" style="margin-bottom:10px;">
                            <div class="smallLabel" style="text-align:right">T&iacute;tulo:</div>
                            <div class="valor" style="text-align:left;float:left"><g:textField name="titulo" value="${titulo}"/></div>
                        </div>

                        <div class="fila" style="margin-bottom:10px;height:70px;">
                            <div class="smallLabel" style="text-align:right">Descripci&oacute;n:</div>
                            <div class="valor" style="text-align:left;float:left"><g:textArea name="descripcion">${descripcion}</g:textArea></div>
                        </div>

                        <div class="fila" style="height:170px;">
                            <div class="celda etiqueta" style="float:left;">
                                Tags:
                            </div>
                            <ul style="width:238px; height:100px; float:left;" class="bckg ui-corner-all" id="mytags"></ul>
                        </div>

                        <div class="fila" style="margin-bottom:10px;height:70px; display:none;">
                            <div class="smallLabel" style="text-align:right">Palabras clave:</div>
                            <div class="valor" style="text-align:left;float:left"><g:textField id="tags" name="tags" value="${image?.tags}"/></div>
                        </div>

                    </div>
                </div>
            </g:form>

        </div>
        <script type="text/javascript">
            /* TODO  hacer la verificacion del # de caracteres en el textfield de tags........... hacer todas las validaciones con js */
            function esperar() {
                alert("ventana ")
            }
            jQuery(function($) {

                $("#mytags").tagit({
                    availableTags: ["Galería", "Fotos"],
                    values: ${tags}
                });

                $("#descripcion").keypress(function(evt) {
                    if (evt.keyCode == 9) {
                        $(".tagit-input").focus();
                        return false;
                    }
                });

                $("#cuerpo").dialog({
                    autoOpen: true,
                    resizable:false,
                    modal:false,
                    draggable:false,
                    width:470,
                    height:550,
                    title:"Subir fotos a la galer&iacute;a ${galeria.nombre}",
                    position: [15,15],
                    buttons: {
                        "Guardar": function() {
                            var tags = "";

                            $("#mytags li").children("span").each(function() {
                                tags += $(this).text() + " ";
                            });

                            $("#tags").val(tags);

                            var titulo = $("#titulo").val();
                            var desc = $("#descripcion").val();
                            var arch = $("#data").val();

                            if (arch != "") {
                                $(".frmUploader").submit();
                            }
                        }
                    },
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close").remove();
                    }
                });
            });
        </script>
    </body>
</html>
