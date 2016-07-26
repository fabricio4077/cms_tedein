<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/25/11
  Time: 12:06 PM
  To change this template use File | Settings | File Templates.
--%>

<div class="todoMenu">
    <g:link class="boton" action="nuevoTipo" target="contenido">
        Crear nuevo
    </g:link>

    <div class="menu ui-corner-all" style="height: 350px; overflow: auto; width:160px;">
        <ul style="min-height: 315px; list-style: none; margin:0; padding:0;">
            <g:each in="${tipos}" var="tipo">
                <li style="width: 138px; min-height: 30px;" id="btn_tipo_${tipo.id}">
                    <div style="margin-top:5px; min-height:30px;">
                        <a href="${createLink(controller: 'editor', action: 'editarPagina', params: ['id': tipo.pagina.id, 'add': false])}"
                           class="boton"
                           target="contenido">
                            ${tipo.nombre}
                        </a>
                    </div>
                </li>
            </g:each>
        </ul>
    </div>
</div>

<script type="text/javascript">

    $(function() {
        $(".boton").button();
    });
</script>