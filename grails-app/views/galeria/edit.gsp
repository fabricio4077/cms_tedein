

<%@ page import="nth.Galeria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'galeria.label', default: 'Galeria')}" />
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
            <g:hasErrors bean="${galeriaInstance}">
            <div class="errors">
                <g:renderErrors bean="${galeriaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${galeriaInstance?.id}" />
                <g:hiddenField name="version" value="${galeriaInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nombre"><g:message code="galeria.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: galeriaInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" maxlength="20" value="${galeriaInstance?.nombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipo"><g:message code="galeria.tipo.label" default="Tipo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: galeriaInstance, field: 'tipo', 'errors')}">
                                    <g:select name="tipo" from="${galeriaInstance.constraints.tipo.inList}" value="${galeriaInstance?.tipo}" valueMessagePrefix="galeria.tipo"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fotos"><g:message code="galeria.fotos.label" default="Fotos" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: galeriaInstance, field: 'fotos', 'errors')}">
                                    
<ul>
<g:each in="${galeriaInstance?.fotos?}" var="f">
    <li><g:link controller="foto" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="foto" action="create" params="['galeria.id': galeriaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'foto.label', default: 'Foto')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="frases"><g:message code="galeria.frases.label" default="Frases" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: galeriaInstance, field: 'frases', 'errors')}">
                                    
<ul>
<g:each in="${galeriaInstance?.frases?}" var="f">
    <li><g:link controller="frase" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="frase" action="create" params="['galeria.id': galeriaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'frase.label', default: 'Frase')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="videos"><g:message code="galeria.videos.label" default="Videos" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: galeriaInstance, field: 'videos', 'errors')}">
                                    
<ul>
<g:each in="${galeriaInstance?.videos?}" var="v">
    <li><g:link controller="video" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="video" action="create" params="['galeria.id': galeriaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'video.label', default: 'Video')])}</g:link>

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
