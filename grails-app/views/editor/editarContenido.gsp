<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="frame"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.pack.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins', file: 'jquery.ui.autocomplete.custom.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>
        <style type="text/css" media="screen">
        * {
            margin  : 0;
            padding : 0;
        }

        body {
            font    : 10px Arial, Verdana, Sans-Serif;
            padding : 0 20px;

        }

        h4 {
            margin : 15px 0 5px 0;
        }

        h4, p {
            font-size : 1.2em;
        }

        ul li {
            display : inline;
        }

        .wide {
            border-bottom : 1px #000 solid;
            width         : 4000px;
        }

        .editable {
            border : 1px solid #d2691e;
        }

            /******************************** para el dragNdrop ***********************************/
        #gallery {
            float      : left;
            width      : 65%;
            min-height : 12em;
        }

        * html #gallery {
            height : 12em;
        }

            /* IE6 */
        .gallery.custom-state-active {
            background : #eee;
        }

        .gallery li {
            float      : left;
            width      : 96px;
            padding    : 0.4em;
            margin     : 0 0.4em 0.4em 0;
            text-align : center;
        }

        .gallery li h5 {
            margin : 0 0 0.4em;
            cursor : move;
        }

        .gallery li a {
            float : right;
        }

        .gallery li a.ui-icon-zoomin {
            float : left;
        }

        .gallery li img {
            width  : 100%;
            cursor : move;
        }

        #basket {
            float      : right;
            width      : 32%;
            min-height : 18em;
            padding    : 1%;
        }

        * html #basket {
            height : 18em;
        }

            /* IE6 */
        #basket h4 {
            line-height : 16px;
            margin      : 0 0 0.4em;
        }

        .ui-icon {
            float  : left;
            cursor : pointer;
        }

        #basket .gallery h5 {
            display : none;
        }

        .titulo {
            font-size     : 14px;
            font-weight   : bold;
            margin-bottom : 10px;
        }

        .lista {
            border     : solid 1px gray;
            min-height : 100px;
            padding    : 3px;
        }

        .lista li {
            display        : inline-block;
            vertical-align : top;

            background     : rgba(150, 150, 150, 0.5);
            padding        : 3px;
            margin         : 0 2px 2px 0;
            border         : rgb(150, 150, 150) solid 1px;
        }

        .highlight {
            min-height : 150px;
            min-width  : 150px;
            background : rgba(205, 252, 171, 1);
        }
        </style>
        <title>NTH</title>
    </head>

    <body>
        <g:set var="hmax" value="${100}"/>
        <g:set var="wmax" value="${100}"/>
        <div style="height: 400px;overflow-y:auto;float:left" id="dialog_disp">
            <ul id="ul_disponibles" class="lista" style="overflow-y:auto;height:380px;">
                <g:each in="${disponibles}" var="pagina" status="i">
                    <li id="pag_${pagina.id}">
                        <div pag="${pagina.id}" class="disponible ui-corner-all">
                            <ig:img class="ui-corner-all"
                                    src="${createLink(action: 'showImage', controller: 'image', id: pagina.foto?.id)}"
                                    alt="${pagina.nombre}"
                                    title="${pagina.nombre}"
                                    linkTitle="${pagina.nombre}"
                                    thumbnailSrc="${createLink(action: 'showImage', controller: 'image', id: pagina.foto?.id, params: [thumbnail: true])}"
                                    id="${pagina.foto?.id}"/>
                            ${pagina.nombre}
                            %{--    <span class="ui-icon ui-icon-circle-zoomin preview" style="float:right;" title="Previsualizar"  pag="${pagina.id}" w="${pagina.layout.contenido.width}" h="${pagina.layout.contenido.height}">Previsualizar</span> --}%
                            <span class="ui-icon ui-icon-circle-plus select" style="float:right;" title="Seleccionar" pag="${pagina.id}">Seleccionar</span>
                        </div>
                        <g:if test="${pagina?.foto?.width > wmax}">
                            <g:set var="wmax" value="${(pagina?.foto?.width)}"/>
                        </g:if>
                        <g:if test="${pagina?.foto?.height > hmax}">
                            <g:set var="hmax" value="${pagina?.foto?.height}"/>
                        </g:if>
                    </li>
                </g:each>
            </ul>
        </div>
        <g:set var="hmax" value="${hmax + 20}"/>
        <script type="text/javascript">
            /* TODO  hacer la verificacion del # de caracteres en el textfield de tags........... hacer todas las validaciones con js */

            jQuery(function ($) {

                $(".disponible").width(${wmax}).height(${hmax});

                $("#dialog_disp").dialog({
                    title:"Páginas disponibles",
                    width:800,
                    closeOnEscape:false,
                    resizable:false,
                    modal:false,
                    draggable:true,
                    position:"top",
                    open:function (event, ui) {
                        $(".ui-dialog-titlebar-close").remove();
                    }
                });
                /**********************************Funciones**********************************/

                $(".select").click(function () {
                    var pagina = $(this).attr("pag")
                    console.log("pagina "+pagina)
                    console.log("session ${seccion.id}")
                    $.ajax({
                        type:"POST",
                        url:"${createLink(controller:"editor",action:"guardarContenido")}",
                        data:"seccion=" + ${seccion.id} + "&pagina=" + pagina,
                        success:function (msg) {
                            if (msg == "ok") {
                                $.ajax({
                                    type:"POST",
                                    url:"${createLink(controller:"paginaWeb",action:"showContenido")}" + "/" + pagina,
                                    success:function (msg) {
//                                        $("#bannerContenido", window.opener.document).html(msg);
                                        var nombre = "${seccion.id}";
                                        //alert(nombre)
                                        //window.opener.document.getElementById($("#seccion").val()).innerHTML=""+$("#editor1").val();
                                        var elem = $(window.opener.document.getElementById(nombre));
                                        elem.html(" ");
                                        elem.html(msg);
                                        window.close();
                                    }
                                });
                            }
                        }
                    });


                });


                /********************************* qtip **************************************/
                $('.preview').each(function () {
                    var item = $(this);
                    // We make use of the .each() loop to gain access to each element via the "this" keyword...
                    $(this).qtip(
                            {
                                content:{
                                    // Set the text to an image HTML string with the correct src URL to the loading image you want to use
                                    %{--text: '<img class="throbber" src="${resource(dir:"images",file:"load.gif")}" alt="Loading..." />',--}%
                                    ajax:{
                                        url:"${createLink(controller:"paginaWeb",action:"showContenido")}" + "/" + $(this).attr('pag'),
                                        type:'POST', // POST or GET,
                                        dataType:'html',
                                        success:function (data, status) {
                                            //alert(data)
                                            //$(".ui-tooltip-content").html(data)
                                            this.set('content.text', data);
//                            $(".ui-tooltip, .ui-tooltip-content").width(item.attr("w"));
                                            $(".ui-tooltip, .ui-tooltip-content").height(item.attr("h"));
//                            $(".ui-tooltip-titlebar").width((item.attr("w")) - $(".ui-tooltip-titlebar").css("margin-right"));
                                        }
                                    },
                                    title:{
                                        text:'Preview ', // Give the tooltip a title using each elements text
                                        button:true
                                    }
                                },
                                position:{
                                    at:'bottom right', // Position the tooltip above the link
                                    my:'top left',
                                    viewport:$(window) // Keep the tooltip on-screen at all times
                                },
                                show:{
                                    event:'click',
                                    solo:true // Only show one tooltip at a time
                                },
                                hide:'unfocus',
                                style:{
                                    classes:'ui-tooltip-wiki ui-tooltip-light ui-tooltip-shadow',
                                    width:item.attr("w"),
//                    height: item.attr("h")
                                }



                            })
                })

                    // Make sure it doesn't follow the link when we click it
                        .click(function (event) {
                            event.preventDefault();
                        });

            });
        </script>
    </body>
</html>
