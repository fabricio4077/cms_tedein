<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 8/22/11
  Time: 4:26 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.tag-it.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins', file: 'jquery.ui.autocomplete.custom.css')}" rel="stylesheet"
              type="text/css"/>
        <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>

        <title>Upload video</title>
    </head>

    <body>
        <div class="dialog" title="Informaci&oacute;n del video">
            <g:form name="frm" class="frm" action="subirVideo">

                <div class="fila" style="margin-bottom:10px;">
                    <div class="smallLabel" style="text-align:right">T&iacute;tulo:</div>

                    <div class="valor" style="text-align:left;float:left">
                        <g:textField name="title" class="ui-corner-all"/>
                    </div>
                </div>

                <div class="fila" style="margin-bottom:10px;">
                    <div class="smallLabel" style="text-align:right">Categor&iacute;a:</div>

                    <div class="valor" style="text-align:left;float:left">
                        <select name="category" id="category" class="ui-corner-all">
                            <option selected="" value="Autos">Automovilismo</option>
                            <option value="Comedy">Comedia</option>
                            <option value="Education">Educación</option>
                            <option value="Entertainment">Entretenimiento</option>
                            <option value="Film">Cine y Animaciones</option>
                            <option value="Games">Juego</option>
                            <option value="Howto">Instructivos y Estilo</option>
                            <option value="Music">Música</option>
                            <option value="News">Noticias y política</option>
                            <option value="Nonprofit">ONGs/Activismo</option>
                            <option value="People">Gente y blogs</option>
                            <option value="Animals">Mascotas y Animales</option>
                            <option value="Tech">Ciencia & Tecnología</option>
                            <option value="Sports">Deportes</option>
                            <option value="Travel">Viajes y Eventos</option>
                        </select>
                    </div>
                </div>

                <div class="fila" style="margin-bottom:10px; height: 100px;">
                    <div class="smallLabel" style="text-align:right">Descripci&oacute;n:</div>

                    <div class="valor" style="text-align:left;float:left">
                        <g:textArea name="description" rows="6" cols="40" class="ui-corner-all"
                                    style="width: 250px;"></g:textArea>
                    </div>
                </div>

                <div class="fila" style="height:170px;">
                    <div class="smallLabel" style="text-align: right;">
                        Tags:
                        <g:hiddenField id="tags" name="keywords"/>
                    </div>
                    <ul style="width:238px; height:100px; float:left;" class="bckg ui-corner-all" id="mytags"></ul>
                </div>
            </g:form>
        </div>

        <script type="text/javascript">
            $(function() {
                $(".dialog").dialog({
                    autoOpen: true,
                    resizable:false,
                    modal:false,
                    draggable:false,
                    width:470,
                    position: [15,15],
                    buttons: {
                        "Regresar": function() {
                            location.href = "${createLink(action: 'opcionesVideo')}";
                        },
                        "Continuar": function() {
                            var tags = "";

                            $("#mytags li").children("span").each(function() {
                                tags += $(this).text() + " ";
                            });

                            $("#tags").val(tags);

                            $(".frm").submit();
                        }
                    },
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close").remove();
                    }
                });

                $("#mytags").tagit({
                    availableTags: [""]
                });
            });
        </script>
    </body>
</html>