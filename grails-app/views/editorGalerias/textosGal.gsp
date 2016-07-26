%{--<script type="text/javascript" src='${g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.easing.1.3.js")}'></script>--}%
%{--<script type="text/javascript" src='${g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.galleryview-3.0.js")}'></script>--}%
%{--<script type="text/javascript" src='${g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.timers-1.2.js")}'></script>--}%
%{--<link href='${g.resource(dir: "js/jquery/plugins/galleryview/css", file: "jquery.galleryview-3.0.css")}' rel="stylesheet" type="text/css"/>--}%

<style type="text/css">
#selectable .ui-selecting {
    background : #FECA40;
}

#selectable .ui-selected {
    background : #F39814; /*color      : white;*/
}

</style>

<ul id="selectable">
    <g:each in="${pags}" var="pagina" status="i">
        <li>
            <div id="pagina_${pagina.id}" class="gv-panel-content" style="width:${pagina.layout.contenido.width}px; height:${pagina.layout.contenido.height}px; position:relative; border:solid 1px black; float: left; margin: 3px;">
                <g:each in="${pagina.secciones}" var="seccion">
                    <g:mostrarSeccion tipo="Borrador" idioma="6" id="${seccion.id}"/>
                </g:each>
            </div>
        </li>
    </g:each>
</ul>

<script type="text/javascript">
    $(function() {

        $("#selectable").selectable({
            filter: '.panel-content'
        });

//        $('#myGallery').galleryView({
//            panel_width: 1024,
//            panel_height: 768,
//            frame_width: 60,
//            frame_height: 60,
//            pause_on_hover: true,
//            panel_scale: 'nocrop',
//            show_overlays: false,
////                    transition_interval: 60,
//            filmstrip_size: 4,
//            panel_animation: "slide",
//            pointer_size: 20
//        });
    });
</script>