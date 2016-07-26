<%@ page import="nth.Sitio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="config"/>
        <g:set var="entityName" value="${message(code: 'sitio.label', default: 'Sitio')}"/>
        <title><g:message code="default.create.label" args="[entityName]"/></title>
    </head>

    <body>

        <div class="body">
            <h1>Crear Sitio</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${sitioInstance}">
                <div class="errors">
                    <g:renderErrors bean="${sitioInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form action="save">
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="sitio.nombre.label" default="Nombre"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: sitioInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" maxlength="20" value="${sitioInstance?.nombre}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="organizacion"><g:message code="sitio.organizacion.label"
                                                                         default="Organizacion"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: sitioInstance, field: 'organizacion', 'errors')}">
                                    <g:textField name="organizacion" maxlength="60"
                                                 value="${sitioInstance?.organizacion}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contacto"><g:message code="sitio.contacto.label"
                                                                     default="Contacto"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: sitioInstance, field: 'contacto', 'errors')}">
                                    <g:textField name="contacto" maxlength="100" value="${sitioInstance?.contacto}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="telefono"><g:message code="sitio.telefono.label"
                                                                     default="Telefono"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: sitioInstance, field: 'telefono', 'errors')}">
                                    <g:textField name="telefono" maxlength="10" value="${sitioInstance?.telefono}"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save"
                                                         value="Guardar"/></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
