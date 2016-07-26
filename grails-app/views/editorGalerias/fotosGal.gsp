<%@ page import="nth.Foto" %>
<style type="text/css">
.item {
    float: left;
    margin-right: 15px;
    margin-top: 10px;
    height: 160px;
    position: relative;
    width: 150px;
}

.desc {
    padding: 5px;
}
</style>

<g:each in="${fotos}" var="foto">
    <div class="item ui-widget-content ui-corner-all" id="${foto.obj.id}">

        <elm:barrita title="Foto" bordes="ui-corner-top" botones="${['eliminar', 'editar']}" float="right" id="${foto.obj.id}" param="galeria='${gal.id}'"/>

        <ig:img class="ui-corner-all"
                src="${createLink(action:'showImage', controller: 'image', id:foto.obj.id)}"
                alt="${foto.descripcion}"
                title="${foto.descripcion}"
                linkTitle="${foto.descripcion}"
                thumbnailSrc="${createLink(action:'showImage', controller: 'image', id:foto.obj.id, params:[thumbnail:true])}"

                id="${foto.obj.id}"
                titulo="${foto.titulo}"
                descripcion="${foto.descripcion}"/>

        <div class="desc">
            ${foto.descripcion}
        </div>
    </div>
</g:each>


<div title="Confirmaci&oacute;n" id="confirm">
    <div class="ui-widget">
        <div style="padding: 0 .7em; color:black;">
            <p>
                <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                <span style="font-weight: bold;">Alerta</span>
            </p>

            <p>
                Est&aacute; seguro de querer eliminar la foto?
            </p>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function() {

        var delClicked;
        var edtClicked;
        var delGalClicked;

        /***********barrita***********/
        $(".item").hoverIntent({
            timeout: 500, // number = milliseconds delay before onMouseOut
            over: function() {
                $("#barra_" + $(this).attr("id")).show();
            },
            out: function() {
                $("#barra_" + $(this).attr("id")).hide("explode");
            }
        });
        /**
         * TODO: revisar esto!!!!
         */
        $(".delete").click(function() {
            delClicked = $(this).parent().attr("id");
            delGalClicked = $(this).parent().attr("galeria");
            $("#confirm").dialog("open");
        });
        $(".contenido").click(function() {
            edtClicked = $(this);

            var elem = edtClicked.parent().attr("id");
            var parts = elem.split("_");
            var foto = parts[1];

            var url = "${createLink(controller:'image', action:'addToGal', params:["id":gal.id,"idioma":6,"tipo":"gal"])}&foto=" + foto;

            var child = window.open(url, 'NTH', 'left=0,top=0,width=850,height=600,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
            if (child.opener == null) child.opener = self;
            window.toolbar.visible = false;
            window.menubar.visible = false;
            return false;
        });
        /***********barrita***********/

        $("#confirm").dialog({
            autoOpen: false,
            modal: true,
            closeOnEscape: false,
            width:320,
            resizable: false,
            draggable: false,
            dialogClass: 'ui-state-error',
            open: function(event, ui) {
                $(".ui-dialog-titlebar-close").remove();
                $(".ui-dialog-buttonpane").addClass("ui-state-error");
            },
            buttons: {
                "Cancelar": function() {
                    $(this).dialog("close");
                },
                "Aceptar": function() {
                    deleteFoto();
                    $(this).dialog("close");
                }
            }
        });

        function deleteFoto() {
//            var galeria = delClicked.parent().attr("galeria");
//            var elem = delClicked.parent().attr("id");
//            var parts = elem.split("_");
            var parts = delClicked.split("_");
            var foto = parts[1];

//            console.log(galeria + "   " + foto);

            $.ajax({
                type: "POST",
                url: "${createLink(action:'deleteFoto')}",
                data: {
                    gal: delGalClicked,
                    fot: foto
                },
                success: function(msg) {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'fotosGal')}",
                        data: {
                            id: '${gal.id}'
                        },
                        success: function(msg) {
                            $("#fotosGal").html(msg);

                            window.location.reload();
                        }
                    });
                }
            });
        }

        /***********prettyPhoto***********/
        $.fn.prettyPhoto();
        $(".linkFotoLight").click(function() {
            $.prettyPhoto.open($(this).attr("src"), "preview", $(this).attr("title"));
        });
        /***********prettyPhoto***********/
    });
</script>