<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 8/22/11
  Time: 9:57 PM
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
        <div class="dialog" title="Subir video">
            <form action="${post_url}?nexturl=${appUrl + createLink(action: 'guardarVideo')}" method="post"
                  enctype="multipart/form-data" class="frm">
                <input type="file" name="file"/>
                <input type="hidden" name="token" value="${token_value}"/>
            </form>
        </div>

        <div class="msj" title="Espere...">
            <p>
                Por favor espere mientras se procesa su video
            </p>

            <p style="text-align: center;">
                <img src="${resource(dir: 'images', file: 'ajax-loader.gif')}" alt="Cargando...">
            </p>
        </div>

        <script type="text/javascript">
            $(function() {

                $(".msj").dialog({
                    autoOpen: false,
                    resizable:false,
                    modal:true,
                    draggable:false,
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close").remove();
                    }
                });

                $(".dialog").dialog({
                    autoOpen: true,
                    resizable:false,
                    modal:false,
                    draggable:false,
                    width:470,
                    position: [15,15],
                    buttons: {
                        "Guardar": function() {
                            $(".msj").dialog("open");
                            $(".frm").submit();
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