<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <g:imports/>
        <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hoverIntent.minified.js')}"
                type="text/javascript"
                charset="utf-8"></script>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.tag-it.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins', file: 'jquery.ui.autocomplete.custom.css')}" rel="stylesheet"
              type="text/css"/>
        <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>

        <meta name="layout" content="frame"/>

        <style type="text/css" media="screen">
        * {
            margin  : 0;
            padding : 0;
        }

        body {

            padding : 0 20px;
        }

        ul li {
            display : inline;
        }

        .wide {
            border-bottom : 1px #000 solid;
            width         : 4000px;
        }

        .selected {
            border     : solid 1px #9932cc;
            background : #d8bfd8;
        }

        .valor {
            float : left;
        }

        </style>

    </head>

    <body>

        <ul id="ulMenu" class="topnav ui-corner-all"
            style="position:absolute; top:2px;z-index:9999;font    : 14px Arial, Verdana, Sans-Serif;">
            <li><a href="#" id="guardar">Guardar</a></li>
        </ul>

        <div id="fondo"
             style="height: 100%;width: 100%;background-color: rgba(0,0,0,0.5);position: absolute;top:1px;z-index: 9000;display: none;float:left"></div>
        <g:form action="guardarPagina" class="frmEditarPagina" enctype="multipart/form-data">
            <div id="worckSpace" style="position:relative;width:100%; margin-top:45px;">
                <div id="col1" style="width: 400px; float:left; height: 170px;">
                    <div class="fila">
                        <div class="celda etiqueta" style="float:left;">
                            Tipo:
                        </div>

                        <div class="valor">
                            ${tipo.nombre}
                            <g:hiddenField name="tipo" value="${tipo.id}"/>
                        </div>
                    </div>

                    <div class="fila" style="margin-bottom: 5px;">
                        <div class="celda etiqueta" style="float:left;">
                            Nombre:
                        </div>

                        <div class="valor">
                            <g:textField name="nombre" id="nombre" value="" class="input ui-corner-all required"/>
                        </div>
                    </div>

                    <div class="fila" style="margin-bottom: 5px;">
                        <div class="celda etiqueta" style="float:left;">
                            Imagen:
                        </div>

                        <div class="valor">
                            <input type="file" name="data" id="data" value="" class="input ui-corner-all required"/>
                        </div>
                    </div>

                    <div class="fila" style="height:170px;">
                        <div class="celda etiqueta" style="float:left;">
                            Tags:
                        </div>
                        <ul style="width:238px; height:100px; float:left;" class="bckg ui-corner-all" id="mytags"></ul>
                    </div>

                </div>

            </div>
        </g:form>

        <script type="text/javascript">
            $(function() {
                $("#guardar").click(function() {
                    $(".frmEditarPagina").submit();
                });

                $("#mytags").tagit({
                    availableTags: [""],
                    values: ""
                });
            });
        </script>
    </body>
</html>