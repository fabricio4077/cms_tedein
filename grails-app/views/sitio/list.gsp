
<%@ page import="nth.Sitio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sitio.label', default: 'Sitio')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'sitio.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nombre" title="${message(code: 'sitio.nombre.label', default: 'Nombre')}" />
                        
                            <g:sortableColumn property="organizacion" title="${message(code: 'sitio.organizacion.label', default: 'Organizacion')}" />
                        
                            <g:sortableColumn property="contacto" title="${message(code: 'sitio.contacto.label', default: 'Contacto')}" />
                        
                            <g:sortableColumn property="telefono" title="${message(code: 'sitio.telefono.label', default: 'Telefono')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${sitioInstanceList}" status="i" var="sitioInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${sitioInstance.id}">${fieldValue(bean: sitioInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: sitioInstance, field: "nombre")}</td>
                        
                            <td>${fieldValue(bean: sitioInstance, field: "organizacion")}</td>
                        
                            <td>${fieldValue(bean: sitioInstance, field: "contacto")}</td>
                        
                            <td>${fieldValue(bean: sitioInstance, field: "telefono")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${sitioInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
