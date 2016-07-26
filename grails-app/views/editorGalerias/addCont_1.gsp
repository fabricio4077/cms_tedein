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
        <meta name="layout" content="frame"/>
        <title>CMS - NTH</title>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/lightbox/css', file: 'prettyPhoto.css')}" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8"/>
        <script src="${resource(dir: 'js/jquery/plugins/lightbox/js', file: 'jquery.prettyPhoto.js')}" type="text/javascript" charset="utf-8"></script>
        <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hoverIntent.minified.js')}" type="text/javascript" charset="utf-8"></script>

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

        .disponible {
            background : rgba(150, 150, 150, 0.5);
            padding    : 3px;
        }

        .selected {
            background : rgba(50, 50, 50, 0.5);
            padding    : 3px;
            float      : left;
            margin     : 0 2px 2px 0;
        }

        </style>
    </head>
    <body>

        <ul class="topnav ui-corner-all" style="position:absolute; top:2px;z-index:1999;">
            <li><a href="#" id="continuar">Continuar</a></li>
            <li><a href="addPhotos.gsp#" id="delete">Eliminar</a></li>
        </ul>

        <div style="margin-top:50px;">
            <h1 style="height:35px;">
                <div style="float:left; position:relative;">
                    Contenido de <span class="editable ui-corner-all" id="nombreGal">${gal.nombre}</span>
                    <div id="renameGal" class="pencil" style="position:absolute; right:-28px; top:-15;"></div>
                </div>
            </h1>
        </div>

        <div id="basket" class="ui-widget-content ui-state-default ui-corner-all">
            <h4 class="ui-widget-header ui-corner-all" style="padding:1px; cursor: move;">
                <span class="ui-icon ui-icon-folder-open">Disponibles</span> Disponibles
            </h4>
            <ul id="disponibles" class='gallery ui-helper-reset'>
                <g:set var="idDisp" value="${''}"/>
                <g:each in="${pagsDisp}" var="pagina" status="i">
                    <g:if test="${i>0}">
                        <g:set var="idDisp" value="${idDisp+','+pagina.id}"/>
                    </g:if>
                    <g:else>
                        <g:set var="idDisp" value="${pagina.id}"/>
                    </g:else>
                    <li>
                        <div pag="${pagina.id}" class="disponible ui-corner-all">
                            <ig:img class="ui-corner-all"
                                    src="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id)}"
                                    alt="${pagina.nombre}"
                                    title="${pagina.nombre}"
                                    linkTitle="${pagina.nombre}"
                                    thumbnailSrc="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id, params:[thumbnail:true])}"
                                    id="${pagina.foto?.id}"/>
                            ${pagina.nombre}
                            <span class="ui-icon ui-icon-circle-plus" style="float:right;" title="Agregar">Agregar</span>
                            <span class="ui-icon ui-icon-circle-zoomin" style="float:right;" title="Previsualizar">Previsualizar</span>
                        </div>
                    </li>
                </g:each>
            </ul>
        </div>

        <ul id="selected" class="list-selected ui-helper-reset ui-helper-clearfix" style="width:50%;">
            <g:set var="hmax" value="${0}"/>
            <g:set var="wmax" value="${0}"/>
            <g:set var="idSel" value="${''}"/>
            <g:each in="${pagsDisp}" var="pagina" status="i">
                <g:if test="${i>0}">
                    <g:set var="idSel" value="${idSel+','+pagina.id}"/>
                </g:if>
                <g:else>
                    <g:set var="idSel" value="${pagina.id}"/>
                </g:else>
                <li>
                    <div pag="${pagina.id}" class="selected ui-corner-all">
                        <ig:img class="ui-corner-all"
                                src="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id)}"
                                alt="${pagina.nombre}"
                                title="${pagina.nombre}"
                                linkTitle="${pagina.nombre}"
                                thumbnailSrc="${createLink(action:'showImage', controller: 'image', id:pagina.foto?.id, params:[thumbnail:true])}"
                                id="${pagina.foto?.id}"/>
                        ${pagina.nombre}
                        <g:if test="${pagina.foto.width > wmax}">
                            <g:set var="wmax" value="${pagina.foto.width}"/>
                        </g:if>
                        <g:if test="${pagina.foto.height> hmax}">
                            <g:set var="hmax" value="${pagina.foto.height}"/>
                        </g:if>
                        <span class="ui-icon ui-icon-circle-minus" style="float:right;" title="Eliminar">Eliminar</span>
                        <span class="ui-icon ui-icon-circle-zoomin" style="float:right;" title="Previsualizar">Previsualizar</span>
                    </div>
                </li>
            </g:each>
            <g:set var="hmax" value="${hmax+20}"/>
        %{--<g:set var="max" value="${max+6}"/>--}%
        </ul>

        <input type='text' name='pagsDisp' id='pagsDisp' value="${idDisp}" style="background: #adff2f;"/>
        <input type='text' name='pagsSel' id='pagsSel' value="${idSel}" style="background:red;"/>

        <g:if test="${add.is(true) || add == 'true'}">
            <script type="text/javascript">
                $(function() {
                    var menu = $(".menu", window.parent.document);

                    var boton = $("<a class='boton' href='${createLink(action: 'addCont', params: ['id': gal.id, 'add': false])}' target='contenido'>${gal.nombre}</a>");
                    boton.button();
                    var btn = $('<div style="margin-top:5px; min-height:30px;">');
                    btn.append(boton);
                    var li = $('<li style="width: 138px; min-height: 30px;" id="btn_gal_${gal.id}">');
                    li.append(btn);
                    menu.children("ul").first().append(li);

                    var top = parseInt($("#top", window.parent.document).text());
                    var max = parseInt($("#max", window.parent.document).text());
                    var visible = parseInt($("#visible", window.parent.document).text());

                    if (max < visible) {
                        $("#top", window.parent.document).text(top + 1);
                        $("#max", window.parent.document).text(max + 1);
                    } else {
                        $("#max", window.parent.document).text(max + 1);
                    }

                    if (menu.children("ul").first().children().length == 1) {
                        menu.jCarouselLite({
                            btnNext: ".next",
                            btnPrev: ".prev",
                            vertical: true,
                            visible: 10,
                            scroll: scroll,
                            circular: false
                        });
                    }

                });
            </script>
        </g:if>

        <script type="text/javascript">
            $(function() {

                var $disponibles = $("#disponibles"),
                        $selected = $("#selected");

                $(".selected").width(${wmax});
                $(".selected").height(${hmax});

                $("#basket").draggable({
                    handle: "h4"
                });

                $("#continuar").click(function() {
                    %{--var pags_id = "";--}%
                    %{--$(".ui-selected").each(function() {--}%
                    %{--var p = $(this).attr("id");--}%
                    %{--var parts = p.split("_");--}%
                    %{--var id = parts[1];--}%
                    %{--pags_id += id + ",";--}%
                    %{--});--}%
                    %{--pags_id = pags_id.substring(0, pags_id.length - 1);--}%

                    %{--var url = "${createLink(action:'savePagToGal')}?pags=" + pags_id + "&gal=${gal.id}";--}%
                    %{--//                    //console.log(url);--}%

                    %{--location.href = url;--}%
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
                            $("#btn_gal_${gal.id}", window.parent.document).children().first().children().first().children().first().html(nm);
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
                    if (confirm("Esta seguro de querer eliminar esta galeria y todas sus fotos?")) {
                        $.ajax({
                            type: "POST",
                            url: "${createLink(action:'deleteGal')}",
                            data: {
                                id: '${gal.id}'
                            },
                            success: function(msg) {
                                $("#btn_gal_${gal.id}", window.parent.document).remove();

                                var max = parseInt($("#max", window.parent.document).text());
                                var top = parseInt($("#top", window.parent.document).text());
                                max--;
                                $("#max", window.parent.document).text(max);

                                if (max <= top) {
                                    $("#top", window.parent.document).text(top - 1);
                                }

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