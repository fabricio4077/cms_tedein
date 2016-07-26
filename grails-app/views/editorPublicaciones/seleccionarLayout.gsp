<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/25/11
  Time: 3:30 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame" />
        <title>CMS - NTH</title>
    </head>

    <body>
        Seleccione un layout para <strong>${tipoPagina.nombre}</strong>: <g:select id="cmbLayouts" from="${layouts}"
                                                                                   optionKey="id"
                                                                                   optionValue="nombre" />
        <div id="divLayout"></div>

        <script type="text/javascript">
            $(function() {
                $("#cmbLayouts").change(function() {
                    //console.log($(this).val());
                    $.ajax({
                                type: "POST",
                                url: "${createLink(action: 'getLayout')}",
                                data: {
                                    id: $(this).val()
                                },
                                success: function(msg) {
                                    $("#divLayout").html(msg);
                                }
                            });
                });
            });
        </script>

    </body>
</html>