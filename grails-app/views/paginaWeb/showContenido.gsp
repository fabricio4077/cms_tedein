<div class="contendido" style="position:absolute;top:${pagina.layout.contenido.top};left:${pagina.layout.contenido.izq};width:${pagina.layout.contenido.width};height:${pagina.layout.contenido.height}; ${pagina.layout.contenido.css}">
<g:each in="${pagina.secciones}" var="seccion">
    <g:mostrarSeccion id="${seccion.id}" idioma="${session.idioma.id}" tipo="Borrador"></g:mostrarSeccion>
</g:each>
</div>

