

<%@ page import="nth.Pagina" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pagina.label', default: 'Pagina')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${paginaInstance}">
            <div class="errors">
                <g:renderErrors bean="${paginaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="pagina.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paginaInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" maxlength="20" value="${paginaInstance?.nombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="menu"><g:message code="pagina.menu.label" default="Menu" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paginaInstance, field: 'menu', 'errors')}">
                                    <g:textField name="menu" maxlength="10" value="${paginaInstance?.menu}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="layout"><g:message code="pagina.layout.label" default="Layout" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paginaInstance, field: 'layout', 'errors')}">
                                    <g:select name="layout.id" from="${nth.Layout.list()}" optionKey="id" value="${paginaInstance?.layout?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
