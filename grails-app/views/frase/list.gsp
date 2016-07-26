
<%@ page import="nth.Frase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'frase.label', default: 'Frase')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'frase.id.label', default: 'Id')}" />
                        
                            <th><g:message code="frase.idioma.label" default="Idioma" /></th>
                        
                            <g:sortableColumn property="estado" title="${message(code: 'frase.estado.label', default: 'Estado')}" />
                        
                            <g:sortableColumn property="frase" title="${message(code: 'frase.frase.label', default: 'Frase')}" />
                        
                            <th><g:message code="frase.articulo.label" default="Articulo" /></th>
                        
                            <th><g:message code="frase.foto.label" default="Foto" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fraseInstanceList}" status="i" var="fraseInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${fraseInstance.id}">${fieldValue(bean: fraseInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: fraseInstance, field: "idioma")}</td>
                        
                            <td>${fieldValue(bean: fraseInstance, field: "estado")}</td>
                        
                            <td>${fieldValue(bean: fraseInstance, field: "frase")}</td>
                        
                            <td>${fieldValue(bean: fraseInstance, field: "articulo")}</td>
                        
                            <td>${fieldValue(bean: fraseInstance, field: "foto")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${fraseInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
