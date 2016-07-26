<%@ page import="nth.TipoPagina" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tipoPagina.label', default: 'TipoPagina')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>

    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message
                    code="default.home.label" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                                   args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                                       args="[entityName]" /></g:link></span>
        </div>

        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tipoPaginaInstance}">
                <div class="errors">
                    <g:renderErrors bean="${tipoPaginaInstance}" as="list" />
                </div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${tipoPaginaInstance?.id}" />
                <g:hiddenField name="version" value="${tipoPaginaInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="tipoPagina.nombre.label"
                                                                   default="Nombre" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: tipoPaginaInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" maxlength="20" value="${tipoPaginaInstance?.nombre}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descripcion"><g:message code="tipoPagina.descripcion.label"
                                                                        default="Descripcion" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: tipoPaginaInstance, field: 'descripcion', 'errors')}">
                                    <g:textField name="descripcion" value="${tipoPaginaInstance?.descripcion}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sitio"><g:message code="tipoPagina.sitio.label"
                                                                  default="Sitio" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: tipoPaginaInstance, field: 'sitio', 'errors')}">
                                    <g:select name="sitio.id" from="${nth.Sitio.list()}" optionKey="id"
                                              value="${tipoPaginaInstance?.sitio?.id}" />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update"
                                                         value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete"
                                                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
