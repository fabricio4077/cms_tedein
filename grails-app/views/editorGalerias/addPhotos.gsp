<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/5/11
  Time: 12:04 PM
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
    </style>
</head>

<body>

    <ul class="topnav ui-corner-all" style="position:absolute; top:2px;z-index:1999;">
        <li><a href="#" id="agregarFoto">Agregar Foto</a></li>
        <li style="display:none;"><a href="#" id="reload">Refrescar fotos</a></li>
        <li><g:link action="customizeGal" id="${gal.id}">Continuar</g:link></li>
        <li><a href="#" id="delete">Eliminar</a></li>
    </ul>

    <div style="margin-top:50px;">
        <h1 style="height:35px;">
            <div style="float:left; position:relative;">
                Fotos de <span class="editable ui-corner-all" id="nombreGal">${gal.nombre}</span>

                <div id="renameGal" class="pencil" style="position:absolute; right:-28px; top:-15;"></div>
            </div>
        </h1>

        <div id="fotosGal" style="margin-top: 5px;"></div>

    </div>


    <g:if test="${add.is(true) || add == 'true'}">
        <script type="text/javascript">
            $(function() {
                var menu = $(".menu_Fotos", window.parent.document);
                var cant = parseInt($("#cant_Fotos", window.parent.document).text());
                $("#cant_Fotos", window.parent.document).text(cant + 1);

                var boton = $("<a class='boton' href='${createLink(action: 'addPhotos', params: ['id': gal.id, 'add': false])}' target='contenido'>${gal.nombre}</a>");
                boton.button();
                menu.append(boton);
            });
        </script>
    </g:if>

    <script type="text/javascript">
        $(function() {

            $("#continuar").click(function() {
                var pags_id = "";
                $(".ui-selected").each(function() {
                    var p = $(this).attr("id");
                    var parts = p.split("_");
                    var id = parts[1];
                    pags_id += id + ",";
                });
                pags_id = pags_id.substring(0, pags_id.length - 1);

                var url = "${createLink(action:'savePagToGal')}?pags=" + pags_id + "&gal=${gal.id}";
//                    //console.log(url);

                location.href = url;
                return false;
            });

            var contenido = "${gal.tipo}";

            loadPhotos();

            function loadPhotos() {
                var url
                if (contenido == "Fotos") {
                    url = "${createLink(action:'fotosGal')}";
                } else {
                    url = "${createLink(action:'textosGal')}";
                }

                $.ajax({
                            type: "POST",
                            url: url,
                            data: {
                                id: '${gal.id}'
                            },
                            success: function(msg) {
                                $("#fotosGal").html(msg);
                            }
                        });
            }

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

            $("#reload").click(function() {
                loadPhotos();
                return false;
            });

            $("#agregarFoto").click(function() {
                var url = "${createLink(controller:'image', action:'addToGal', params:["id":gal.id,"idioma":6,"tipo":"gal"])}";
                var child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=600,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                if (child.opener == null) child.opener = self;
                window.toolbar.visible = false;
                window.menubar.visible = false;
                return false;
            });

            $("#agregarCont").click(function() {
                var url = "${createLink(controller:'image', action:'addToGal', params:["id":gal.id,"idioma":6,"tipo":"gal"])}";
                var child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=600,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                if (child.opener == null) child.opener = self;
                window.toolbar.visible = false;
                window.menubar.visible = false;
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

                                    var cant = parseInt($("#cant_Fotos", window.parent.document).text());
                                    $("#cant_Fotos", window.parent.document).text(cant - 1);

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