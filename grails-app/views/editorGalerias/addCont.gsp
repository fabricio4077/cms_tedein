<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/8/11
  Time: 10:35 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="frame" />
    <title>CMS - NTH</title>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/lightbox/css', file: 'prettyPhoto.css')}"
          type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
    <script src="${resource(dir: 'js/jquery/plugins/lightbox/js', file: 'jquery.prettyPhoto.js')}"
            type="text/javascript" charset="utf-8"></script>
    <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hoverIntent.minified.js')}" type="text/javascript"
            charset="utf-8"></script>

    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jCarouselLite.js')}"></script>

    <style type="text/css" media="screen">
    * {
        margin  : 0;
        padding : 0;
    }

    body {
        font    : 10px Arial, Verdana, Sans-Serif;
        padding : 0 20px;
    }

    h4 {
        margin : 15px 0 5px 0;
    }

    h4, p {
        font-size : 1.2em;
    }

    ul li {
        display : inline;
    }

    .wide {
        border-bottom : 1px #000 solid;
        width         : 4000px;
    }

    .editable {
        border : 1px solid #d2691e;
    }

        /******************************** para el dragNdrop ***********************************/
    #gallery {
        float      : left;
        width      : 65%;
        min-height : 12em;
    }

    * html #gallery {
        height : 12em;
    }

        /* IE6 */
    .gallery.custom-state-active {
        background : #eee;
    }

    .gallery li {
        float      : left;
        width      : 96px;
        padding    : 0.4em;
        margin     : 0 0.4em 0.4em 0;
        text-align : center;
    }

    .gallery li h5 {
        margin : 0 0 0.4em;
        cursor : move;
    }

    .gallery li a {
        float : right;
    }

    .gallery li a.ui-icon-zoomin {
        float : left;
    }

    .gallery li img {
        width  : 100%;
        cursor : move;
    }

    #basket {
        float      : right;
        width      : 32%;
        min-height : 18em;
        padding    : 1%;
    }

    * html #basket {
        height : 18em;
    }

        /* IE6 */
    #basket h4 {
        line-height : 16px;
        margin      : 0 0 0.4em;
    }

    .ui-icon {
        float  : left;
        cursor : pointer;
    }

    #basket .gallery h5 {
        display : none;
    }

    .disponible, .selected {
        /*background     : rgba(150, 150, 150, 0.5);*/
        /*padding        : 3px; */
        /*margin         : 0 2px 2px 0;*/
        /*border         : rgb(150, 150, 150) solid 1px;*/
    }

    .titulo {
        font-size     : 14px;
        font-weight   : bold;
        margin-bottom : 10px;
    }

    .lista {
        border     : solid 1px gray;
        min-height : 100px;
        padding    : 3px;
        overflow-x : hidden;
    }

    .lista li {
        display        : inline-block;
        vertical-align : top;

        background     : rgba(150, 150, 150, 0.5);
        padding        : 3px;
        margin         : 0 2px 2px 0;
        border         : rgb(150, 150, 150) solid 1px;
    }

    .highlight {
        min-height : 150px;
        min-width  : 150px;
        background : rgba(205, 252, 171, 1);
    }
    </style>
</head>

<body>

<ul class="topnav ui-corner-all" style="position:absolute; top:2px;z-index:1999;">
    <li><a href="#" id="continuar">Continuar</a></li>
    <li><a href="#" id="delete">Eliminar</a></li>
</ul>

<div style="margin-top:50px;">
    <h1 style="height:35px;">
        <div style="float:left; position:relative;">
            Contenido de <span class="editable ui-corner-all" id="nombreGal">${gal.nombre}</span>

            <div id="renameGal" class="pencil" style="position:absolute; right:-28px; top:-15;"></div>
        </div>
    </h1>

    <p>
        Arrastre las p&aacute;ginas: del &aacute;rea &quot;P&aacute;ginas disponibles&quot; al &aacute;rea &quot;P&aacute;ginas seleccionadas&quot; para seleccionarlas
    </p>

    <p>
        Arrastre las p&aacute;ginas del &aacute;rea &quot;P&aacute;ginas seleccionadas&quot; al &aacute;rea &quot;P&aacute;ginas disponibles&quot; para removerlas
    </p>
</div>

<g:set var="dhmax" value="${0}" />
<g:set var="dwmax" value="${0}" />



<div style="min-height: 100px;" id="dialog_disp">
    <ul id="ul_disponibles" class="lista">
        <g:each in="${pagsDisp}" var="pagina" status="i">
            <li id="pag_${pagina.id}">
                <div pag="${pagina.id}" class="disponible ui-corner-all">
                    <ig:img class="ui-corner-all"
                            src="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id)}"
                            alt="${pagina.nombre}"
                            title="${pagina.nombre}"
                            linkTitle="${pagina.nombre}"
                            thumbnailSrc="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id, params:[thumbnail:true])}"
                            id="${pagina.foto?.id}" />
                    ${pagina.nombre}
                    <span class="ui-icon ui-icon-circle-zoomin" style="float:right;"
                          title="Previsualizar">Previsualizar</span>
                </div>
                <g:if test="${pagina.foto.width > dwmax}">
                    <g:set var="dwmax" value="${pagina.foto.width}" />
                </g:if>
                <g:if test="${pagina.foto.height> dhmax}">
                    <g:set var="dhmax" value="${pagina.foto.height}" />
                </g:if>
            </li>
        </g:each>
    </ul>
</div>
<g:set var="dhmax" value="${dhmax+20}" />

<g:set var="shmax" value="${0}" />
<g:set var="swmax" value="${0}" />


<div style="min-height: 100px;" id="dialog_sel">
    <ul id="ul_seleccionados" class="lista">
        <g:each in="${pagsAct}" var="pagina" status="i">
            <li id="pag_${pagina.id}">
                <div pag="${pagina.id}" class="disponible ui-corner-all">
                    <ig:img class="ui-corner-all"
                            src="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id)}"
                            alt="${pagina.nombre}"
                            title="${pagina.nombre}"
                            linkTitle="${pagina.nombre}"
                            thumbnailSrc="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id, params:[thumbnail:true])}"
                            id="${pagina.foto?.id}" />
                    ${pagina.nombre}
                    <span class="ui-icon ui-icon-circle-zoomin" style="float:right;"
                          title="Previsualizar">Previsualizar</span>
                </div>
                <g:if test="${pagina.foto.width > swmax}">
                    <g:set var="swmax" value="${pagina.foto.width}" />
                </g:if>
                <g:if test="${pagina.foto.height> shmax}">
                    <g:set var="shmax" value="${pagina.foto.height}" />
                </g:if>
            </li>
        </g:each>
    </ul>
</div>

<g:set var="shmax" value="${shmax+20}" />

<g:set var="hmax" value="${Math.max(shmax, dhmax)}" />
<g:set var="wmax" value="${Math.max(swmax, dwmax)}" />


<g:if test="${add.is(true) || add == 'true'}">
    <script type="text/javascript">
        $(function() {
            var menu = $(".menu_Texto", window.parent.document);
            var cant = parseInt($("#cant_Texto", window.parent.document).text());
            $("#cant_Texto", window.parent.document).text(cant + 1);

            var boton = $("<a class='boton' id='btn_gal_${gal.id}}' href='${createLink(action: 'addCont', params: ['id': gal.id, 'add': false])}' target='contenido'>${gal.nombre}</a>");
            boton.button();
            menu.append(boton);
        });
    </script>
</g:if>

<script type="text/javascript">
    $(function() {

        $("#dialog_sel").dialog({
                    title:"Páginas seleccionadas",
                    minWidth:360,
                    width:540,
                    height:430,
                    closeOnEscape: false,
                    position: [0,150]
                });
        $("#dialog_disp").dialog({
                    title:"Páginas disponibles",
                    minWidth:360,
                    width:540,
                    height:430,
                    closeOnEscape: false,
                    position: [570,150]
                });

        $("#ul_disponibles, #ul_seleccionados").sortable({
                    connectWith: ".lista",
                    placeholder: "highlight",
//                    helper: 'clone',
                    items: 'li',
                    forceHelperSize: true,
                    forcePlaceholderSize: true,
                    containment: 'body',
                    stop: function(event, ui) {
                    }
                })/*.disableSelection()*/;

        $(".disponible").width(${wmax}).height(${hmax});

        $("#continuar").click(function() {
            var dis = $("#ul_disponibles").sortable("serialize", {key:"disp"});
            var sel = $("#ul_seleccionados").sortable("serialize", {key:"sel"});
            var gal = ${gal.id};
            var url = "${createLink(action:'savePagToGal')}?" + sel + "&" + dis + "&gal=" + gal;
            location.href = url;
            return false;
        });

        function edit() {
            var nm = $("#nombreGal").text();
            var w = $("#nombreGal").outerWidth();
            var txt = $("<input type='text' style='width:" + w + "px;' value='" + nm + "'/>");
            txt.keypress(function(event) {
                if (event.which == '13') {
                    event.preventDefault();
                    save();
                }
            });
            txt.focus().select();
            $("#renameGal").addClass("disk").css({
                        top:0,
                        right: -33
                    });
            $("#nombreGal").css("paddingBottom", 5).html(txt);
        }

        function save() {
            var nm = $("#nombreGal > input").val();
            $.ajax({
                        type: "POST",
                        url: "${createLink(action:'renameGal')}",
                        data: {
                            id: '${gal.id}',
                            nombre: nm
                        },
                        success: function(msg) {
                            $("#btn_gal_${gal.id}", window.parent.document).children().first().html(nm);
                            $("#nombreGal").css("paddingBottom", 0).html(nm);
                            $("#renameGal").removeClass("disk").css({
                                        top:-15,
                                        right: -28
                                    });
                        }
                    });
        }

        $("#renameGal, #nombreGal").click(function() {
            if (!$("#renameGal").hasClass("disk")) {
                edit();
            } else {
                if ($(this).attr("id") == "renameGal") {
                    save();
                }
            }
            return false;
        });

        $("#delete").click(function() {
            if (confirm("Esta seguro de querer eliminar esta galeria y todas sus paginas?")) {
                $.ajax({
                            type: "POST",
                            url: "${createLink(action:'deleteGal')}",
                            data: {
                                id: '${gal.id}'
                            },
                            success: function(msg) {
                                $("#btn_gal_${gal.id}", window.parent.document).remove();

                                var cant = parseInt($("#cant_Texto", window.parent.document).text());
                                $("#cant_Texto", window.parent.document).text(cant - 1);

                                location.href = "${createLink(action:"empty")}";
                            }
                        });
            }
            return false;
        });
    });
</script>

</body>
</html>