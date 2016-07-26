<table style="width:250px;">
    <thead>
    <th style="border:1px black solid;" class="ui-state-active">Propiedad</th>
    <th style="border:1px black solid" class="ui-state-active">Valor</th>
    </thead>
    <tbody>
    <g:set var="grupo" value=""></g:set>
    <g:each in="${props}" var="prop" status="i">
        <g:if test="${prop.grupo!=grupo}">
            <tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">
                <td>${prop.grupo}</td>
                <g:set var="grupo" value="${prop.grupo}"></g:set>
            </tr>
        </g:if>
        <tr title="${prop.explicacion}">
            <td style="border:1px black solid;padding-left:5px;" class="ui-state-active">
                ${prop.mostrar}
            </td>
            <td style="border:1px black solid;">
                %{--<input type="textfield" id="V${prop.nombre}" nombre="${prop.nombre}" sufijo="${prop.sufijo}" size="8" class="propiedad" style="background: orange;">--}%
                <elm:item propiedad="${prop}" id="V${prop.nombre}" nombre="${prop.nombre}" sufijo="${(prop.sufijo)?prop.sufijo:''}" class="propiedad"/>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>