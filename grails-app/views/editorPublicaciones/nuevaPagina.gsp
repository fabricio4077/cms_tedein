<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="frame"/>
    <title>CMS - NTH</title>

    <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hoverIntent.minified.js')}" type="text/javascript"
            charset="utf-8"></script>

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
    </style>
</head>

<body>

<ul class="topnav ui-corner-all" style="position:absolute; top:2px;z-index:1999;">
    <li title="Crear una p&aacute;gina utilizando el dise&ntilde;o actual"><a href="#" id="guardar">Crear Página</a>
    </li>
</ul>

<div id="divBody" style="position:relative;width:100%;height:90%;margin-top:40px;overflow:auto;${layout?.css}">
    <g:if test="${layout}">
        <g:if test="${layout.banner!=null}">
            <div class="drag" seccion="${layout?.banner?.id}" id="banner"
                 style="position:absolute;z-index:1;top:${(layout?.banner?.top > -1) ? layout?.banner?.top : "5px"};left:${(layout?.banner?.izq > -1) ? layout?.banner?.izq : "200px"};width:${(layout?.banner?.width) ? layout?.banner?.width : "400px"};height:${(layout?.banner?.height) ? layout?.banner?.height : "60px"}; ${(layout?.banner?.css) ? layout?.banner?.css : "border:1px #0099ff solid;cursor:move;background:rgba(0,0,200,0.3);"};">
                <elm:barrita title="Banner" botones="${['eliminar', 'propiedades','editar']}" float="right" id="banner"
                             param="seccion='banner'"/>
                <div id="bannerContenido">
                    <g:if test="${layout?.banner.foto}">
                        ${ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: layout?.banner?.foto?.id), "alt": layout?.banner?.foto?.caption, "title": layout?.banner?.foto?.caption, "thumbnailSrc": g.createLink(action: 'showImage', controller: 'image', id: layout?.banner?.foto?.id, params: [thumbnail: false])])}
                    </g:if>
                    <g:else>
                        <g:if test="${layout.banner?.contenido}">
                            <g:mostrarSeccion id="${layout.banner.id}" idioma="${session.idioma.id}"
                                              tipo="Borrador"></g:mostrarSeccion>
                        </g:if>
                    </g:else>
                </div>
            </div>
        </g:if>
    </g:if>
    <g:else>
        <div class="drag" id="banner"
             style="position:absolute;z-index:1;top:${(layout?.banner?.top > -1) ? layout?.banner?.top : "5px"};left:${(layout?.banner?.izq > -1) ? layout?.banner?.izq : "200px"};width:${(layout?.banner?.width) ? layout?.banner?.width : "400px"};height:${(layout?.banner?.height) ? layout?.banner?.height : "60px"}; ${(layout?.banner?.css) ? layout?.banner?.css : "border:1px #0099ff solid;cursor:move;background:rgba(0,0,200,0.3);"};">
            <elm:barrita title="Banner" botones="${['eliminar','editar', 'propiedades']}" float="right" id="banner"
                         param="seccion='banner'"/>
            <div id="bannerContenido">

            </div>
        </div>
    </g:else>

    <g:if test="${layout}">
        <g:if test="${layout.menu!=null}">
            <div class="drag" id="menu"
                 style="position:absolute;z-index:2;top:${(layout?.menu?.top > -1) ? layout?.menu?.top : "70px"};left:${(layout?.menu?.izq > -1) ? layout?.menu?.izq : "200px"};width:${(layout?.menu?.width) ? layout?.menu?.width : "400px"};height:${(layout?.menu?.height) ? layout?.menu?.height : "40px"}; ${(layout?.menu?.css) ? layout?.menu?.css : "border:1px #ff9999 solid;cursor:move;background:rgba(200,0,0,0.3);"};">
                <elm:barrita title="Men&uacute;" botones="${['eliminar','editar', 'propiedades']}" float="right"
                             id="menu" param="seccion='menu'"/>
                <div id="menuContenido"></div>
            </div>
        </g:if>
    </g:if>
    <g:else>
        <div class="drag" id="menu"
             style="position:absolute;z-index:2;top:${(layout?.menu?.top > -1) ? layout?.menu?.top : "70px"};left:${(layout?.menu?.izq > -1) ? layout?.menu?.izq : "200px"};width:${(layout?.menu?.width) ? layout?.menu?.width : "400px"};height:${(layout?.menu?.height) ? layout?.menu?.height : "40px"}; ${(layout?.menu?.css) ? layout?.menu?.css : "border:1px #ff9999 solid;cursor:move;background:rgba(200,0,0,0.3);"};">
            <elm:barrita title="Men&uacute;" botones="${['eliminar','editar', 'propiedades']}" float="right" id="menu"
                         param="seccion='menu'"/>
            <div id="menuContenido"></div>
        </div>
    </g:else>
    <div class="drag " id="contenido"
         style="position:absolute;z-index:3;top:${(layout?.contenido?.top > -1) ? layout?.contenido?.top : "120px"};left:${(layout?.contenido?.izq > -1) ? layout?.contenido?.izq : "200px"};width:${(layout?.contenido?.width) ? layout?.contenido?.width : "400px"};height:${(layout?.contenido?.height) ? layout?.contenido?.height : "400px"}; ${(layout?.contenido?.css) ? layout?.contenido?.css : "border:1px #cccccc solid;cursor:move;background:rgba(204,204,204,0.3);"};">
        <elm:barrita title="Contenido" botones="${['propiedades']}" float="right" id="contenido"
                     param="seccion='contenido'"/>

    </div>
</div>


<div id="ventanaPagina" style="display:none">
    <g:form class="formLayout" action="guardarPagina" controller="editor" enctype="multipart/form-data">
        <input type="hidden" name="banner.top" id="btop" value="${(layout?.banner?.top) ? layout?.banner?.top : "5"}">
        <input type="hidden" name="banner.izq" id="bizq" value="${(layout?.banner?.izq) ? layout?.banner?.izq : "200"}">
        <input type="hidden" name="banner.width" id="bwid"
               value="${(layout?.banner?.width) ? layout?.banner?.width : "400"}">
        <input type="hidden" name="banner.height" id="bhei"
               value="${(layout?.banner?.height) ? layout?.banner?.height : "60"}">
        <input type="hidden" name="banner.css" id="bcss" value="${(layout?.banner?.css) ? layout?.banner?.css : ""}">
        <input type="hidden" name="banner.tipo" value="Layout">
        <input type="hidden" name="menu.top" id="mtop" value="${(layout?.menu?.top) ? layout?.menu?.top : "70"}">
        <input type="hidden" name="menu.izq" id="mizq" value="${(layout?.menu?.izq) ? layout?.menu?.izq : "200"}">
        <input type="hidden" name="menu.width" id="mwid" value="${(layout?.menu?.width) ? layout?.menu?.width : "400"}">
        <input type="hidden" name="menu.height" id="mhei"
               value="${(layout?.menu?.height) ? layout?.menu?.height : "40"}">
        <input type="hidden" name="menu.css" id="mcss" value="${(layout?.menu?.css) ? layout?.menu?.css : ""}">
        <input type="hidden" name="menu.tipo" value="Layout">
        <input type="hidden" name="contenido.top" id="ctop"
               value="${(layout?.contenido?.top) ? layout?.contenido?.top : "120"}">
        <input type="hidden" name="contenido.izq" id="cizq"
               value="${(layout?.contenido?.izq) ? layout?.contenido?.izq : "200"}">
        <input type="hidden" name="contenido.width" id="cwid"
               value="${(layout?.contenido?.width) ? layout?.contenido?.width : "400"}">
        <input type="hidden" name="contenido.height" id="chei"
               value="${(layout?.contenido?.height) ? layout?.contenido?.height : "400"}">
        <input type="hidden" name="contenido.css" id="ccss"
               value="${(layout?.contenido?.css) ? layout?.contenido?.css : ""}">
        <input type="hidden" name="contenido.tipo" value="Layout">
        <input type="hidden" name="layout.id" value="${layout?.id}" id="layout">
        <input type="hidden" name="pagina.nombre" id="hnombre">
        <input type="hidden" name="pagina.menu" id=hmenu>
        <input type="hidden" name="pagina.orden" id=horden>
        <input type="hidden" name="layout.nombre" id="lnombre" value="${layout?.nombre}">
        <input type="hidden" name="layout.descripcion" id="ldes" value="${layout?.descripcion}">
        <input type="hidden" name="pagina.tipo" id="pagTipo" value="${pagina?.tipo?.nombre}">
        <g:if test="${layout}">
            <input type="hidden" name="layout.menu" id="layMenu" value="${(layout?.menu != null) ? '1' : '0'}">
            <input type="hidden" name="layout.banner" id="layBanner" value="${(layout?.banner != null) ? '1' : '0'}">
        </g:if>
        <g:else>
            <input type="hidden" name="layout.menu" id="layMenu" value="1">
            <input type="hidden" name="layout.banner" id="layBanner" value="1">
        </g:else>
        <div class="fila">
            <div class="label" style="width:120px;">Nombre:</div>

            <div class="valor" style="float:left">
                <input class="ui-widget-content ui-corner-all ui-state-default" type="text" id="pnombre"/>
            </div>
        </div>

        <div class="fila">
            <div class="label" style="width:120px;">Menú:</div>

            <div class="valor" style="float:left">
                <input class="ui-widget-content ui-corner-all ui-state-default" type="text" id="pmenu"/>
            </div>
        </div>

        <div class="fila">
            <div class="label" style="width:120px;">Orden:</div>

            <div class="valor" style="float:left">
                <g:select from="${orden}" name="orden" id="porden" style="width:60px;"></g:select>
            </div>
        </div>

        <div class="fila" id="fotoPag" style="display:none;">
            <div class="label" style="width:120px;">Imagen:</div>

            <div class="valor" style="float:left">
                <input type="file" id="data" name="data"/>
            </div>
        </div>
        <g:if test="${layout==null}">
            <div class="fila">
                <div class="label" style="width:120px;">Nombre del diseño:</div>

                <div class="valor" style="float:left">
                    <input class="ui-widget-content ui-corner-all ui-state-default" type="text" id="lpnombre"/>
                </div>
            </div>

            <div class="fila">
                <div class="label" style="width:120px;">Descripción:</div>

                <div class="valor" style="float:left">
                    <input class="ui-widget-content ui-corner-all ui-state-default" type="textarea" id="lpdes"/>
                </div>
            </div>
        </g:if>
    </g:form>
</div>

<div id="ventanaLayout" style="display:none">

    <div class="fila">
        <div class="label">Nombre del diseño:</div>

        <div class="valor">
            <input class="ui-widget-content ui-corner-all ui-state-default" type="text" id="lpnombre2"
                   value="${layout?.nombre}"/>
        </div>
    </div>

    <div class="fila">
        <div class="label">Descripción:</div>

        <div class="valor">
            <input class="ui-widget-content ui-corner-all ui-state-default" type="textarea" id="lpdes2"
                   value="${layout?.descripcion}"/>
        </div>
    </div>

</div>

<div id="carga" style="display:none">

</div>

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
                        <th style="border:1px black solid;" class="ui-state-active">Propiedad</th>
                        <th style="border:1px black solid" class="ui-state-active">Valor</th>
                    </thead>
                    <tbody>
                        <g:set var="grupo" value=""></g:set>
                        <g:each in="${props}" var="prop" status="i">
                            <g:if test="${prop.grupo!=grupo}">
                                <tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">
                                    <td>${prop.grupo}</td>
                                    <g:set var="grupo" value="${prop.grupo}"></g:set>
                                </tr>
                            </g:if>
                            <tr title="${prop.explicacion}">
                                <td style="border:1px black solid;padding-left:5px;" class="ui-state-active">
                                    ${prop.mostrar}
                                </td>
                                <td style="border:1px black solid;">
                                    %{--<input type="textfield" id="V${prop.nombre}" nombre="${prop.nombre}" sufijo="${prop.sufijo}" size="8" class="propiedad" style="background: orange;">--}%
                                    <elm:item propiedad="${prop}" id="V${prop.nombre}" nombre="${prop.nombre}"
                                              sufijo="${(prop.sufijo)?prop.sufijo:''}" class="propiedad"/>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

        </div>

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
    <button id="reloadBanner">RELOAD</button>
</div>

<div id="dlg_propiedades">
    <g:form action="saveBodyProp" class="saveBodyProp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="layout" value="${layout?.id}"/>
        <input type="hidden" name="width" id="wl"/>
        <input type="hidden" name="height" id="hl"/>
        <table style="width:250px;">
    <thead>
        <th style="border:1px black solid;" class="ui-state-active">Propiedad</th>
        <th style="border:1px black solid" class="ui-state-active">Valor</th>
    </thead>
    <tbody>
        <tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">
            <td>Fondo</td>
        </tr>
        <g:each in="${np}" var="prop">
            <tr title="${prop.explicacion}">
                <td style="border:1px black solid;padding-left:5px;" class="ui-state-active">
                    ${prop.mostrar}
                </td>
                <td style="border:1px black solid;">
                    %{--<input type="textfield" id="V${prop.nombre}" nombre="${prop.nombre}" sufijo="${prop.sufijo}" size="8" class="propiedad" style="background: orange;">--}%
                    <elm:item propiedad="${prop}" id="V${prop.nombre}" nombre="${prop.nombre}"
                              sufijo="${(prop.sufijo)?prop.sufijo:''}" class="propiedad"/>
                </td>
            </tr>
        </g:each>
        </tbody>
    </g:form>
</table>
</div>

<script type="text/javascript">

    $("#reloadBanner").click(function() {
        location.href = "${createLink(action:'nuevaPagina')}/${layout?.id}"

    });

    /***********barrita***********/
    $(".drag").hoverIntent({
        timeout: 500, // number = milliseconds delay before onMouseOut
        over: function() {
            $("#barra_" + $(this).attr("id")).show();
        },
        out: function() {
            $("#barra_" + $(this).attr("id")).hide("explode");
        }
    });

    $(".propiedades").click(function() {
        $("#ventanaPropiedades").show();
        var seccion = $(this).parent().attr("seccion");
        cargaPropiedades(seccion);
        $("#vpSeccion").val(seccion);
        $("#ventanaPropiedades").find("#ui-dialog-title-dialog").text('Propiedades (' + seccion + ')');
    });

    $(".delete").click(function() {
        if (confirm("Esta accion no puede ser revertida...Continuar?")) {
            if ($(this).parent().attr("seccion") == "menu") {
                $("#layMenu").val("0")
            }
            if ($(this).parent().attr("seccion") == "banner") {
                $("#layBanner").val("0")
            }
            $(this).parent().parent().remove();
        }
    });

    $(".contenido").click(function() {

        if ($("#layout").val() != "") {
            if ($(this).parent().attr("seccion") == "banner") {
                var url = '${g.createLink(action:"editarBanner")}?id=' + $("#layout").val()
                child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=715,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                if (child.opener == null) child.opener = self;
                window.toolbar.visible = false;
                window.menubar.visible = false;
            }
        } else {
            alert("Primero guarde el layout")
        }
    });
    /***********barrita***********/


    /***********menu***********/
    $("ul.subnav").parent().append("<span></span>"); //Only shows drop down trigger when js is enabled (Adds empty span tag after ul.subnav*)

    $("ul.topnav li span, #seccion , #tipo").click(
            function() { //When trigger is clicked...

                //Following events are applied to the subnav itself (moving subnav up and down)
                $(this).parent().find("ul.subnav").slideDown('fast').show(); //Drop down the subnav on click
                //alert($(this).parent().attr("at"))
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

    $(".layout").click(function() {
        var txt = $(this).attr("tipo");
        window.location = "${createLink(action:'nuevaPagina', controller:'editor')}" + "/?id=" + txt;
    });

    $("#guardar").click(function() {
        $("#ventanaPagina").dialog("open");
        if ($("#layMenu").val() == "0" && $("#layBanner").val() == "0") {
            $("#pagTipo").val("Galeria");
        } else {
            $("#pagTipo").val("1");
        }
        if ($("#pagTipo").val() != "1") {
            $("#fotoPag").show();
        }
    });

    $(".tipoPagina").click(function() {
        $("#pagTipo").val($(this).attr("tipo"))
        if ($(this).attr("tipo") == 1) {
            $("#banner").show("explode")
            $("#menu").show("explode")
            $("#layMenu").val("1")
            $("#layBanner").val("1")
        } else {
            $("#banner").hide("explode")
            $("#menu").hide("explode")
            $("#layMenu").val("0")
            $("#layBanner").val("0")

        }
    });

    $("#guardarLayout").click(function() {
        $("#ventanaLayout").dialog("open")
    });

    $("#borrarLayout").click(function() {
        if (confirm("Esta seguro? esta acción es irreversible ")) {
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'editor',action:'eliminarLayout')}",
                data: "layout=" + $("#layout").val(),
                success: function(msg) {

                    if (msg == "ok") {
                        window.location.href = "${createLink(controller:"editor",action:"nuevaPagina")}"
                    } else {
                        alert("El diseño no pudo ser eliminado, esta siendo referenciado por páginas en el sitio. Primero debe eliminar las páginas que usen el diseño")
                    }
                }
            });
        }
    });

    $("#reset").click(function() {
        if (confirm("Todo el contenido que no haya sido guardado se perdera... Continuar?"))
            window.location.href = "${createLink(controller:"editor",action:"nuevaPagina")}"
    });

    $("#propiedades").click(function() {
        if ($("#layout").val() != "") {
            $("#dlg_propiedades").dialog("open");
        } else {
            alert("Primero guarde el layout")
        }
        return false;
    });

    /***********menu***********/

    function vaciar() {
        $(".propiedad").each(function() {
            $(this).val("")
        });
    }
    function cargaPropiedades(seccion) {
        vaciar();
        if ($("#" + seccion.charAt(0) + "css").val() != "" && $("#" + seccion.charAt(0) + "css").val() != null) {
            var propiedades = $("#" + seccion.charAt(0) + "css").val().split(";")
            $.each(propiedades, function() {
                if (this.length > 4) {
                    var valor = this.split(":");
                    if (valor[0] != "background" && valor[0] != "background-alpha") {
                        if (valor[1].charAt(valor[1].length - 2) != "p") {
                            $("#V" + valor[0]).val(valor[1]);
                        } else {
                            $("#V" + valor[0]).val(valor[1].substring(0, valor[1].length - 2));
                        }
                    } else {
                        var parts = valor[1].substring(5, valor[1].length - 1)
                        parts = parts.split(",")
                        var r = parseInt(parts[0]).toString(16);
                        var g = parseInt(parts[1]).toString(16);
                        var b = parseInt(parts[2]).toString(16);
                        var a = parts[3] * 100;

                        $("#Vbackground").val("#" + r + g + b);
                        $("#Vbackground-alpha").val(a);
                    }
                }
            });
            $("#Vwidth").val($("#" + seccion.charAt(0) + "wid").val());
            $("#Vheight").val($("#" + seccion.charAt(0) + "hei").val());
            $("#Vtop").val($("#" + seccion.charAt(0) + "top").val());
            $("#Vleft").val($("#" + seccion.charAt(0) + "izq").val());
        } else {
            $(".listaPropiedades").val("")
            $("#Vwidth").val($("#" + seccion.charAt(0) + "wid").val());
            $("#Vheight").val($("#" + seccion.charAt(0) + "hei").val());
            $("#Vtop").val($("#" + seccion.charAt(0) + "top").val());
            $("#Vleft").val($("#" + seccion.charAt(0) + "izq").val());
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
    function registrarPosicion() {
        if ($("#layBanner").val() != "0") {
            var position = $("#banner").position()
            $("#btop").val(position.top)
            $("#bizq").val(position.left)
            if ($("#vpSeccion").val() == "banner") {
                $("#Vtop").val(position.top)
                $("#Vleft").val(position.left)


            }
        }
        if ($("#layMenu").val() != "0") {
            position = $("#menu").position()
            $("#mtop").val(position.top)
            $("#mizq").val(position.left)
            if ($("#vpSeccion").val() == "menu") {
                $("#Vtop").val(position.top)
                $("#Vleft").val(position.left)
            }
        }
        position = $("#contenido").position()
        $("#ctop").val(position.top)
        $("#cizq").val(position.left)
        if ($("#vpSeccion").val() == "contenido") {
            $("#Vtop").val(position.top)
            $("#Vleft").val(position.left)
        }
    }
    function registrarTam() {

        if ($("#layBanner").val() != "0") {
            $("#bwid").val($("#banner").width())
            $("#bhei").val($("#banner").height())
            if ($("#vpSeccion").val() == "banner") {
                $("#Vwidth").val($("#banner").width())
                $("#Vheight").val($("#banner").height())
            }
        }
        if ($("#layMenur").val() != "0") {
            $("#mwid").val($("#menu").width())
            $("#mhei").val($("#menu").height())
            if ($("#vpSeccion").val() == "menu") {
                $("#Vwidth").val($("#menu").width())
                $("#Vheight").val($("#menu").height())
            }
        }

        $("#cwid").val($("#contenido").width())
        $("#chei").val($("#contenido").height())
        if ($("#vpSeccion").val() == "contenido") {
            $("#Vwidth").val($("#contenido").width())
            $("#Vheight").val($("#contenido").height())
        }
    }
    //cargaTabla();

    $("#ventanaPropiedades").draggable({
        handle: ".ui-dialog-titlebar",
        cancel: ".ui-icon",
        containment: "parent"
    });

    $("#btnHide").click(function() {

        $("#ventanaPropiedades").hide();
        return false;

//    $("#contenidoProps").toggle();
//    if ($(this).attr("shown") == "1") {
//      $("#contenidoProps").hide();
//      $("#ventanaPropiedades").animate({
//        height: 35
//      });
//      $(this).children().first().removeClass("ui-icon-circle-triangle-n");
//      $(this).children().first().addClass("ui-icon-circle-triangle-s");
//      $(this).attr({
//        shown: "0",
//        title: "Mostrar"
//      });
//    } else {
//      $("#ventanaPropiedades").animate({
//        height: 495
//      });
//      $(this).children().first().removeClass("ui-icon-circle-triangle-s");
//      $(this).children().first().addClass("ui-icon-circle-triangle-n");
//      $(this).attr({
//        shown: "1",
//        title: "Ocultar"
//      });
//      $("#contenidoProps").show();
//    }
    });

    $("#btnAplicar").button().click(function() {
        var div = $("#" + $("#vpSeccion").val());
        var rgba, a, hex, ahex;
        $("#" + $("#vpSeccion").val().charAt(0) + "css").val("");
        $(this).parent().parent().prev().find(".propiedad:visible").each(function() {
            if ($(this).attr("nombre") != "top" && $(this).attr("nombre") != "left" && $(this).attr("nombre") != "width" && $(this).attr("nombre") != "height" && $(this).attr("nombre") != "background" && $(this).attr("nombre") != "background-alpha") {
                if ($(this).val() != "" && $(this).val() != "0" && $(this).val() != "-1") {
                    div.css($(this).attr("nombre"), $(this).val());
                    $("#" + $("#vpSeccion").val().charAt(0) + "css").val($("#" + $("#vpSeccion").val().charAt(0) + "css").val() + ";" + $(this).attr("nombre") + ":" + $(this).val() + $(this).attr("sufijo"));
                }
            } else {
                if ($(this).attr("nombre") == "background") {
                    hex = $(this).val();
                    var r = parseInt(hex.substring(1, 3), 16);
                    var g = parseInt(hex.substring(3, 5), 16);
                    var b = parseInt(hex.substring(5, 7), 16);

                    rgba = "rgba(" + r + "," + g + "," + b + ",";
                } else if ($(this).attr("nombre") == "background-alpha") {
                    a = parseInt($(this).val()) / 100;
                } else {
                    if ($(this).val() != "" && $(this).val() != "0" && $(this).val() != "-1") {
                        div.css($(this).attr("nombre"), $(this).val());
                        $("#" + $("#vpSeccion").val().charAt(0) + $(this).attr("nombre").substring(0, 3)).val($(this).val());
                    }
                }
            }
        });
        rgba += a + ")";
        div.css("background", rgba);
        $("#" + $("#vpSeccion").val().charAt(0) + "css").val($("#" + $("#vpSeccion").val().charAt(0) + "css").val() + ";background:" + rgba);
    });

    $("#dlg_propiedades").dialog({
        autoOpen: false,
        title:"Propiedades del cuerpo de la p&aacute;gina",
        width: 455,
        position:"right",
        buttons: {
            "Guardar": function() {
                var color = $("#Vbackground-color").val();
                $("#divBody").css("background-color", color);

                var w = $("#divBody").width();
                var h = $("#divBody").height();

                $("#wl").val(w);
                $("#hl").val(h);

                $(".saveBodyProp").submit();
            }
        }
    });

    $("#ventanaPagina").dialog({
        autoOpen: false,
        resizable:true,
        modal:true,
        draggable:true,
        width:390,
//                height:400,
        position: "center",
        title:"Nombres",
        buttons:{
            "Aceptar":function() {
                $("#hnombre").val($("#pnombre").val());
                $("#hmenu").val($("#pmenu").val());
                $("#horden").val($("#porden").val());
                $("#lnombre").val($("#lpnombre").val());
                $("#ldes").val($("#lpdes").val());
                $(".formLayout").submit();
            }
        }
    });
    $("#ventanaLayout").dialog({
        autoOpen: false,
        resizable:true,
        modal:true,
        draggable:true,
        width:330,
//                height:400,
        position: "center",
        title:"Nombres",
        buttons:{
            "Aceptar":function() {
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'editor',action:'guardarLayout')}",
                    data: "nombre=" + $("#lpnombre2").val() + "&descripcion=" + $("#lpdes2").val() + "&" + $(".formLayout").serialize(),
                    success: function(msg) {

                        if (msg != "ok") {
                            var parts = msg.split("_");
                            var id = parts[0];
                            var nombre = parts[1];

//                        $("#layout", window.parent.document).click();

                            var menu = $(".menu", window.parent.document);

                            var boton = $("<a id='btn_pag_" + id + "' href='${createLink(action: 'nuevaPagina', controller: 'editor')}/" + id + "?add=false' class='boton' target='contenido'>" + nombre + "</a>");
                            //console.log(id);
                            //console.log(nombre);
                            //console.log(boton);
                            boton.button();
                            menu.append(boton);

                        }
                        window.location.reload();
                        %{--var menu = $(".menu", window.parent.document);--}%

                        %{--var boton = $("<a id='btn_pag_${pagina?.id}}' href='${createLink(action: 'editarPagina', controller: 'editor')}/?id=${pagina?.id}' class='boton' target='contenido'>${pagina?.nombre}</a>");--}%
                        %{--boton.button();--}%
                        %{--menu.append(boton);--}%
                    }
                });
            }
        }
    });

    $(".boton").button();
    //            $("#guardar").button("option", "icons", {primary:'ui-icon-disk'});

    $(".drag").draggable({
        stop: function(event, ui) {
            registrarPosicion();
        },
        cancel: ".delete, .propiedades"
//                containment:"parent"
    });
    $(".drag").resizable({
        minHeight: 40,
        minWidth: 200,
        stop: function(event, ui) {
            registrarTam();
        },
//                containment:"parent",
        handles: 'n,s,e,w,se,sw'
    });
</script>
</body>
</html>