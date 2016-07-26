<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 8/22/11
  Time: 8:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>
            Videos
        </title>
    </head>

    <body>

        <div class="dialog" title="Informaci&oacute;n importante">
            Para hacer uso de este servicio debe poseer una cuenta en YouTube o Google
            y autorizar a esta aplicaci&oacute;n el acceso.<br/><br/>
            Si no tiene una cuenta puede crear una
            <a href="http://www.youtube.com/create_account" target="_blank">AQU&Iacute;</a><br/><br/>
            <a href="${auth}">
                Haga click aqu&iacute; para continuar
            </a>
        </div>

        <script type="text/javascript">
            $(function() {
                $(".dialog").dialog({
                    autoOpen: true,
                    resizable: false,
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close").remove();
                    }
                });
            });
        </script>

    </body>
</html>