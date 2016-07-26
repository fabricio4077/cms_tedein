<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/26/11
  Time: 11:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <g:imports/>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/lightbox/css', file: 'prettyPhoto.css')}"
              type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8"/>
        <script src="${resource(dir: 'js/jquery/plugins/lightbox/js', file: 'jquery.prettyPhoto.js')}"
                type="text/javascript" charset="utf-8"></script>
        <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hoverIntent.minified.js')}" type="text/javascript"
                charset="utf-8"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jCarouselLite.js')}"></script>

        <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.ba-throttle-debounce.js')}" type="text/javascript"
                charset="utf-8"></script>

        <meta name="layout" content="frame"/>

        <style type="text/css" media="screen">
        * {
            margin: 0;
            padding: 0;
        }

        body {
            font: 10px Arial, Verdana, Sans-Serif;
            padding: 0 20px;
        }

        h4 {
            margin: 15px 0 5px 0;
        }

        h4, p {
            font-size: 1.2em;
        }

        ul li {
            display: inline;
        }

        .wide {
            border-bottom: 1px #000 solid;
            width: 4000px;
        }

        .selected {
            border: solid 1px #9932cc;
            background: #d8bfd8;
        }

        </style>
        <title>NTH: ${pagina.nombre}</title>
    </head>

    <body>

        <ul id="ulMenu" class="topnav ui-corner-all" style="position:absolute; top:2px;z-index:1999;">
            <li><a href="#" id="guardar">Guardar</a></li>
            <li><a href="#" rel="prettyPhoto[iframe]" id="ver">Ver página</a></li>
            <li>
                <a href="#" id="seccion">Insertar sección</a>
                <ul class="subnav">
                    <g:each in="${seccion.constraints.tipo.inList}">
                        <g:if test="${it!='Publicaciones'}">
                            <li><a href="#" tipo="${it}" class=" insertarSeccion">${it}</a></li>
                        </g:if>
                    </g:each>
                </ul>
            </li>
            <li>
                <a href="#" id="borrarPag" pagina="${pagina.id}">Borrar</a>
            </li>
            <li><a href="#" id="editarLayout">Editar diseño</a></li>
        </ul>
        <input id="pagina" type="hidden" value="${pagina.id}">
        <g:form action="guardarSeccionesPagina" controller="editor" class="frmEditarPagina">
            <div id="worckSpace"
                 style="position:relative;width:100%; margin-top:45px;font:16px Arial, Verdana, Sans-Serif;${pagina.layout.css}">
                <input type="hidden" name="pagina.id" value="${pagina.id}">
                <g:if test="${pagina.layout.banner}">
                    <div class="drag" id="banner"
                         style="position:absolute;top:${(pagina?.layout?.banner?.top) ? pagina?.layout?.banner?.top : "5px"};left:${(pagina?.layout?.banner?.izq) ? pagina?.layout?.banner?.izq : "300px"};width:${(pagina?.layout?.banner?.width) ? pagina?.layout?.banner?.width : "400px"};height:${(pagina?.layout?.banner?.height) ? pagina?.layout?.banner?.height : "60px"}; ${(pagina?.layout?.banner?.css) ? pagina?.layout?.banner?.css : "border:1px #0099ff solid;cursor:move;background:rgba(0,0,200,0.3);"};">

                        <div id="bannerContenido">
                            <g:if test="${pagina.layout?.banner.foto}">
                                ${ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: pagina.layout?.banner?.foto?.id), "alt": pagina.layout?.banner?.foto?.caption, "title": pagina.layout?.banner?.foto?.caption, "thumbnailSrc": g.createLink(action: 'showImage', controller: 'image', id: pagina.layout?.banner?.foto?.id, params: [thumbnail: false])])}
                            </g:if>
                            <g:else>
                                <g:if test="${pagina.layout.banner.contenido}">
                                    <g:mostrarSeccion id="${pagina.layout.banner.id}" idioma="${session.idioma.id}"
                                                      tipo="Borrador"></g:mostrarSeccion>
                                </g:if>
                                <g:else>
                                    <h3 class="ui-widget-header"
                                        style="margin:0px;position:relative;padding-left:5px">Banner</h3>
                                </g:else>
                            </g:else>

                        </div>
                    </div>
                </g:if>
                <g:if test="${pagina.layout.menu}">
                    <div class="drag" id="menu"
                         style="position:absolute;top:${(pagina?.layout?.menu?.top) ? pagina?.layout?.menu?.top : "70px"};left:${(pagina?.layout?.menu?.izq) ? pagina?.layout?.menu?.izq + "px" : "300px"};width:${(pagina?.layout?.menu?.width) ? pagina?.layout?.menu?.width : "400px"};height:${(pagina?.layout?.menu?.height) ? pagina?.layout?.menu?.height : "40px"}; ${(pagina?.layout?.menu?.css) ? pagina?.layout?.menu?.css : "border:1px #ff9999 solid;cursor:move;background:rgba(200,0,0,0.3);"};">
                        <h3 class="ui-widget-header" style="margin:0px;position:relative;padding-left:5px">Menu</h3>
                        <g:mostrarMenuPag tipo="editor" actual="${pagina.id}"></g:mostrarMenuPag>
                    </div>
                </g:if>
                <div class="drag " id="contenido"
                     style="position:absolute; top:${(pagina?.layout?.contenido?.top > -1) ? pagina?.layout?.contenido?.top : "120px"}; left:${(pagina?.layout?.contenido?.izq > -1) ? pagina?.layout?.contenido?.izq : "300px"}; width:${(pagina?.layout?.contenido?.width) ? pagina?.layout?.contenido?.width : "400px"}; height:${(pagina?.layout?.contenido?.height) ? pagina?.layout?.contenido?.height : "400px"}; ${(pagina?.layout?.contenido?.css) ? pagina?.layout?.contenido?.css : "border:1px #cccccc solid; cursor:move; background:rgba(204,204,204,0.3);"};">
                    <h3 class="ui-widget-header" style="margin:0px;position:relative;padding-left:5px">Contenido</h3>

                    <div id="divContenido"
                         style="width: 100%; height: 100%; overflow: auto; height:${(pagina?.layout?.contenido?.height) ? pagina?.layout?.contenido?.height - 30 : "370px"}"></div>
                </div>
                <g:each in="${pagina.secciones}" var="seccion">
                    <g:mostrarSeccionEditar tipo="Borrador" idioma="6" id="${seccion.id}"></g:mostrarSeccionEditar>
                </g:each>

                <div id="ventanaEdicion" style="display:none">
                    <input type="hidden" id="veSeccion">
                </div>


                %{--<div id="ventanaPropiedades" style="display:none">--}%
                %{--<input type="hidden" id="vpSeccion">--}%
                %{--<div id="tabla"></div>--}%
                %{--</div>--}%

            </div>
        </g:form>

        <g:if test="${add=='true' || add.is(true)}">
            <script type="text/javascript">
                $(function() {

                    var menu = $(".menu", window.parent.document);
                    var boton = $("<a class='boton' id='btn_tipo_${pagina.id}}' href='${createLink(action: 'editarPublicaciones', params: ['id': pagina.id, 'add': false])}' target='contenido'>${pagina.nombre}</a>");
                    boton.button();
                    menu.append(boton);

                });
            </script>
        </g:if>

        <div id="ventanaPropiedades" style="display:none; z-index:9999; width:350px; height:495px; top:35px; right:5px;"
             class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
            <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
                <span id="ui-dialog-title-dialog" class="ui-dialog-title">Dialog title</span>
                <a id="btnHide" title="Ocultar" shown="1" class="ui-dialog-titlebar-close ui-corner-all" href="#"><span
                        class="ui-icon ui-icon-circle-close">close</span></a>
            </div>

            <div id="contenidoProps">
                <div style="height: 400px; " class="ui-dialog-content ui-widget-content" id="dialog">
                    <input type="hidden" id="vpSeccion">

                    <div id="tabla">
                        <table style="width:250px;">
                            <thead>
                                <th style="border: 1px black solid;" class="ui-state-active">Propiedad</th>
                                <th style="border: 1px black solid;" class="ui-state-active">Valor</th>
                            </thead>
                            <tbody>
                                <g:set var="grupos" value=""/>

                                <g:set var="grupo" value=""/>

                                <g:each in="${props}" var="prop" status="i">
                                    <g:if test="${prop.grupo!=grupo}">
                                        <tr class="${prop.tipo} ui-widget-header ui-corner-all ui-helper-clearfix">
                                            <td>${prop.grupo}</td>
                                            <g:set var="grupo" value="${prop.grupo}"/>
                                            <g:set var="grupos" value="${'.prop_'+prop.grupo+','+grupos}"/>
                                        </tr>
                                    </g:if>
                                    <tr class="${prop.tipo}" title="${prop.explicacion}">
                                        <td style="border: 1px black solid; padding-left: 5px;" class="ui-state-active">
                                            ${prop.mostrar}
                                        </td>
                                        <td style="border: 1px black solid;">
                                            <elm:item propiedad="${prop}"
                                                      id="V${prop.nombre}"
                                                      nombre="${prop.nombre}"
                                                      sufijo="${(prop.sufijo)?prop.sufijo:''}"
                                                      class="propiedad"/>
                                        </td>

                                    </tr>

                                    <tr class="prop_${prop.grupo}" title="${prop.explicacion}">
                                        <td style="border: 1px black solid; padding-left: 5px;" class="ui-state-active">
                                            ${prop.mostrar}
                                        </td>
                                        <td style="border: 1px black solid;">
                                            <elm:item propiedad="${prop}"
                                                      id="V${prop.nombre}"
                                                      nombre="${prop.nombre}"
                                                      sufijo="${(prop.sufijo)?prop.sufijo:''}"
                                                      class="propiedad"/>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>

                <g:if test="${grupos.size() > 1}">
                    <g:set var="grupos" value="${grupos.substring(0,grupos.size()-1)}"/>
                </g:if>

                <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
                    <div class="ui-dialog-buttonset">
                        <button id="btnAplicar">
                            <span class="ui-button-text">Aplicar</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div id="reloadGaleria" style="display:none;">
            <input type="text" id="idSeccionGaleria"/>
            <button id="botonGaleria">RELOAD</button>
        </div>

        <script type="text/javascript">

            /***********botones************/
            $(".boton").css({"font-size":"11px"});
            $(".boton").button();
            /***********botones***********/

            $("#botonGaleria").click(function() {
                var id = $("#idSeccionGaleria").val();
                loadGaleria(id);
                return false;
            });

            /***********funciones***********/

            function loadGaleria(seccion) {
                $.ajax({
                    type: "POST",
                    url: "${createLink(action:'loadGaleria')}",
                    data: {
                        id:seccion
                    },
                    success: function(msg) {
                        $("#" + seccion + "Contenido").html(msg);
                    }
                });
            }

            function vaciar() {
                $(".propiedad").each(function() {
                    $(this).val("");
                    $(this).css({
                        background : "white",
                        color: "black"
                    });
                });
            }

            function cargaPropiedades(seccion) {
            %{--//console.log("${grupos}");--}%
            %{--//console.log($("#" + seccion).attr("tipo"));--}%
                $("${grupos}").hide();
                $(".prop_" + $("#" + seccion).attr("tipo")).show();

                vaciar();
                if ($("#" + seccion + "css").val() != "" && $("#" + seccion + "css").val() != null) {
                    var propiedades = $("#" + seccion + "css").val().split(";")
                    $.each(propiedades, function() {
                        if (this.length > 4) {
                            var valor = this.split(":");
                            //colP
                            if (valor[1].charAt(valor[1].length - 2) != "p") {
                                $("#V" + valor[0]).val(valor[1]);
                            } else {
                                $("#V" + valor[0]).val(valor[1].substring(0, valor[1].length - 2));
                            }
                            if ($("#V" + valor[0]).hasClass("colP")) {
                                $("#V" + valor[0]).css("background", $("#V" + valor[0]).val());
                            }
                        }
                    });
                    $("#Vwidth").val($("#" + seccion + "wid").val());
                    $("#Vheight").val($("#" + seccion + "hei").val());
                    $("#Vtop").val($("#" + seccion + "top").val());
                    $("#Vleft").val($("#" + seccion + "izq").val());
                } else {
                    $(".listaPropiedades").val("")
                    $("#Vwidth").val($("#" + seccion + "wid").val());
                    $("#Vheight").val($("#" + seccion + "hei").val());
                    $("#Vtop").val($("#" + seccion + "top").val());
                    $("#Vleft").val($("#" + seccion + "izq").val());
                }

            }
            function cargaTabla() {
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'editor',action:'propiedades')}",
                    data: "",
                    success: function(msg) {
                        $("#tabla").html(msg);
                    }
                });
            }

            function registrarPosicion(seccion) {
                var position = $("#" + seccion).position()
                $("#" + seccion + "top").val(position.top)
                $("#" + seccion + "izq").val(position.left)
                if ($("#vpSeccion").val() == seccion) {
                    $("#Vtop").val(position.top)
                    $("#Vleft").val(position.left)
                }
            }

            function registrarTam(seccion) {

                $("#" + seccion + "wid").val($("#" + seccion).width())
                $("#" + seccion + "hei").val($("#" + seccion).height())
                if ($("#vpSeccion").val() == seccion) {
                    $("#Vwidth").val($("#" + seccion).width())
                    $("#Vheight").val($("#" + seccion).height())
                }
            }
            //  cargaTabla();

            String.prototype.capitalize = function() {
                return this.charAt(0).toUpperCase() + this.slice(1);
            }


            function arreglaProp(id) {
                var parts = id.split("-");
                var str = ""
                for (var i = 0; i < parts.length; i++) {
                    var p = parts[i];
                    if (i == 0) {
                        str += p
                    } else {
                        str += p.capitalize()
                    }
                }
                return str
            }

            var $window = $(window), $elem = $('#ulMenu'),$props = $("#ventanaPropiedades");

            function menuScroll() {
                $elem.css('top', ($window.scrollTop() + 2) + 'px');
                if ($props.is(":visible")) {
                    $props.css('top', ($window.scrollTop() + 40) + 'px');
                }
            }

            $window.scroll($.debounce(250, menuScroll));


            /***********funciones***********/

            $("#ventanaPropiedades").draggable({
                handle: ".ui-dialog-titlebar",
                cancel: ".ui-icon",
                containment: "parent"
            });

            $("#btnHide").click(function() {
                $("#ventanaPropiedades").hide();
                return false;
            });

            $("#btnAplicar").button().click(function() {
                var div = $("#" + $("#vpSeccion").val());
                $("#" + $("#vpSeccion").val() + "css").val("");
                $(".propiedad").each(function() {
                    if ($(this).attr("nombre") != "top" && $(this).attr("nombre") != "left" && $(this).attr("nombre") != "width" && $(this).attr("nombre") != "height") {
                        if ($(this).val() != "" && $(this).val() != "0" && $(this).val() != "-1") {
                            div.css($(this).attr("nombre"), $(this).val());
                            $("#" + $("#vpSeccion").val() + "css").val($("#" + $("#vpSeccion").val() + "css").val() + ";" + $(this).attr("nombre") + ":" + $(this).val() + $(this).attr("sufijo"));
                        }
                    } else {
                        if ($(this).val() != "" && $(this).val() != "0" && $(this).val() != "-1") {
                            div.css($(this).attr("nombre"), $(this).val());
                            $("#" + $("#vpSeccion").val() + $(this).attr("nombre").substring(0, 3)).val($(this).val());
                        }
                    }
                });
            });

            $("#ventanaEdicion").dialog({
                autoOpen: false,
                resizable:true,
                modal:false,
                draggable:true,
                width:280,
                height:100,
                position: [1000,35]

            });
            /***********dialog***********/


            /***********procesos*********/

            var $divSelected = null;

            function mover(e) {
                if ($divSelected != null) {
                    var delta = 1;
                    var arr = $divSelected.css("top");
                    var izq = $divSelected.css("left");
                    var width = $divSelected.width();
                    var height = $divSelected.height();
                    arr = parseInt(arr.substring(0, arr.length - 2));
                    izq = parseInt(izq.substring(0, izq.length - 2));
                    var shift = e.shiftKey;

                    var draggable = true;
                    var resizable = true;

                    if ($divSelected.attr("tipo") == "Publicaciones") {
                        resizable = false;
                    }

                    if (e.ctrlKey) {
                        delta = 10;
                    }
                    switch (e.keyCode) {
                        case 38: /*up*/
                            if (shift) {
                                if (resizable) {
                                    $divSelected.height(height - delta);
                                    registrarTam($divSelected.attr("id"));
                                }
                            } else {
                                if (draggable) {
                                    $divSelected.css("top", arr - delta);
                                    registrarPosicion($divSelected.attr("id"));
                                }
                            }
                            return false;
                            break;
                        case 40: /*down*/
                            if (shift) {
                                if (resizable) {
                                    $divSelected.height(height + delta);
                                    registrarTam($divSelected.attr("id"));
                                }
                            } else {
                                if (draggable) {
                                    $divSelected.css("top", arr + delta);
                                    registrarPosicion($divSelected.attr("id"));
                                }
                            }
                            return false;
                            break;
                        case 37: /*left*/
                            if (shift) {
                                if (resizable) {
                                    $divSelected.width(width - delta);
                                    registrarTam($divSelected.attr("id"));
                                }
                            } else {
                                if (draggable) {
                                    $divSelected.css("left", izq - delta);
                                    registrarPosicion($divSelected.attr("id"));
                                }
                            }
                            return false;
                            break;
                        case 39: /*right*/
                            if (shift) {
                                if (resizable) {
                                    $divSelected.width(width + delta);
                                    registrarTam($divSelected.attr("id"));
                                }
                            } else {
                                if (draggable) {
                                    $divSelected.css("left", izq + delta);
                                    registrarPosicion($divSelected.attr("id"));
                                }
                            }
                            return false;
                            break;
                    }
                }
            }

            $(document).keypress(function(e) {
                var ot = $(e.originalTarget);
                if (!ot.is("input")) {
                    e.preventDefault();
                    mover(e);
                }
            });
            $(window.parent).keypress(function(e) {
                var ot = $(e.originalTarget);
                if (!ot.is("input")) {
                    e.preventDefault();
                    mover(e);
                }
            });

            function eventos(div) {
                if (div.attr("tipo") != "Publicaciones") {
                    div.resizable({
                        minHeight: 30,
                        minWidth: 150,
                        start: function(event, ui) {
                            $divSelected = $(this);
                        },
                        stop: function(event, ui) {
                            registrarTam($(this).attr("id"));
                        },
                        handles: 'n, e, s, w, se, sw'
                    });
                }
                div.draggable({
                    start: function(event, ui) {
                        $divSelected = $(this);
                    },
                    stop: function(event, ui) {
                        registrarPosicion($(this).attr("id"));
                    },
                    cancel: ".delete, .propiedades, .contenido"
                });

                div.click(function() {
                    $divSelected = $(this);
                    var iframeRef = window.parent.document.getElementById("contenido");
                    $(iframeRef).focus();
                });
            }

            eventos($(".divSeccion"));


            //    $(".divSeccion").click(function() {
            //        $divSelected = $(this);
            //        var iframeRef = window.parent.document.getElementById("contenido");
            //        $(iframeRef).focus();
            //    });
            //    $(".divSeccion").resizable({
            //                minHeight: 30,
            //                minWidth: 150,
            //                stop: function(event, ui) {
            //                    registrarTam($(this).attr("id"));
            //                },
            //                handles: 'n, e, s, w, se, sw'
            //            });
            //    $(".divSeccion").draggable({
            //                stop: function(event, ui) {
            //                    registrarPosicion($(this).attr("id"));
            //                },
            //                cancel: ".delete, .propiedades, .contenido"
            //            });

            function deleteSeccion(obj) {
                if (confirm("Esta seguro que desea borrar esta sección?")) {
                    var seccion = obj.parent().attr("seccion");
                    $.ajax({
                        type: "POST",
                        url: "${createLink(controller:'editor',action:'deleteSeccion')}",
                        data: "id=" + seccion,
                        success: function(msg) {
                            $("#" + seccion).remove()
                        }});
                }
            }

            function propiedadesSeccion(obj) {
                $("#vpSeccion").val(obj.parent().attr("seccion"));
                $("#ui-dialog-title-ventanaPropiedades").css({"font-size":"10px"});
                $("#ventanaPropiedades").find("#ui-dialog-title-dialog").text('Editar Propiedades');
                cargaPropiedades(obj.parent().attr("seccion"));
                $("#ventanaPropiedades").show().css('top', ($window.scrollTop() + 40) + 'px');
                ;
            }

            function contenidoSeccion(obj) {
//        //console.log(obj.parent().attr("tipo"))
                if (obj.parent().attr("tipo") == "Texto") {
                    var url = '${g.createLink(controller:'editor', action:"rte")}?id=' + obj.parent().attr("seccion") + "&idioma=6";
                    child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=600,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                    if (child.opener == null) child.opener = self;
                    window.toolbar.visible = false;
                    window.menubar.visible = false;
                }//texto
                if (obj.parent().attr("tipo") == "Link") {
                    var url = '${g.createLink(controller:'editor', action:"rte")}?id=' + obj.parent().attr("seccion") + "&idioma=6&link=1";
                    child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=600,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                    if (child.opener == null) child.opener = self;
                    window.toolbar.visible = false;
                    window.menubar.visible = false;
                }//link
                if (obj.parent().attr("tipo") == "Foto") {
                    var w = obj.parent().parent().width();
                    var h = obj.parent().parent().height();
                    var url = '${g.createLink(controller:"image", action:"create")}?id=' + obj.parent().attr("seccion") + "&idioma=6&w=" + w + "&h=" + h;
                    child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=600,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                    if (child.opener == null) child.opener = self;
                    window.toolbar.visible = false;
                    window.menubar.visible = false;
                }//imagen
                if (obj.parent().attr("tipo") == "Galeria") {
                    var url = '${g.createLink(action:"seleccionarGaleria")}?id=' + obj.parent().attr("seccion") + "&idioma=6";
                    child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=600,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                    if (child.opener == null) child.opener = self;
                    window.toolbar.visible = false;
                    window.menubar.visible = false;
                }//texto
            }

            /***********barrita***********/
            var config = {
                timeout: 500, // number = milliseconds delay before onMouseOut
                over: function() {
                    $("#barra_" + $(this).attr("id")).show();
                },
                out: function() {
                    $("#barra_" + $(this).attr("id")).hide("explode");
                }
            };

            $(".divSeccion").hoverIntent(config);
            $(".delete").click(function() {
                deleteSeccion($(this));
                return false;
            });
            $(".propiedades").click(function() {
                propiedadesSeccion($(this));
                return false;
            });
            $(".contenido").click(function() {
                contenidoSeccion($(this));
                return false;
            });
            /***********barrita***********/

            /*******************************************************************************************************/
            //
            //    $(".divSeccion").hoverIntent(config);

            $("#guardar").click(function() {
                $(".frmEditarPagina").submit()
            });

            $(".insertarSeccion").click(function() {
                var nuevo = $("<div>");
                var tipo = $(this).attr("tipo")

                nuevo.css({
                    "width": "150px",
                    "height": "40px",
                    "border": "solid 1px black",
                    "margin-top": "10px",
                    "margin-left": "10px",
                    "float:": "left",
                    "position":"absolute",
                    "top":"100px",
                    "left":"100px"
                });
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'editor',action:'nuevaSeccion')}",
                    data: "pagina=" + $("#pagina").val() + "&tipo=" + tipo + "&top=100&left=100&width=150&height=40",
                    success: function(msg) {
                        nuevo.attr("id", msg)
                        nuevo.attr("tipo", tipo)
                        nuevo.css("z-index", 1)

                        //nuevo.append('<h3 class="ui-widget-header" id="barra_' + msg + '" style="margin:0px;position:relative;padding-left:5px;display:none;height:21px">' + tipo + '<div class="ui-icon ui-icon-document botonContenido" seccion="' + msg + '" title="Editar contenido" tipo="' + tipo + '"></div><div class="ui-icon ui-icon-pencil botonPropiedades" seccion="' + msg + '" title="Editar contenido" ></div><div class="ui-icon ui-icon-closethick botonDelete" seccion="' + msg + '" title="Borrar sección" ></div></h3>');
                        // elm.barrita(title:seccion.tipo, botones:['eliminar', 'editar', 'propiedades'], float:'right', id:seccion.id, param:"seccion="+seccion.id+" tipo="+seccion.tipo)

                        var barrita = $("<h3 class='ui-widget-header barrita' id='barra_" + msg + "' seccion='" + msg + "' tipo='" + tipo + "'>");
                        var titulo = $("<span class='barrita_titulo'>" + tipo + "</span>");

                        var botonDelete = $("<div class='ui-icon ui-icon-closethick delete botoncito right rightmost' title='Eliminar' ></div>");
                        var botonEditar = $("<div class='ui-icon ui-icon-document contenido botoncito right' title='Editar' ></div>");
                        var botonPropiedades = $("<div class='ui-icon ui-icon-pencil propiedades botoncito right' title='Propiedades' ></div>");

                        if (tipo == "Vacio") {
                            barrita.append(titulo).append(botonDelete).append(botonPropiedades);
                        } else {
                            barrita.append(titulo).append(botonDelete).append(botonEditar).append(botonPropiedades);
                        }

                        nuevo.append(barrita);

                        nuevo.append('<input type="hidden" name="secciones.' + msg + '.id" id="' + msg + 'id" value="' + msg + '">');
                        nuevo.append('<input type="hidden" name="secciones.' + msg + '.top" id="' + msg + 'top" value="100">');
                        nuevo.append('<input type="hidden" name="secciones.' + msg + '.izq" id="' + msg + 'izq" value="100">');
                        nuevo.append('<input type="hidden" name="secciones.' + msg + '.width" id="' + msg + 'wid" value="150">');
                        nuevo.append('<input type="hidden" name="secciones.' + msg + '.height" id="' + msg + 'hei" value="40">');
                        nuevo.append('<input type="hidden" name="secciones.' + msg + '.css" id="' + msg + 'css" value="">');
                        nuevo.append("<div id='" + msg + "Contenido'></div>");

                        botonDelete.click(function() {
                            deleteSeccion($(this));
                            return false;
                        });
                        botonPropiedades.click(function() {
                            propiedadesSeccion($(this));
                            return false;
                        });
                        botonEditar.click(function() {
                            contenidoSeccion($(this));
                            return false;
                        });
                    }
                });


                nuevo.hoverIntent(config);
                $("#worckSpace").append(nuevo);
                eventos(nuevo);
//        nuevo.resizable({
//                    minHeight: 30,
//                    minWidth: 150,
//                    handles: 'n, e, s, w, se, sw',
//                    stop: function(event, ui) {
//                        registrarTam(nuevo.attr("id"));
//                    }})
//        nuevo.draggable({
//                    stop: function(event, ui) {
//                        registrarPosicion(nuevo.attr("id"));
//                    },
//                    cancel: ".delete, .propiedades, .contenido"
//                });
//        nuevo.click(function() {
//            $divSelected = $(this);
//            var iframeRef = window.parent.document.getElementById("contenido");
//            $(iframeRef).focus();
//        });

            });

            $("#borrarPag").click(function() {
                if (confirm("Esta seguro que desea eliminar esta página? esta acción es irreversible")) {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(controller:'editor',action:'deletePagina')}",
                        data: "id=" + $(this).attr("pagina"),
                        success: function(msg) {
                            if (msg == "ok")
                                window.parent.location.reload()
                            else
                                alert(msg)
                        }});
                }
            });

            /***********procesos***********/

            /***********menu***********/
            $("ul.subnav").parent().append("<span></span>"); //Only shows drop down trigger when js is enabled (Adds empty span tag after ul.subnav*)

            $("ul.topnav li span, #seccion").click(
                    function() { //When trigger is clicked...

                        //Following events are applied to the subnav itself (moving subnav up and down)
                        $(this).parent().find("ul.subnav").slideDown('fast').show(); //Drop down the subnav on click

                        $(this).parent().hover(function() {
                        }, function() {
                            $(this).parent().find("ul.subnav").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up
                        });

                        //Following events are applied to the trigger (Hover events for the trigger)
                    }).hover(function() {
                        $(this).addClass("subhover"); //On hover over, add class "subhover"
                    }, function() {  //On Hover Out
                        $(this).removeClass("subhover"); //On hover out, remove class "subhover"
                    });

            $("#editarLayout").click(function() {
                window.location.href = "${createLink(action:"nuevaPagina")}/${pagina.layout.id}"
            });
            /***********menu***********/

            /***********prettyPhoto***********/
            $.fn.prettyPhoto()
            $("#ver").click(function() {
                $.prettyPhoto.open("../../paginaWeb/show?pagina=${pagina.nombre}&iframe=true&width=100%&height=100%", "Página: ${pagina.nombre}", "Previsualización");
            });
            $(".linkFotoLight").click(function() {
                $.prettyPhoto.open($(this).attr("src"), "preview", "Previsualización");
            })
            /***********prettyPhoto***********/

        </script>
    </body>
</html>