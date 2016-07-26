<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Nth</title>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.4.2.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.5.custom.min.js')}"></script>
        <link href="${resource(dir: 'js/jquery/css/dark-hive', file: 'jquery-ui-1.8.5.custom.css')}" rel="stylesheet" type="text/css"/>
        <style type="text/css">
        .principal {
            width  : 600px;
            height : 500px;
            margin : 30px;
            border : 1px solid #6E8EA6;

        }

        .sitios {
            width        : 230px;
            margin       : 10px;
            height       : 480px;
            overflow-y   : auto;
            float        : left;
            border-right : 1px solid #6E8EA6;
        }

        .form {
            float  : left;
            width  : 320px;
            margin : 10px;
            height : 480px;

        }

        .sitio {
            width       : 185px;
            padding     : 10px;
            height      : 60px;
            /*background: #6E8EA6;*/
            background  : #F4DA6C;
            border      : 1px solid #ccc;
            margin-top  : 5px;
            font-family : fantasy;
            font-size   : 12px;
            font-style  : italic;
            cursor      : pointer;
        }

        .titulo {
            width       : 90%;
            padding     : 5px;
            height      : 30px;
            background  : #eee;
            border      : 1px solid #ccc;
            margin      : auto;
            margin-top  : 5px;
            font-family : fantasy;
            font-size   : 16px;
            font-style  : italic;
            line-height : 30px;
            text-align  : center;
            font-weight : bold;
        }
        </style>
    </head>

    <body>

        <div class="principal ui-corner-all">
            <div class="sitios ">
                <g:each in="${sitios}" var="site">
                    <div class="sitio ui-corner-all" id="${site.id + 328}">
                        <b>${site.nombre}<br></b>
                        ${site.organizacion}<br>
                        ${site.contacto + " - " + site.telefono}
                        ${"Principal:&nbsp;&nbsp;" + ((site.principal == 1) ? "<b>Si</b>" : "<b>No</b>")}
                    </div>
                </g:each>
            </div>

            <div class="form ui-corner-all ">
                <div class="titulo ui-corner-all">
                    Crear un nuevo sitio
                </div>

                <div style="width: 95%;margin: auto;margin-top: 20px;font-size: 11px !important;">
                    <g:form action="saveSitio">
                        <table style="font-size: 12px !important;font-family: fantasy;font-weight: bold;color: #6E8EA6;">
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
                                                                             default="Organización&nbsp;&nbsp;"/></label>
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
                                                                         default="Teléfono"/></label>
                                    </td>
                                    <td valign="top"
                                        class="value ${hasErrors(bean: sitioInstance, field: 'telefono', 'errors')}">
                                        <g:textField name="telefono" maxlength="10" value="${sitioInstance?.telefono}"/>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="telefono">Principal</label>
                                    </td>
                                    <td valign="top">
                                        <g:if test="${nth.Sitio.findByPrincipal(1)}">
                                            <input type="hidden" name="principal" value="0">
                                            No
                                        </g:if>
                                        <g:else>
                                            <g:select from="${prc}" name="principal" optionKey="key" optionValue="value"/>
                                        </g:else>
                                    </td>
                                </tr>

                            </tbody>
                        </table>


                        <div class="buttons" style="margin-top: 15px">
                            <span class="button"><g:submitButton name="create" class="save" value="Guardar"/></span>
                        </div>
                    </g:form>

                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(".save").button()
            $(".sitio").click(function () {
                $.ajax({
                    type:"POST",
                    url:"${createLink(action:'setSitio')}",
                    data:{
                        sitio:$(this).attr("id") * 1 - 328
                    },
                    success:function (msg) {
                        if (msg == "ok") {
                            location.href = "${createLink(action:'index')}"
                        }
                    }
                });
            });
        </script>
    </body>
</html>