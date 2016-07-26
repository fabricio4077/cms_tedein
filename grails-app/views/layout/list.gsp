
<%@ page import="nth.Layout" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'layout.label', default: 'Layout')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'layout.id.label', default: 'Id')}" />
                        
                            <th><g:message code="layout.contenido.label" default="Contenido" /></th>
                        
                            <th><g:message code="layout.menu.label" default="Menu" /></th>
                        
                            <th><g:message code="layout.banner.label" default="Banner" /></th>
                        
                            <th><g:message code="layout.idioma.label" default="Idioma" /></th>
                        
                            <g:sortableColumn property="nombre" title="${message(code: 'layout.nombre.label', default: 'Nombre')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${layoutInstanceList}" status="i" var="layoutInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${layoutInstance.id}">${fieldValue(bean: layoutInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: layoutInstance, field: "contenido")}</td>
                        
                            <td>${fieldValue(bean: layoutInstance, field: "menu")}</td>
                        
                            <td>${fieldValue(bean: layoutInstance, field: "banner")}</td>
                        
                            <td>${fieldValue(bean: layoutInstance, field: "idioma")}</td>
                        
                            <td>${fieldValue(bean: layoutInstance, field: "nombre")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${layoutInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
