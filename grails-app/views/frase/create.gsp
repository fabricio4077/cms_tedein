

<%@ page import="nth.Frase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'frase.label', default: 'Frase')}" />
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
            <g:hasErrors bean="${fraseInstance}">
            <div class="errors">
                <g:renderErrors bean="${fraseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idioma"><g:message code="frase.idioma.label" default="Idioma" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'idioma', 'errors')}">
                                    <g:select name="idioma.id" from="${nth.Idioma.list()}" optionKey="id" value="${fraseInstance?.idioma?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estado"><g:message code="frase.estado.label" default="Estado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'estado', 'errors')}">
                                    <g:select name="estado" from="${fraseInstance.constraints.estado.inList}" value="${fraseInstance?.estado}" valueMessagePrefix="frase.estado"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="frase"><g:message code="frase.frase.label" default="Frase" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'frase', 'errors')}">
                                    <g:textField name="frase" value="${fraseInstance?.frase}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="articulo"><g:message code="frase.articulo.label" default="Articulo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'articulo', 'errors')}">
                                    <g:select name="articulo.id" from="${nth.Articulo.list()}" optionKey="id" value="${fraseInstance?.articulo?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="foto"><g:message code="frase.foto.label" default="Foto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'foto', 'errors')}">
                                    <g:select name="foto.id" from="${nth.Foto.list()}" optionKey="id" value="${fraseInstance?.foto?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="galeria"><g:message code="frase.galeria.label" default="Galeria" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'galeria', 'errors')}">
                                    <g:select name="galeria.id" from="${nth.Galeria.list()}" optionKey="id" value="${fraseInstance?.galeria?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="seccion"><g:message code="frase.seccion.label" default="Seccion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'seccion', 'errors')}">
                                    <g:select name="seccion.id" from="${nth.Seccion.list()}" optionKey="id" value="${fraseInstance?.seccion?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="video"><g:message code="frase.video.label" default="Video" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fraseInstance, field: 'video', 'errors')}">
                                    <g:select name="video.id" from="${nth.Video.list()}" optionKey="id" value="${fraseInstance?.video?.id}"  />
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
