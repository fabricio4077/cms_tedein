<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/30/11
  Time: 12:05 PM
  To change this template use File | Settings | File Templates.
--%>

<div class="todoMenu">

    <div id="main" class="menuContainer">
        ${linkNuevo}

        <div class="menu ui-corner-all" style="height: ${linkNuevo ? 320 : 370}px;">
            <g:each in="${lista}">
                <a href="${it.link}" id="${it.id}" class="boton ${it.clase}" target="${it.target}"
                   toggle="${it.toggle}">
                    ${it.nombre}
                </a>
            </g:each>
        </div>
    </div>

    <g:if test="${submenus.size() > 0}">
        <g:each in="${submenus}" var="submenu">
            <div id="${submenu.key}" class="menuContainer ui-helper-hidden">
                <h4 class="tituloSubmenu">${submenu.key}</h4>
                ${submenu.value.linkNuevo}
                <div class="menu menu_${submenu.key} ui-corner-all"
                     style="height: 280px; position: relative;">
                    <g:each in="${submenu.value.lista}" var="item">
                        <a href="${item.link}" id="${item.id}" class="boton ${item.clase}" target="${item.target}"
                           toggle="${item.toggle}">
                            ${item.nombre}
                        </a>
                    </g:each>
                </div>

                <a href="#" class="boton volver noLink" target="main" toggle="main">Regresar</a>
            </div>
        </g:each>
    </g:if>
</div>


<script type="text/javascript">
    $(function() {
        $(".botonGal").button();

        $(".boton").button();

        $(".noLink").click(function() {
            var target = $(this).attr("toggle");
            if ($(this).hasClass("volver")) {
                $("#contenido").attr("src", "");
            }
            if (target != "none") {
                $(this).parents(".menuContainer").hide("blind", 500, function() {
                    $("#" + target).show("blind", 500);
                    $(".boton").removeClass("ui-state-active ui-state-focus ui-state-hover");
                });
            }
            var href = $(this).attr("href")
            if(href != "") {
                var tar = $(this).attr("target")
                $("#"+tar).attr("src", href);
            }
            return false;
        });

        $(".new").button("option", "icons", {primary:'ui-icon-document'});

        $(".volver").button("option", "icons", {primary:'ui-icon-triangle-1-w'});
    });
</script>