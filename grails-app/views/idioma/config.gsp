<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 3/4/12
  Time: 1:31 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Configurar selector de idioma</title>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>

        <style type="text/css">
        table {
            border-collapse : collapse;
        }

        tr {
            cursor : pointer;
        }

        .bs {
            cursor : default;
        }

        .selected {
            background : #5f5f5f;
            color      : #f5f5f5;
        }

        .hovering {
            background : #aaaaaa;
        }
        </style>
    </head>

    <body>
        <h3>
            Configuraci&oacute;n del selector de idioma
        </h3>

        <form id="frmConfigIdioma">

            <g:hiddenField name="id" value="${layout.id}"/>

            <table border="1" cellpadding="4">
                <tr id="select" class="${tipo == 'select' ? 'selected' : ''}">
                    <td>Desplegable</td>
                    <td>
                        <g:mostrarIdiomas tipo="editor" tipoIdioma="select"/>
                    </td>
                    <td>
                        <input type="radio" name="tipo" value="select" ${tipo == 'select' ? 'checked' : ''}/>
                    </td>
                </tr>
                <tr id="links" class="${tipo == 'links' ? 'selected' : ''}">
                    <td>Links: solo texto sin imagen</td>
                    <td>
                        <g:mostrarIdiomas tipo="editor" tipoIdioma="links"/>
                    </td>
                    <td>
                        <input type="radio" name="tipo" value="links" ${tipo == 'links' ? 'checked' : ''}/>
                    </td>
                </tr>
                <tr id="imagen" class="${tipo == 'imagen' ? 'selected' : ''}">
                    <td>Links: solo imagen</td>
                    <td>
                        <g:mostrarIdiomas tipo="editor" tipoIdioma="imagen"/>
                    </td>
                    <td>
                        <input type="radio" name="tipo" value="imagen" ${tipo == 'imagen' ? 'checked' : ''}/>
                    </td>
                </tr>
                <tr id="linksImagen" class="${tipo == 'linksImagen' ? 'selected' : ''}">
                    <td>Links: texto con imagen</td>
                    <td>
                        <g:mostrarIdiomas tipo="editor" tipoIdioma="linksImagen"/>
                    </td>
                    <td>
                        <input type="radio" name="tipo" value="linksImagen" ${tipo == 'linksImagen' ? 'checked' : ''}/>
                    </td>
                </tr>
                <tr class="bs">
                    <td colspan="3">
                        <a href="#" id="btnSave">Guardar</a>
                    </td>
                </tr>
            </table>
        </form>
        %{--<div id="config" title="Configuraci&oacute;n">--}%
        %{--</div>--}%

        <script type="text/javascript">
            $(function () {

                $("#btnSave").button({
                    icons:{
                        primary:"ui-icon-disk"
                    }
                }).click(function () {
                            $.ajax({
                                url:"${createLink(action: 'saveConfig')}",
                                data:$("#frmConfigIdioma").serialize(),
                                success:function (msg) {
                                    console.log(msg);
                                    if (msg == "OK") {
                                        window.opener.location.reload(true);
                                        window.close();
                                    }
                                }
                            });
                            return false;
                        });

                $("#links").data("link", ${cssLink});
                $("#links").data("visited", ${cssVisited});
                $("#links").data("active", ${cssActive});
                $("#links").data("hover", ${cssHover});
                $("#links").data("actual", ${cssActual});

//                $("#config").dialog({
//                    position:[370, 40]
//                });

                $("tr").not(".bs").hover(
                        function () {
                            $(this).addClass("hovering");
                        },
                        function () {
                            $(this).removeClass("hovering");
                        }).click(function () {
                            $(".selected").removeClass("selected");
                            $(this).addClass("selected");
                            $(this).find("input").attr("checked", true);
                        });
            });
        </script>

    </body>
</html>