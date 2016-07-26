

<%@ page import="nth.Pagina" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pagina.label', default: 'Pagina')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${paginaInstance}">
            <div class="errors">
                <g:renderErrors bean="${paginaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${paginaInstance?.id}" />
                <g:hiddenField name="version" value="${paginaInstance?.version}" />
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
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="secciones"><g:message code="pagina.secciones.label" default="Secciones" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paginaInstance, field: 'secciones', 'errors')}">
                                    
<ul>
<g:each in="${paginaInstance?.secciones?}" var="s">
    <li><g:link controller="seccion" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="seccion" action="create" params="['pagina.id': paginaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'seccion.label', default: 'Seccion')])}</g:link>

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
