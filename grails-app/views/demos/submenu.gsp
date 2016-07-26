<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/29/11
  Time: 10:49 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<meta name="layout" content="frame"/>
<head>
    <title>Simple GSP page</title>
    <style type="text/css">
    .submenu {
        display: none;
    }

    .botones {
        background: rgba(100, 100, 100, 0.8);
        height: 200px;
        overflow-x: hidden;
        overflow-y: auto;
        padding: 10px 0 10px 0;
    }

    .todoMenu {
        width: 200px;
        height: 400px;
        padding: 10px;
    }

    .current {
        display: block;
    }

    .boton {
        width: 150px;
        margin-bottom: 10px;
    }

    .volver {
        margin: 10px 0 0 0;
    }

    .new {
        margin: 0 0 20px 0;
    }
    </style>
</head>
<body>
<div class="todoMenu ui-widget-content ui-corner-all">
    <div id="galerias" class="submenu  current">
        <h3>Galer&iacute;as</h3>
        <a href="#" class="boton" target="fotos">Fotos</a>
        <a href="#" class="boton" target="videos">Videos</a>
        <a href="#" class="boton" target="contenido">Contenido</a>
    </div>

    <div id="fotos" class="submenu ">
        <h3>Fotos</h3>
        <a href="#" class="boton new">Crear nuevo</a>

        <div class="botones ui-corner-all">
            <g:each in="${1..4}">
                <a href="#" class="boton" target="none">
                    Fotos ${it}
                </a>
            </g:each>
        </div>

        <a href="#" class="boton volver" target="galerias">Regresar</a>
    </div>

    <div id="videos" class="submenu ">
        <h3>Videos</h3>
        <a href="#" class="boton new">Crear nuevo</a>

        <div class="botones ui-corner-all">
            <g:each in="${1..10}">
                <a href="#" class="boton" target="none">
                    Videos ${it}
                </a>
            </g:each>
        </div>

        <a href="#" class="boton volver" target="galerias">Regresar</a>
    </div>

    <div id="contenido" class="submenu ">
        <h3>Contenido</h3>

        <a href="#" class="boton new">Crear nuevo</a>

        <div class="botones ui-corner-all">
            <g:each in="${1..10}">
                <a href="#" class="boton" target="none">
                    Contenido ${it}
                </a>
            </g:each>
        </div>

        <a href="#" class="boton volver" target="galerias">Galer&iacute;as</a>
    </div>

</div>

<script type="text/javascript">
    $(function() {
        $(".botonGal").button();
        $(".boton").css("font-size", "13px")
                .button()
                .click(function() {
            var target = $(this).attr("target");
            if (target != "none") {
                $(this).parent().removeClass("current").hide("slide", 500, function() {
                    $("#" + target).show("slide", 500).addClass("current");
                    $(".boton").removeClass("ui-state-active ui-state-focus ui-state-hover");
                });
            }
            return false;
        });

        $(".new").button("option", "icons", {primary:'ui-icon-document'});

        $(".volver").button("option", "icons", {primary:'ui-icon-triangle-1-w'});
    });
</script>
</body>
</html>