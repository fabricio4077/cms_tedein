<%@ page import="nth.Propiedades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'propiedades.label', default: 'Propiedades')}"/>
        <title><g:message code="default.show.label" args="[entityName]"/></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.id.label" default="Id"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "id")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.nombre.label" default="Nombre"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "nombre")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.mostrar.label" default="Mostrar"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "mostrar")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.tipo.label" default="Tipo"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "tipo")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.grupo.label" default="Grupo"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "grupo")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.orden.label" default="Orden"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "orden")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.explicacion.label" default="Explicacion"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "explicacion")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.sufijo.label" default="Sufijo"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "sufijo")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="propiedades.contenido.label" default="Contenido"/></td>

                            <td valign="top" class="value">${fieldValue(bean: propiedadesInstance, field: "contenido")}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${propiedadesInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>

                    <span class="button"><g:link action="show" id="${(propiedadesInstance?.id)-1}">Prev</g:link></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <span class="button"><g:link action="show" id="${(propiedadesInstance?.id)+1}">Next</g:link></span>

                </g:form>
            </div>
        </div>
    </body>
</html>
