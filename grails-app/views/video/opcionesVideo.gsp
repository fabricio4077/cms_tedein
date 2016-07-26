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
            Puede subir un nuevo video desde su computadora directamente a YouTube para agregarlo a su p&aacute;gina
        o puede escoger un video ya guardado en su cuenta de YouTube.

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
                            "Subir video": function() {
                                location.href = "${createLink(action: 'datosVideo')}";
                            },
                            "Ver videos": function() {
                                location.href = "${createLink(action: 'listaVideos')}";
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