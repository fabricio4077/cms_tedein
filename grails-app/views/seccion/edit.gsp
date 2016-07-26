

<%@ page import="nth.Seccion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'seccion.label', default: 'Seccion')}" />
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
            <g:hasErrors bean="${seccionInstance}">
            <div class="errors">
                <g:renderErrors bean="${seccionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${seccionInstance?.id}" />
                <g:hiddenField name="version" value="${seccionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="pagina"><g:message code="seccion.pagina.label" default="Pagina" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'pagina', 'errors')}">
                                    <g:select name="pagina.id" from="${nth.Pagina.list()}" optionKey="id" value="${seccionInstance?.pagina?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nombre"><g:message code="seccion.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" maxlength="30" value="${seccionInstance?.nombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="css"><g:message code="seccion.css.label" default="Css" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'css', 'errors')}">
                                    <g:textArea name="css" cols="40" rows="5" value="${seccionInstance?.css}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="top"><g:message code="seccion.top.label" default="Top" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'top', 'errors')}">
                                    <g:textField name="top" value="${fieldValue(bean: seccionInstance, field: 'top')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="izq"><g:message code="seccion.izq.label" default="Izq" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'izq', 'errors')}">
                                    <g:textField name="izq" value="${fieldValue(bean: seccionInstance, field: 'izq')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="width"><g:message code="seccion.width.label" default="Width" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'width', 'errors')}">
                                    <g:textField name="width" value="${fieldValue(bean: seccionInstance, field: 'width')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="height"><g:message code="seccion.height.label" default="Height" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'height', 'errors')}">
                                    <g:textField name="height" value="${fieldValue(bean: seccionInstance, field: 'height')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipo"><g:message code="seccion.tipo.label" default="Tipo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'tipo', 'errors')}">
                                    <g:select name="tipo" from="${seccionInstance.constraints.tipo.inList}" value="${seccionInstance?.tipo}" valueMessagePrefix="seccion.tipo"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="foto"><g:message code="seccion.foto.label" default="Foto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'foto', 'errors')}">
                                    <g:select name="foto.id" from="${nth.Foto.list()}" optionKey="id" value="${seccionInstance?.foto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="video"><g:message code="seccion.video.label" default="Video" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'video', 'errors')}">
                                    <g:select name="video.id" from="${nth.Video.list()}" optionKey="id" value="${seccionInstance?.video?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="galeria"><g:message code="seccion.galeria.label" default="Galeria" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'galeria', 'errors')}">
                                    <g:select name="galeria.id" from="${nth.Galeria.list()}" optionKey="id" value="${seccionInstance?.galeria?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contenido"><g:message code="seccion.contenido.label" default="Contenido" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'contenido', 'errors')}">
                                    <g:select name="contenido.id" from="${nth.Pagina.list()}" optionKey="id" value="${seccionInstance?.contenido?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cantidad"><g:message code="seccion.cantidad.label" default="Cantidad" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'cantidad', 'errors')}">
                                    <g:textField name="cantidad" value="${fieldValue(bean: seccionInstance, field: 'cantidad')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="frases"><g:message code="seccion.frases.label" default="Frases" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: seccionInstance, field: 'frases', 'errors')}">
                                    
<ul>
<g:each in="${seccionInstance?.frases?}" var="f">
    <li><g:link controller="frase" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="frase" action="create" params="['seccion.id': seccionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'frase.label', default: 'Frase')])}</g:link>

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
