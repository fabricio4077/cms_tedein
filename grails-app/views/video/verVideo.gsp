<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 8/22/11
  Time: 10:28 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'swfobject.js')}"></script>
        <title>Video</title>
    </head>

    <body>
        <g:if test="${params.status == 200 || params.status == '200' || params.status == 600 || params.status == '600'}">
            <div class="dialog" title="Video">
                <p>
                    <g:if test="${params.status == 200 || params.status == '200'}">
                        Su video ha sido subido a YouTube exitosamente.<br/>
                        Espere un momento si desea visualizarlo.
                    </g:if>
                    <g:if test="${params.status == 600 || params.status == '600'}">
                        Su video ha sido actualizado exitosamente.<br/>
                        Espere un momento si desea visualizarlo.
                    </g:if>
                </p>

                <div class="player">
                    <div id="ytapiplayer">
                        Necesita Flash player 8+ y tener JavaScript activado para ver este video.
                    </div>
                </div>
            </div>

            <script type="text/javascript">

                var ytplayer;

                function loadVideo(id) {
                    var params = { allowScriptAccess: "always" };
                    var atts = { id: "myytplayer" };
                    swfobject.embedSWF("http://www.youtube.com/e/" + id + "?enablejsapi=1&playerapiid=ytplayer",
                            "ytapiplayer", "${size.w}", "${size.h}", "8", null, null, params, atts);
                }

                loadVideo('${params.id}');

                $(function() {
                    $(".dialog").dialog({
                        autoOpen: true,
                        resizable: true,
                        width: 460,
                        position: [15,15],
                        open: function(event, ui) {
                            $(".ui-dialog-titlebar-close").remove();
                        },
                        buttons: {
                            "Terminar": function() {
                                var nombre = $("#seccion").val() + "Contenido"
                                var elem = $(window.opener.document.getElementsByClassName("frmEditarPagina"));

                                elem.submit()
                                window.close()
                            }
                        }
                    });
                });

            </script>
        </g:if>
    </body>
</html>