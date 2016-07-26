<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 3/24/14
  Time: 11:40 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro</title>
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'tedein_favicon.png')}" type="image/x-icon"/>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.4.2.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.5.custom.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'interface.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/validation/localization', file: 'messages_es.js')}"></script>
        <link href="${resource(dir: 'css', file: 'style.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/jquery/css/dark-hive', file: 'jquery-ui-1.8.5.custom.css')}" rel="stylesheet"/>

        <style type="text/css">
        html, body {
            background : #EEE;
            font-size  : 10pt;
        }

        fieldset {
            background : #eee;
            margin     : 20px;
        }

        .row {
            padding     : 5px;
            margin-left : 20px;
            min-height  : 30px;
        }

        .label {
            width       : 90px;
            font-weight : bold;
            height      : 25px;
            line-height : 25px;
        }

        /*etiqueta*/
        .etiqueta-container {
            position : relative;
            border   : 1px solid white;
        }

        .etiqueta-svt {
            width         : 94%;
            height        : 40px;
            line-height   : 40px;
            color         : #ffffff;
            background    : #0088CC;
            margin-top    : 10px !important;
            margin-bottom : 10px;
            padding-left  : 3%;
            font-weight   : bold;
            font-family   : Arial, Helvetica, Sans-serif;
            font-size     : 18px;
        }

        .etiqueta-svt:before, .etiqueta-svt:after {
            position : absolute;
            content  : "";
            width    : 0px;
            height   : 0px;
        }

        .etiqueta-svt:before {
            width      : 30px;
            left       : -29px;
            top        : 10px;
            height     : 40px;
            background : #0088CC;
        }

        .etiqueta-svt:after {
            left         : -29px;
            top          : 50px;
            border-width : 10px 0px 0px 29px;
            border-style : solid;
            border-color : #666 transparent;
        }

        .cuadro {
            width      : 550px;
            /*height     : 550px;*/
            margin     : 60px;
            margin-top : 20px;
            border     : 1px solid black;
            background : #FFC766;
        }

        input, textarea {
            border        : none;
            padding       : 5px;
            border-right  : 1px solid #0088CC;
            border-bottom : 1px solid #0088CC;
        }

        input {
            height : 25px;
        }

        .etiqueta-svt-right {
            width         : 94%;
            height        : 40px;
            line-height   : 40px;
            color         : #ffffff;
            background    : #0088CC;
            margin-top    : 10px !important;
            margin-bottom : 10px;
            padding-left  : 3%;
            font-weight   : bold;
            font-family   : Arial, Helvetica, Sans-serif;
            font-size     : 18px;
            float         : right;
        }

        .etiqueta-svt-right:before, .etiqueta-svt-right:after {
            position : absolute;
            content  : "";
            width    : 0px;
            height   : 0px;
        }

        .etiqueta-svt-right:before {
            width      : 30px;
            right      : -29px;
            bottom     : 21px;
            height     : 40px;
            background : #0088CC;
        }

        .etiqueta-svt-right:after {
            right        : -29px;
            bottom       : 11px;
            border-width : 10px 29px 0px 0px;
            border-style : solid;
            border-color : #666 transparent;
        }

        .boton {
            height          : 20px;
            width           : 75px;
            color           : white;
            background      : #0088CC;
            padding         : 10px;
            text-decoration : none;
            text-align      : center;
            font-size       : 15px;
            float           : right;
            margin          : 10px 11px 0 0;
        }

        .boton:hover {
            background : #2697CF;
        }

        .field.required:after {
            font-size : 16px;
            color     : #319F48;
            content   : "*";
        }

        .mensaje {
            padding   : 10px 20px 20px 20px;
            font-size : 11pt;
        }

        .error {
            color     : #850004;
            font-size : 12px;
        }

        input.error {
            border-bottom : 2px solid #850004;
            border-right  : 2px solid #850004;
        }

        label.error {
            padding-left : 10px;
        }
        </style>
    </head>

    <body>

        <div class="cuadro etiqueta-container ui-corner-all">
            <div class="etiqueta-svt ui-corner-right ">Registro exitoso</div>

            <div class="mensaje">
                <p>
                    Gracias por su registro.
                </p>

                <p>
                    Se ha guardado su información y será contactado vía telefónica o por e-mail para completar su inscripción.
                </p>

                <p>
                    Puede cerrar esta ventana.
                </p>
            </div>

            <div class="row" style="text-align: center; height: 60px;">
                <a href="#" class="boton ui-corner-all" id="btnCerrar">Cerrar</a>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $("#btnCerrar").click(function () {
                    window.close();
                });
            });
        </script>

    </body>
</html>