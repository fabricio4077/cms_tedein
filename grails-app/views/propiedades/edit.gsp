<%@ page import="nth.Propiedades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'propiedades.label', default: 'Propiedades')}" />
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
            <g:hasErrors bean="${propiedadesInstance}">
                <div class="errors">
                    <g:renderErrors bean="${propiedadesInstance}" as="list" />
                </div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${propiedadesInstance?.id}" />
                <g:hiddenField name="version" value="${propiedadesInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="propiedades.nombre.label"
                                                                   default="Nombre" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" maxlength="30" value="${propiedadesInstance?.nombre}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mostrar"><g:message code="propiedades.mostrar.label"
                                                                    default="Mostrar" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'mostrar', 'errors')}">
                                    <g:textField name="mostrar" maxlength="30"
                                                 value="${propiedadesInstance?.mostrar}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tipo"><g:message code="propiedades.tipo.label" default="Tipo" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'tipo', 'errors')}">
                                    %{--<g:select name="tipo" from="${propiedadesInstance.constraints.tipo.inList}" value="${propiedadesInstance?.tipo}" valueMessagePrefix="propiedades.tipo"/>--}%
                                    <g:textField name="tipo" maxlength="30" value="${propiedadesInstance?.tipo}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="grupo"><g:message code="propiedades.grupo.label"
                                                                 default="Grupo" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'grupo', 'errors')}">
                                    <g:textField name="grupo" maxlength="30" value="${propiedadesInstance?.grupo}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="orden"><g:message code="propiedades.orden.label"
                                                                  default="Orden" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'orden', 'errors')}">
                                    <g:textField name="orden" maxlength="30" value="${propiedadesInstance?.orden}" />
                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="explicacion"><g:message code="propiedades.explicacion.label"
                                                                        default="Explicacion" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'explicacion', 'errors')}">
                                    <g:textArea name="explicacion" cols="40" rows="5"
                                                value="${propiedadesInstance?.explicacion}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sufijo"><g:message code="propiedades.sufijo.label"
                                                                   default="Sufijo" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'sufijo', 'errors')}">
                                    <g:textField name="sufijo" maxlength="5" value="${propiedadesInstance?.sufijo}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contenido"><g:message code="propiedades.contenido.label"
                                                                      default="Contenido" /></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: propiedadesInstance, field: 'contenido', 'errors')}">
                                    <g:textArea cols="40" rows="5" name="contenido"
                                                value="${propiedadesInstance?.contenido}" />
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
