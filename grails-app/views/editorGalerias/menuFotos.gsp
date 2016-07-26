<div class="todoMenu">
    <g:link class="boton" action="nuevaGaleria" params="[tipo: 'Fotos']" target="contenido">
        Crear nueva
    </g:link>

    <div class="menu ui-corner-all" style="height: 350px; overflow: auto; width:160px;">
       <ul style="min-height: 315px; list-style: none; margin:0; padding:0;">
            <g:each in="${galerias}" var="gal">
                <li style="width: 138px; min-height: 30px;" id="btn_gal_${gal.id}">
                    <div style="margin-top:5px; min-height:30px;">
                        <g:if test="${gal.tipo=='Fotos'}">
                            <a href="${createLink(action: 'addPhotos', params: ['id': gal.id, 'add': false])}" class="boton" target="contenido">
                                ${gal.nombre}
                            </a>
                        </g:if>
                        <g:if test="${gal.tipo=='Texto'}">
                            <a href="${createLink(action: 'addCont', params: ['id': gal.id, 'add': false])}" class="boton" target="contenido">
                                ${gal.nombre}
                            </a>
                        </g:if>
                    </div>
                </li>
            </g:each>
        </ul>
    </div>

    %{--<div style="margin-top: 10px;">--}%
        %{--<button class="prev">Anterior</button>--}%
        %{--<button class="next">Siguiente</button>--}%
        %{--<div id="pags"><span id="start">${galerias.size()}</span> a <span id="top">${Math.min(10, galerias.size())}</span> de <span id="max">${galerias.size()}</span></div>--}%
        %{--<div id="visible" class="ui-helper-hidden">10</div>--}%
    %{--</div>--}%
</div>

<script type="text/javascript">
//    var start = parseInt($("#start").text());
//    var top = parseInt($("#top").text());
//    var max = parseInt($("#max").text());
//
//    var scroll = 1;

    <g:if test="${galerias.size() > 0}">
//    $(function() {
//        $(".menu").jCarouselLite({
//            btnNext: ".next",
//            btnPrev: ".prev",
//            vertical: true,
//            visible: 10,
//            scroll: scroll,
//            circular: false
//        });
//    });
    </g:if>

    $(function() {
        $(".boton").button();

//        $(".prev").button({
//            icons: {
//                primary: "ui-icon-circle-triangle-w"
//            },
//            text: false
//        }).click(function() {
//            start -= scroll;
//            top -= scroll;
//
//            if (start >= 1) {
//                $("#start").text(start);
//                $("#top").text(top);
//            } else {
//                top += scroll;
//                start += scroll;
//            }
//        });
//
//        $(".next").button({
//            icons: {
//                primary: "ui-icon-circle-triangle-e"
//            },
//            text: false
//        }).click(function() {
//            start += scroll;
//            top += scroll;
//
//            if (top <= max) {
//                $("#start").text(start);
//                $("#top").text(top);
//            } else {
//                top -= scroll;
//                start -= scroll;
//            }
//        });
    });
</script>