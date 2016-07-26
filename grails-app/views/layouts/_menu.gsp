<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jCarouselLite.js')}"></script>

<!-- Optional -->
<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.easing.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.mousewheel.min.js')}"></script>

<!--bottom dock -->
<div class="dock" id="dock2">
    <div class="dock-container2 ui-corner-all">
        <a class="dock-item2" id="layout" href="#">
            <span>Layouts</span>
            <img src="${resource(dir: 'images/menu', file: 'layouts.png')}" alt="layouts"/>
        </a>
        <a class="dock-item2" id="pagina" href="#">
            <span>P&aacute;ginas</span>
            <img src="${resource(dir: 'images/menu', file: 'paginas.png')}" alt="páginas"/>
        </a>
        <a class="dock-item2" id="publicaciones" href="#">
            <span>Publicaciones</span>
            <img src="${resource(dir: 'images/menu', file: 'articulos.png')}" alt="video"/>
        </a>
        <a class="dock-item2" id="fotos" href="#">
            <span>Galer&iacute;as</span>
            <img src="${resource(dir: 'images/menu', file: 'fotos.png')}" alt="contact"/>
        </a>
        %{--<a class="dock-item2" id="videos" href="#"><span>Galer&iacute;as de Videos</span><img src="${resource(dir: 'images/menu', file: 'videos.png')}" alt="portfolio"/></a>--}%
        <a class="dock-item2" id="guestbook" href="${createLink(controller: 'guestbook', action: 'config')}" target="contenido">
            <span>Guestbook</span>
            <img src="${resource(dir: 'images/menu', file: 'guestbook.png')}" alt="music"/>
        </a>
        %{--<a class="dock-item2" id="eventos" href="#"><span>Eventos</span><img src="${resource(dir: 'images/menu', file: 'eventos.png')}" alt="history"/></a>--}%
        <a class="dock-item2" id="idioma_menu" href="#">
            <span>Idiomas</span>
            <img src="${resource(dir: 'images/menu', file: 'idiomas.png')}" alt="calendar"/>
        </a>
        <a class="dock-item2" id="menu" href="${createLink(controller: 'menu', action: 'mostrarTodos')}" target="contenido">
            <span>Men&uacute;</span>
            <img src="${resource(dir: 'images/menu', file: 'menu.png')}" alt="links"/>
        </a>
        <a class="dock-item2" id="mapa" href="#">
            <span>Mapa del sitio</span>
            <img src="${resource(dir: 'images/menu', file: 'mapa.png')}" alt="rss"/>
        </a>

        <a class="dock-item2" id="config" href="${createLink(controller: 'login', action: 'edit')}" target="contenido">
            <span>Cuenta</span>
            <img src="${resource(dir: 'images/menu', file: 'Preferences.png')}" alt="cuenta"/>
        </a>
    </div>

</div>

<div id="ventana" style="display:none"></div>

<script type="text/javascript">


    function showChildren() {
        //console.log("showing");
        $(".menu").height(350);
        $(".menu").children("ul").height(350);
        $(".menu").children().children().height(30).width(100).show();
    }

    $(document).ready(function () {

        $('#dock2').Fisheye({
            maxWidth:60,
            items:'a',
            itemsText:'span',
            container:'.dock-container2',
            itemWidth:60,
            proximity:80,
            alignment:'left',
            valign:'bottom',
            halign:'center'
        });

        $("#ventana").dialog({
            autoOpen:false,
            resizable:false,
            modal:false,
            draggable:true,
            width:220,
//                    height:400,
            position:[20, 35],
            open:function (event, ui) {
//                        $(".ui-dialog-titlebar-close").children().first().removeClass("ui-icon-closethick").addClass("ui-icon-circle-triangle-n");
                $(this).prev().children().eq(1).children().first().removeClass("ui-icon-closethick").addClass("ui-icon-circle-triangle-n");
            },
            beforeClose:function (event, ui) {
                $(this).toggle("blind");

                $(".ui-icon-circle-triangle-s").switchClass("ui-icon-circle-triangle-s", "ui-icon-circle-triangle-n");
                $(".ui-icon-circle-triangle-n").switchClass("ui-icon-circle-triangle-n", "ui-icon-circle-triangle-s");
                return false;
            }
        });

        function submenu(boton, titulo, url) {
            $(boton).click(function () {
                $("#contenido").attr("src", "");
                $.ajax({
                    type:"POST",
                    url:url,
                    data:"",
                    success:function (msg) {
                        $("#ventana").html(msg);
                        $("#ventana").dialog("option", "title", titulo);
                        $("#ventana").dialog("open");
                        if ($("#ventana").is(":hidden")) {
                            $("#ventana").show("blind");
                            $(".ui-icon-circle-triangle-s").switchClass("ui-icon-circle-triangle-s", "ui-icon-circle-triangle-n");
                            $(".ui-icon-circle-triangle-n").switchClass("ui-icon-circle-triangle-n", "ui-icon-circle-triangle-s");
                        }
//                                var t = setTimeout("showChildren()", 3000);
                    }
                });
            });
        }

        submenu($("#layout"), "Layouts", "${createLink(controller:'editor',action:'submenu', params:['tipo':'layout'])}");
        submenu($("#pagina"), "Páginas", "${createLink(controller:'editor',action:'submenu', params:['tipo':'pagina'])}");
        submenu($("#fotos"), "Galerías", "${createLink(controller:'editor',action:'submenu', params:['tipo':'galeria'])}");
        submenu($("#publicaciones"), "Publicaciones", "${createLink(controller:'editor',action:'submenu', params:['tipo':'publicacion'])}");
        submenu($("#idioma_menu"), "Idiomas", "${createLink(controller:'editor',action:'submenu', params:['tipo':'idioma'])}");
        $("#menu").click(function () {
            $("#ventana").dialog({title:"menu"});
            $("#ventana").html("")
            $("#ventana").dialog("close");
        });
        %{--submenu($("#publicaciones"), "Publicaciones", "${createLink(controller:'editorPublicaciones',action:'menuPublicaciones')}");--}%
    });
</script>

