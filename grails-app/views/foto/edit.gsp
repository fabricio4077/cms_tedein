

<%@ page import="nth.Foto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'foto.label', default: 'Foto')}" />
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
            <g:hasErrors bean="${fotoInstance}">
            <div class="errors">
                <g:renderErrors bean="${fotoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${fotoInstance?.id}" />
                <g:hiddenField name="version" value="${fotoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="path"><g:message code="foto.path.label" default="Path" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fotoInstance, field: 'path', 'errors')}">
                                    <g:textField name="path" value="${fotoInstance?.path}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="frases"><g:message code="foto.frases.label" default="Frases" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fotoInstance, field: 'frases', 'errors')}">
                                    
<ul>
<g:each in="${fotoInstance?.frases?}" var="f">
    <li><g:link controller="frase" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="frase" action="create" params="['foto.id': fotoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'frase.label', default: 'Frase')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="galeria"><g:message code="foto.galeria.label" default="Galeria" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fotoInstance, field: 'galeria', 'errors')}">
                                    <g:select name="galeria.id" from="${nth.Galeria.list()}" optionKey="id" value="${fotoInstance?.galeria?.id}"  />
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
