

<%@ page import="nth.Comentario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'comentario.label', default: 'Comentario')}" />
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
            <g:hasErrors bean="${comentarioInstance}">
            <div class="errors">
                <g:renderErrors bean="${comentarioInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="comentario.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: comentarioInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" maxlength="50" value="${comentarioInstance?.nombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mail"><g:message code="comentario.mail.label" default="Mail" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: comentarioInstance, field: 'mail', 'errors')}">
                                    <g:textField name="mail" maxlength="128" value="${comentarioInstance?.mail}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="url"><g:message code="comentario.url.label" default="Url" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: comentarioInstance, field: 'url', 'errors')}">
                                    <g:textField name="url" maxlength="128" value="${comentarioInstance?.url}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="texto"><g:message code="comentario.texto.label" default="Texto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: comentarioInstance, field: 'texto', 'errors')}">
                                    <g:textArea name="texto" cols="40" rows="5" value="${comentarioInstance?.texto}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="foto"><g:message code="comentario.foto.label" default="Foto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: comentarioInstance, field: 'foto', 'errors')}">
                                    <g:select name="foto.id" from="${nth.Foto.list()}" optionKey="id" value="${comentarioInstance?.foto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estado"><g:message code="comentario.estado.label" default="Estado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: comentarioInstance, field: 'estado', 'errors')}">
                                    <g:select name="estado" from="${comentarioInstance.constraints.estado.inList}" value="${comentarioInstance?.estado}" valueMessagePrefix="comentario.estado"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="seccion"><g:message code="comentario.seccion.label" default="Seccion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: comentarioInstance, field: 'seccion', 'errors')}">
                                    <g:select name="seccion.id" from="${nth.Seccion.list()}" optionKey="id" value="${comentarioInstance?.seccion?.id}"  />
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
