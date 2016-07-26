

<%@ page import="nth.Layout" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'layout.label', default: 'Layout')}" />
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
            <g:hasErrors bean="${layoutInstance}">
            <div class="errors">
                <g:renderErrors bean="${layoutInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contenido"><g:message code="layout.contenido.label" default="Contenido" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'contenido', 'errors')}">
                                    <g:select name="contenido.id" from="${nth.Seccion.list()}" optionKey="id" value="${layoutInstance?.contenido?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="menu"><g:message code="layout.menu.label" default="Menu" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'menu', 'errors')}">
                                    <g:select name="menu.id" from="${nth.Seccion.list()}" optionKey="id" value="${layoutInstance?.menu?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="banner"><g:message code="layout.banner.label" default="Banner" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'banner', 'errors')}">
                                    <g:select name="banner.id" from="${nth.Seccion.list()}" optionKey="id" value="${layoutInstance?.banner?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idioma"><g:message code="layout.idioma.label" default="Idioma" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'idioma', 'errors')}">
                                    <g:select name="idioma.id" from="${nth.Seccion.list()}" optionKey="id" value="${layoutInstance?.idioma?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="layout.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" value="${layoutInstance?.nombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descripcion"><g:message code="layout.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'descripcion', 'errors')}">
                                    <g:textField name="descripcion" maxlength="30" value="${layoutInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="css"><g:message code="layout.css.label" default="Css" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'css', 'errors')}">
                                    <g:textArea name="css" cols="40" rows="5" value="${layoutInstance?.css}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sitio"><g:message code="layout.sitio.label" default="Sitio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: layoutInstance, field: 'sitio', 'errors')}">
                                    <g:select name="sitio.id" from="${nth.Sitio.list()}" optionKey="id" value="${layoutInstance?.sitio?.id}"  />
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
