<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:imports/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/lightbox/css', file: 'prettyPhoto.css')}"
          type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8"/>
    <script src="${resource(dir: 'js/jquery/plugins/lightbox/js', file: 'jquery.prettyPhoto.js')}"
            type="text/javascript" charset="utf-8"></script>
    <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hoverIntent.minified.js')}" type="text/javascript"
            charset="utf-8"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jCarouselLite.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.ba-throttle-debounce.js')}" type="text/javascript"
            charset="utf-8"></script>

    <meta name="layout" content="frame"/>

    <style type="text/css" media="screen">
    * {
        margin  : 0;
        padding : 0;
    }

    body {

        padding : 0 20px;
        font-size: 12px !important;
    }

    ul li {
        display : inline;
    }

    .wide {
        border-bottom : 1px #000 solid;
        width         : 4000px;
    }

    .selected {
        border     : solid 1px #9932cc;
        background : #d8bfd8;
    }

    </style>
    <title>NTH: Idiomas</title>
</head>

<body>

%{--<ul id="ulMenu" class="topnav ui-corner-all"--}%
    %{--style="position:absolute; top:2px;z-index:9999;font    : 14px Arial, Verdana, Sans-Serif;">--}%
    %{--<li><a href="#" id="guardar">Guardar</a></li>--}%
%{--</ul>--}%

<div id="cuerpo" style="font-size: 11px !important;">
    <g:form action="save" enctype="multipart/form-data" class="frmUploader">
        <input id="idioma_id" type="hidden" value="${idioma?.id}" name="id">
        %{--<input type="hidden" value="${idioma?.imagen}" name="imagen">--}%
        <div class="dialog">
            <div style="width:450px;/*height:400px;*/margin-top:15px;">
                <div class="fila" style="margin-bottom:10px;">
                    <div class="smallLabel" style="text-align:right">Nombre:</div>
                    <div class="valor" style="text-align:left;float:left">
                        <g:textField name="nombre" class="required" value="${idioma?.nombre}" id="nombre"/>
                    </div>
                </div>
                <div class="fila" style="margin-bottom:10px;">
                    <div class="smallLabel" style="text-align:right">Abreviación:</div>
                    <div class="valor" style="text-align:left;float:left">
                        <g:textField name="abreviacion" value="${idioma?.abreviacion}" id="abr"/>
                    </div>
                </div>

                <div class="fila" style="margin-bottom:10px;">
                    <div class="smallLabel" style="text-align:right">Imagen:</div>
                    <div class="valor" style="text-align:left;float:left">
                        <input type="file" id="imagen" name="imagen"/>
                    </div>
                </div>

                <g:if test="${idioma && idioma.imagen}">
                    <img class="imgIdioma" src="${g.createLink(controller: 'image', action: 'showImageIdioma', id: idioma.id)}" />
                </g:if>


            </div>
        </div>
    </g:form>
</div>
<script type="text/javascript">
    $("#cuerpo").dialog({
        autoOpen: true,
        resizable:false,
        modal:false,
        draggable:true,
        width:470,
        height:300,
        title:"Nuevo idioma",
        position: [15,40],
        buttons: {
            "Guardar": function() {
                if ($("#nombre").val()!="" && $("#nombre").val()!=" " && $("#abr").val()!="" && $("#abr").val()!=" ")  {
                    $(".frmUploader").submit();
                }
            }
        },
        open: function(event, ui) {
            $(".ui-dialog-titlebar-close").remove();
        }
    });
</script>
</body>
</html>
