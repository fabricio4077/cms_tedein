<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 3/24/14
  Time: 3:56 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Personas inscritas</title>
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
            float       : left;
        }

        .field {
            float : left;
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

        .boton {
            /*height          : 20px;*/
            width           : 75px;
            color           : white;
            background      : #0088CC;
            padding         : 5px 10px;
            text-decoration : none;
            text-align      : center;
            font-size       : 15px;
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

        .todo {
            margin : 15px;
        }

        .lista {
            width : 680px;
        }

        table {
            width           : 100%;
            border-collapse : collapse;
        }

        td, th {
            padding : 5px;
        }
        </style>
    </head>

    <body>
        <div class="todo">
            <div class="row">
                <div class="label">Curso:</div>

                <div class="field" style="width: 210px;">
                    <g:select name="curso.id" id="curso" optionKey="id" optionValue="nombre"
                              from="${nth.externos.Curso.list([sort: 'nombre'])}" class="ui-corner-all"
                              style="width:187px;display: inline"/>
                </div>

                <div class="label">Estado:</div>

                <div class="field">
                    <g:select name="estado" optionKey="key" optionValue="value"
                              from="['-1': 'Todos', '1': 'Contactados', '0': 'No contactados']" class="ui-corner-all"
                              style="width:130px;display: inline"/>
                </div>

                <div class="field" style="margin-left: 10px;">
                    <a href="#" class="boton ui-corner-all" id="btnVer" style="display: inline">Ver</a>
                </div>

            </div>

            <div class="lista" id="lista">

            </div>
        </div>

        <script type="text/javascript">
            function reloadTabla() {
                $("#lista").html("CARGANDO....");
                var curso = $("#curso").val();
                var estado = $("#estado").val();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'tablaInscritos')}",
                    data    : {
                        curso  : curso,
                        estado : estado
                    },
                    success : function (msg) {
                        $("#lista").html(msg);
                    }
                });
            }
            $(function () {
                reloadTabla();
                $("#btnVer").click(function () {
                    reloadTabla();
                    return false;
                });
            });
        </script>

    </body>
</html>