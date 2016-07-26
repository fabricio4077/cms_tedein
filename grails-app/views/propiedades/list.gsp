
<%@ page import="nth.Propiedades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'propiedades.label', default: 'Propiedades')}" />
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
                            <g:sortableColumn property="id" title="${message(code: 'propiedades.id.label', default: 'Id')}" />
                            <g:sortableColumn property="nombre" title="${message(code: 'propiedades.nombre.label', default: 'Nombre')}" />
                            <g:sortableColumn property="mostrar" title="${message(code: 'propiedades.mostrar.label', default: 'Mostrar')}" />
                            <g:sortableColumn property="tipo" title="${message(code: 'propiedades.tipo.label', default: 'Tipo')}" />
                            <g:sortableColumn property="grupo" title="${message(code: 'propiedades.grupo.label', default: 'Grupo')}" />
                            <g:sortableColumn property="orden" title="${message(code: 'propiedades.orden.label', default: 'Orden')}" />
                            <g:sortableColumn property="explicacion" title="${message(code: 'propiedades.explicacion.label', default: 'Explicacion')}" />
                            <g:sortableColumn property="sufijo" title="${message(code: 'propiedades.sufijo.label', default: 'Sufijo')}" />
                            <g:sortableColumn property="contenido" title="${message(code: 'propiedades.contenido.label', default: 'Contenido')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${propiedadesInstanceList}" status="i" var="propiedadesInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${propiedadesInstance.id}">${fieldValue(bean: propiedadesInstance, field: "id")}</g:link></td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "nombre")}</td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "mostrar")}</td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "tipo")}</td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "grupo")}</td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "orden")}</td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "explicacion")}</td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "sufijo")}</td>
                            <td>${fieldValue(bean: propiedadesInstance, field: "contenido")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${propiedadesInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
