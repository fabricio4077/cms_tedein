<table border="1">
    <thead>
        <tr>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>E-mail</th>
            <th>Celular</th>
            <th>Teléfono</th>
            <th>Comentario</th>
            <th>Contactado</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${personas}" var="persona">
            <tr>
                <td>${persona.nombre}</td>
                <td>${persona.apellido}</td>
                <td>${persona.email}</td>
                <td>${persona.celular}</td>
                <td>${persona.telefono}</td>
                <td>${persona.comentario}</td>
                <td>
                    <g:if test="${persona.contactado == 1}">
                        <a href="#" title="Cambiar a NO" data-id="${persona.id}" class="si"></a>
                    </g:if>
                    <g:else>
                        <a href="#" title="Cambiar a SI" data-id="${persona.id}" class="no"></a>
                    </g:else>
                </td>
            </tr>
        </g:each>
    </tbody>
</table>

<script type="text/javascript">
    function cambiarEstado(id, activar) {
        $.ajax({
            type    : "POST",
            url     : "${createLink( action:'cambiarEstado')}",
            data    : {
                id     : id,
                estado : activar ? '1' : '0'
            },
            success : function (msg) {
                reloadTabla();
            }
        });
    }
    $(function () {
        $(".si").button({
            icons : {
                primary : "ui-icon-check"
            }
        }).click(function () {
            cambiarEstado($(this).attr("data-id"), false);
        });
        $(".no").button({
            icons : {
                primary : "ui-icon-closethick"
            }
        }).click(function () {
            cambiarEstado($(this).attr("data-id"), true);
        });
    });
</script>