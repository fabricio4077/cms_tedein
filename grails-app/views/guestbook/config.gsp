<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/5/11
  Time: 1:03 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Configurar guestbook</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.caret.1.02.min.js')}"></script>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/lightbox/js', file: 'jquery.prettyPhoto.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins/lightbox/css', file: 'prettyPhoto.css')}" rel="stylesheet" type="text/css"/>

        <style type="text/css">
        html {
            font-family : arial;
            font-size   : 10pt;
        }

        .tabla {
            display : table;
        }

        .filaTbl {
            display       : table-row;
            margin-bottom : 5px;
        }

        .celda {
            display : table-cell;
        }

        .label {
            font-weight : bold;
            width       : 85px;
        }

        .check {
            width : 30px;
        }

        .disabled {
            background : #666;
        }

        .editable {
            cursor : pointer;
        }

        .hover {
            background : #c6c6c6;
            color      : #000;
        }

        .area {
            border        : solid 1px black;
            margin-bottom : 10px;
            padding       : 5px;
        }

        .add {
            font-size     : 10px;
            line-height   : 10px;
            margin-bottom : 10px;
        "
        }

        .comentario {
            border        : solid 1px #999;
            margin-bottom : 5px;
            padding       : 3px;
            min-height    : 150px;
        }

        .nombre, .mail, .url, .fecha {
            margin-bottom : 3px;
        }

        .nombre {
            padding-left : 10px;
        }

        .fecha {
            font-size     : smaller;
            font-style    : italic;
            text-align    : right;
            float         : right;
            padding-right : 10px;
            color         : white;
        }

        .texto {
            background : #ddd;
            width      : 610px;
            float      : right;
            margin-top : 5px;
            padding    : 5px;
            color      : #000;
        }

        .label {
            color       : #eee;
            font-weight : bold;
        }

        .foto {
            border        : 2px solid #000000;
            border-radius : 5px 5px 5px 5px;
            float         : left;
            line-height   : 0;
            padding       : 2px;
            height        : 75px;
            width         : 120px;
            text-align    : center;
            background    : #f5f5f5;
            margin-top    : 5px;
        }


        </style>

    </head>

    <body>
        <h3>
            Configuraci&oacute;n del guestbook (${session.idioma.nombre})
        </h3>

        <fieldset class="ui-widget-content ui-corner-all">
            <legend class="ui-widget-content ui-corner-all">Campos</legend>
            <a href="#" id="btnSave" style="margin-bottom:10px;">Guardar</a>
            ${ul}
        </fieldset>

        <fieldset class="ui-widget-content ui-corner-all">
            <legend class="ui-widget-content ui-corner-all">Comentarios</legend>

            <div id='comentarios'>
                <g:each in="${comentarios}" var="com">
                    <gbk:displayItem id="${com.id}" edit="${true}"/>
                </g:each>
            </div>

        </fieldset>


        <script type="text/javascript">

            function guardar(elem) {
//                console.log(elem);
                elem.each(function () {
                    var text = $(this).val();
                    $(this).parent().html(text);
                });
            }

            function siguiente(elem) {

            }

            function anterior(elem) {

            }

            $(function () {

                $("#btnSave").button({
                    icons:{
                        primary:"ui-icon-disk"
                    }
                }).click(function () {
                            guardar($(".editando"));
                            var str = "";
                            $(".editable").each(function () {
                                var id = $(this).attr("id");
                                var tipo = $(this).attr("tipo");
                                var txt = trim($(this).text());
                                var orden = trim($(this).next().text());
                                var tag = trim($(this).attr("tag"));
                                if (str != "") {
                                    str += "&"
                                }
                                str += "item=" + id + "^" + tipo + "^" + txt + "^" + orden + "^" + tag;
                            });
                            console.log(str);
                            //TODO: REVISAR ESTO!!!!
                            str += "&seccion=${seccion.id}";
                            $.ajax({
                                type:"POST",
                                url:"${createLink(action:"saveConfig")}",
                                data:str,
                                success:function (msg) {
                                    if (msg == "OK") {
                                        if (confirm("Se ha guardado correctamente. Desea cerrar la ventana?")) {
                                            window.close();
                                        }
                                    } else {
                                        alert("Ha ocurrido un error!");
                                    }
                                }
                            });

                            return false;
                        });

                $(".editable").hover(
                        function () {
                            $(this).addClass("hover");
                        },
                        function () {
                            $(this).removeClass("hover");
                        }).click(function () {

                            guardar($(".editando"));

                            var texto = $(this).text();
                            var field = $("<input type='text' class='editando' value='" + texto + "'>");
                            if ($(this).hasClass("order")) {
                                field.css({
                                    width:30
                                });
                            }
                            field.keypress(function (evt) {
                                if (evt.keyCode == 9 || evt.keyCode == 13) {
                                    guardar($(this));
                                    evt.preventDefault();
                                    return false;
                                }
//                                switch (evt.keyCode) {
//                                    case 9: //tab
//                                        guardar($(this));
//                                        if (evt.shiftKey) {
//                                            //anterior
//                                            anterior($(this));
//                                        } else {
//                                            //siguiente
//                                            siguiente($(this));
//                                        }
//                                        evt.preventDefault();
//                                        return false;
//                                        break;
//                                    case 13: //enter
//                                        //siguiente
//                                        guardar($(this));
//                                        siguiente($(this));
//                                        evt.preventDefault();
//                                        return false;
//                                        break;
//                                    case 40: // abajo
//                                        //siguiente
//                                        guardar($(this));
//                                        siguiente($(this));
//                                        evt.preventDefault();
//                                        return false;
//                                        break;
//                                    case 38: //arriba
//                                        //anterior
//                                        guardar($(this));
//                                        anterior($(this));
//                                        evt.preventDefault();
//                                        return false;
//                                        break;
//                                    default:
//                                        break;
//                                }
                            });
                            $(this).html(field);
                            field.caret({start:texto.length, end:texto.length});
                        });
            });
        </script>

    </body>
</html>