
<%@ page import="nth.Seccion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'seccion.label', default: 'Seccion')}" />
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
                            <td valign="top" class="name"><g:message code="seccion.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.pagina.label" default="Pagina" /></td>
                            
                            <td valign="top" class="value"><g:link controller="pagina" action="show" id="${seccionInstance?.pagina?.id}">${seccionInstance?.pagina?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.nombre.label" default="Nombre" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "nombre")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.css.label" default="Css" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "css")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.top.label" default="Top" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "top")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.izq.label" default="Izq" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "izq")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.width.label" default="Width" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "width")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.height.label" default="Height" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "height")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.tipo.label" default="Tipo" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "tipo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.foto.label" default="Foto" /></td>
                            
                            <td valign="top" class="value"><g:link controller="foto" action="show" id="${seccionInstance?.foto?.id}">${seccionInstance?.foto?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.video.label" default="Video" /></td>
                            
                            <td valign="top" class="value"><g:link controller="video" action="show" id="${seccionInstance?.video?.id}">${seccionInstance?.video?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.galeria.label" default="Galeria" /></td>
                            
                            <td valign="top" class="value"><g:link controller="galeria" action="show" id="${seccionInstance?.galeria?.id}">${seccionInstance?.galeria?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.contenido.label" default="Contenido" /></td>
                            
                            <td valign="top" class="value"><g:link controller="pagina" action="show" id="${seccionInstance?.contenido?.id}">${seccionInstance?.contenido?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.cantidad.label" default="Cantidad" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: seccionInstance, field: "cantidad")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="seccion.frases.label" default="Frases" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${seccionInstance.frases}" var="f">
                                    <li><g:link controller="frase" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${seccionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
