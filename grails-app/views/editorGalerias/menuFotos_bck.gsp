<style type="text/css">
.menu {
    margin-top : 15px;
    text-align : center;
}

.todoMenu {
    width      : 140px;
    margin     : 5px;
    text-align : center;
}
</style>

<div class="todoMenu">
    <g:link class="boton" action="nuevaGaleria" params="[tipo: 'Fotos']" target="contenido">
        Crear nueva
    </g:link>

    <div class="menu ui-widget-header ui-corner-all" style="min-height: 350px;">
        <ul style="min-height: 315px;">
            <g:each in="${galerias}" var="gal">
                <li style="width: 138px; min-height: 30px;">
                    <div style="margin-top:5px; min-height:30px;">
                        <a href="${createLink(action: 'addPhotos', controller: 'editor', params: ['id': gal.id, 'add': false])}" class="boton" target="contenido">
                            ${gal.nombre}
                        </a>
                    </div>
                </li>
            </g:each>
        </ul>
    </div>

    <div style="margin-top: 10px;">
        <button class="prev">Anterior</button>
        <button class="next">Siguiente</button>
        <div id="pags"><span id="start">1</span> a <span id="top">${Math.min(10, galerias.size())}</span> de <span id="max">${galerias.size()}</span></div>
        <div id="visible" class="ui-helper-hidden">10</div>
    </div>
</div>

<script type="text/javascript">
    $(function() {
        var start = parseInt($("#start").text());
        var top = parseInt($("#top").text());
        var max = parseInt($("#max").text());

        var scroll = 1;

        $(".menu").jCarouselLite({
            btnNext: ".next",
            btnPrev: ".prev",
            vertical: true,
            visible: 10,
            scroll: scroll,
            circular: false
        });

        $(".boton").button();

        $(".prev").button({
            icons: {
                primary: "ui-icon-circle-triangle-w"
            },
            text: false
        }).click(function() {
            start -= scroll;
            top -= scroll;

            if (start >= 1) {
                $("#start").text(start);
                $("#top").text(top);
            } else {
                top += scroll;
                start += scroll;
            }
        });

        $(".next").button({
            icons: {
                primary: "ui-icon-circle-triangle-e"
            },
            text: false
        }).click(function() {
            start += scroll;
            top += scroll;

            if (top <= max) {
                $("#start").text(start);
                $("#top").text(top);
            } else {
                top -= scroll;
                start -= scroll;
            }
        });
    });
</script>