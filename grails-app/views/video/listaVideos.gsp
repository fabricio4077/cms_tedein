<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 8/22/11
  Time: 12:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Video Feed</title>

        <meta name="layout" content="frame"/>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'swfobject.js')}"></script>

        <style type="text/css">
        .player {
            /*position   : absolute;*/
            /*top        : 300px;*/
            /*left       : 300px;*/
            margin-left : 40px;
            width       : 425px;
            height      : 356px;
            background  : #4682b4;
        }

        .col {
            float : left;
        }

        .thumb {
            cursor : pointer;
        }

        .selected {
            border : solid 3px #C6E746;
        }

        .video {
            text-align    : center;
            background    : rgba(100, 100, 100, 0.5);
            margin-bottom : 10px;
        }

        .titulo {
            font-variant : small-caps;
            font-size    : larger;
            font-weight  : bold;
        }

        .desc {
            text-align : left;
        }
        </style>

    </head>

    <body>

        <div class="dialog" title="Lista de videos">
            <g:set var="clase"/>
            <div class="col">
                <g:each in="${videos}" status="i" var="video">
                    <g:if test="${act==video.id}">
                        <g:set var="clase" value="${'selected'}"/>
                    </g:if>
                    <g:else>
                        <g:set var="clase" value=""/>
                    </g:else>
                    <div class="video ui-corner-all ${clase}">
                        <div class="titulo">
                            ${video.title}
                        </div>

                        <div class="vThumb">
                            <img src="${video.thumbnails[0].url}" class="thumb" id="${video.id}"/>
                        </div>

                        <div class="desc">
                            ${video.description}
                        </div>
                    </div>
                </g:each>
            </div>

            <div class="col player">
                <div id="ytapiplayer">
                    Necesita tener Flash player 8+ y JavaScript activado para poder ver este video.
                </div>
            </div>

            <g:form name="frm" class="frm" action="selectVideo">
                <g:hiddenField name="video" id="video" value="${act}"/>
            </g:form>
        </div>
        <script type="text/javascript">

            var ytplayer;

            loadVideo('${act}');

            function loadVideo(id) {
                try {
                    $(".player").children().each(function() {
                        $(this).remove();
                    });
                    var div = $("<div id='ytapiplayer'>");
                    $(".player").append(div);

                    var params = { allowScriptAccess: "always" };
                    var atts = { id: "myytplayer" };
                    swfobject.embedSWF("http://www.youtube.com/e/" + id + "?enablejsapi=1&playerapiid=ytplayer",
                            "ytapiplayer", "425", "356", "8", null, null, params, atts);
                } catch(e) {
                    //console.log(e);
                }
            }

            $(function() {

                $(".dialog").dialog({
                    autoOpen: true,
                    resizable:true,
                    modal:false,
                    draggable:false,
                    width:630,
                    height:555,
                    position: [15,15],
                    buttons: {
                        "Aceptar": function() {
                            $(".frm").submit();
                        }
                    },
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close").remove();
                    }
                });

                $(".thumb").click(function() {
                    $("#video").val($(this).attr("id"));
                    $(".video").removeClass("selected");
                    $(this).parent().parent().addClass("selected");
                    loadVideo($(this).attr("id"));

                    location.href = "${createLink(action: 'listaVideos')}?video=" + $(this).attr("id");
                });
            });


        </script>

    </body>
</html>