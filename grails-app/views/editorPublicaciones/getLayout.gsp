<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/25/11
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>

<div style="position: relative; width: 100%; height: 1000px; ${layout?.css}">
    <g:if test="${layout}">
        <g:if test="${layout.banner!=null}">
            <div class="drag" seccion="${layout?.banner?.id}" id="banner"
                 style="position:absolute;z-index:1;top:${(layout?.banner?.top > -1) ? layout?.banner?.top : "5px"};left:${(layout?.banner?.izq > -1) ? layout?.banner?.izq : "200px"};width:${(layout?.banner?.width) ? layout?.banner?.width : "400px"};height:${(layout?.banner?.height) ? layout?.banner?.height : "60px"}; ${(layout?.banner?.css) ? layout?.banner?.css : "border:1px #0099ff solid;cursor:move;background:rgba(0,0,200,0.3);"};">
                <elm:barrita title="Banner" botones="${['eliminar', 'propiedades','editar']}" float="right" id="banner"
                             param="seccion='banner'" />
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
                         param="seccion='banner'" />
            <div id="bannerContenido">

            </div>
        </div>
    </g:else>

    <g:if test="${layout}">
        <g:if test="${layout.menu!=null}">
            <div class="drag" id="menu"
                 style="position:absolute;z-index:2;top:${(layout?.menu?.top > -1) ? layout?.menu?.top : "70px"};left:${(layout?.menu?.izq > -1) ? layout?.menu?.izq : "200px"};width:${(layout?.menu?.width) ? layout?.menu?.width : "400px"};height:${(layout?.menu?.height) ? layout?.menu?.height : "40px"}; ${(layout?.menu?.css) ? layout?.menu?.css : "border:1px #ff9999 solid;cursor:move;background:rgba(200,0,0,0.3);"};">
                <elm:barrita title="Men&uacute;" botones="${['eliminar','editar', 'propiedades']}" float="right"
                             id="menu" param="seccion='menu'" />
                <div id="menuContenido"></div>
            </div>
        </g:if>
    </g:if>
    <g:else>
        <div class="drag" id="menu"
             style="position:absolute;z-index:2;top:${(layout?.menu?.top > -1) ? layout?.menu?.top : "70px"};left:${(layout?.menu?.izq > -1) ? layout?.menu?.izq : "200px"};width:${(layout?.menu?.width) ? layout?.menu?.width : "400px"};height:${(layout?.menu?.height) ? layout?.menu?.height : "40px"}; ${(layout?.menu?.css) ? layout?.menu?.css : "border:1px #ff9999 solid;cursor:move;background:rgba(200,0,0,0.3);"};">
            <elm:barrita title="Men&uacute;" botones="${['eliminar','editar', 'propiedades']}" float="right" id="menu"
                         param="seccion='menu'" />
            <div id="menuContenido"></div>
        </div>
    </g:else>
    <div class="drag " id="contenido"
         style="position:absolute;z-index:3;top:${(layout?.contenido?.top > -1) ? layout?.contenido?.top : "120px"};left:${(layout?.contenido?.izq > -1) ? layout?.contenido?.izq : "200px"};width:${(layout?.contenido?.width) ? layout?.contenido?.width : "400px"};height:${(layout?.contenido?.height) ? layout?.contenido?.height : "400px"}; ${(layout?.contenido?.css) ? layout?.contenido?.css : "border:1px #cccccc solid;cursor:move;background:rgba(204,204,204,0.3);"};">
        <elm:barrita title="Contenido" botones="${['propiedades']}" float="right" id="contenido"
                     param="seccion='contenido'" />

    </div>
</div>