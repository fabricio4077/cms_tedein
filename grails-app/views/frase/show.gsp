
<%@ page import="nth.Frase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'frase.label', default: 'Frase')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fraseInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.idioma.label" default="Idioma" /></td>
                            
                            <td valign="top" class="value"><g:link controller="idioma" action="show" id="${fraseInstance?.idioma?.id}">${fraseInstance?.idioma?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.estado.label" default="Estado" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fraseInstance, field: "estado")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.frase.label" default="Frase" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fraseInstance, field: "frase")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.articulo.label" default="Articulo" /></td>
                            
                            <td valign="top" class="value"><g:link controller="articulo" action="show" id="${fraseInstance?.articulo?.id}">${fraseInstance?.articulo?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.foto.label" default="Foto" /></td>
                            
                            <td valign="top" class="value"><g:link controller="foto" action="show" id="${fraseInstance?.foto?.id}">${fraseInstance?.foto?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.galeria.label" default="Galeria" /></td>
                            
                            <td valign="top" class="value"><g:link controller="galeria" action="show" id="${fraseInstance?.galeria?.id}">${fraseInstance?.galeria?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.seccion.label" default="Seccion" /></td>
                            
                            <td valign="top" class="value"><g:link controller="seccion" action="show" id="${fraseInstance?.seccion?.id}">${fraseInstance?.seccion?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="frase.video.label" default="Video" /></td>
                            
                            <td valign="top" class="value"><g:link controller="video" action="show" id="${fraseInstance?.video?.id}">${fraseInstance?.video?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${fraseInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
