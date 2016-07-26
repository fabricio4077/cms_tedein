
<%@ page import="nth.Pagina" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pagina.label', default: 'Pagina')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'pagina.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nombre" title="${message(code: 'pagina.nombre.label', default: 'Nombre')}" />
                        
                            <g:sortableColumn property="menu" title="${message(code: 'pagina.menu.label', default: 'Menu')}" />
                        
                            <th><g:message code="pagina.layout.label" default="Layout" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${paginaInstanceList}" status="i" var="paginaInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${paginaInstance.id}">${fieldValue(bean: paginaInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: paginaInstance, field: "nombre")}</td>
                        
                            <td>${fieldValue(bean: paginaInstance, field: "menu")}</td>
                        
                            <td>${fieldValue(bean: paginaInstance, field: "layout")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${paginaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
