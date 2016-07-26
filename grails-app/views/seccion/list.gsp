
<%@ page import="nth.Seccion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'seccion.label', default: 'Seccion')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'seccion.id.label', default: 'Id')}" />
                        
                            <th><g:message code="seccion.pagina.label" default="Pagina" /></th>
                        
                            <g:sortableColumn property="nombre" title="${message(code: 'seccion.nombre.label', default: 'Nombre')}" />
                        
                            <g:sortableColumn property="css" title="${message(code: 'seccion.css.label', default: 'Css')}" />
                        
                            <g:sortableColumn property="top" title="${message(code: 'seccion.top.label', default: 'Top')}" />
                        
                            <g:sortableColumn property="izq" title="${message(code: 'seccion.izq.label', default: 'Izq')}" />

                            <g:sortableColumn property="width" title="${message(code: 'seccion.width.label', default: 'Width')}" />

                            <g:sortableColumn property="height" title="${message(code: 'seccion.height.label', default: 'Height')}" />

                            <g:sortableColumn property="tipo" title="${message(code: 'seccion.tipo.label', default: 'Tipo')}" />

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${seccionInstanceList}" status="i" var="seccionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${seccionInstance.id}">${fieldValue(bean: seccionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: seccionInstance, field: "pagina")}</td>
                        
                            <td>${fieldValue(bean: seccionInstance, field: "nombre")}</td>
                        
                            <td>${fieldValue(bean: seccionInstance, field: "css")}</td>
                        
                            <td>${fieldValue(bean: seccionInstance, field: "top")}</td>
                        
                            <td>${fieldValue(bean: seccionInstance, field: "izq")}</td>

                            <td>${fieldValue(bean: seccionInstance, field: "width")}</td>

                            <td>${fieldValue(bean: seccionInstance, field: "height")}</td>

                            <td>${fieldValue(bean: seccionInstance, field: "tipo")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${seccionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
