<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>CMS - NTH</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.tag-it.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.timers-1.2.js')}"></script>

        <link href="${resource(dir: 'js/jquery/plugins', file: 'reset.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/jquery/plugins', file: 'master.css')}" rel="stylesheet" type="text/css"/>

        <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>

        <link href="${resource(dir: 'js/jquery/plugins', file: 'jquery.ui.autocomplete.custom.css')}" rel="stylesheet"
              type="text/css"/>

        <style type="text/css">
        .fila {
            margin-bottom : 4px;
        }

        .celda {
            float : left;
        }

        .thPreview {
            float          : left;
            height         : 150px;
            width          : 150px;
            line-height    : 150px;
            text-align     : center;
            vertical-align : middle;
            border         : #4682b4 solid 2px;
            background     : #b0c4de;
            cursor         : pointer;
            margin         : 3px;
        }

        .selected {
            border-color : #556b2f;
            background   : #6b8e23;
        }

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
        </style>

    </head>

    <body>
        <ul class="topnav ui-corner-all" style="position:absolute; top:2px;z-index:1999;">
            <li><a href="nuevaGaleria.gsp#" id="guardar">Guardar</a></li>
        </ul>

        <g:form name="frmGaleria" action="guardarGaleria">
            <div style="float:left;position:relative;width:480px;height:90%;margin-top:60px;overflow:auto">

                <div class="fila" style="height: ${(tipo == 'Texto') ? '160' : '350'}px;">
                    <div class="celda etiqueta">
                        Dise&ntilde;o:
                    </div>

                    <div class="celda">

                        <div class="thPreview ui-corner-all selected" title="Awkward">
                            <img class="thumb" action="awkward"
                                 src="${resource(dir: 'images/gals', file: 'galleryView.png')}"/>
                        </div>

                        <g:if test="${tipo == 'Fotos'}">
                            <div class="thPreview ui-corner-all" title="Gallery View">
                                <img class="thumb" action="galleryView"
                                     src="${resource(dir: 'images/gals', file: 'galleryView.png')}"/>
                            </div>


                            <div class="thPreview ui-corner-all"
                                 style="padding-top:30px; height:120px;"
                                 title="Cloud Carousel">
                                <img class="thumb" action="cloudCarousel"
                                     src="${resource(dir: 'images/gals', file: 'cloudCarousel.png')}"/>
                            </div>
                            <br/>

                            <div class="thPreview ui-corner-all"
                                 style="padding-top:20px; height:130px;" title="jCycle">
                                <img class="thumb" action="jCycle" src="${resource(dir: 'images/gals', file: 'jCycle.png')}"/>
                            </div>

                            <div class="thPreview ui-corner-all"
                                 style="padding-top:10px; height:140px;"
                                 title="Cuadr&iacute;cula">
                                <img class="thumb" action="squares" src="${resource(dir: 'images/gals', file: 'squares.png')}"/>
                            </div>
                        </g:if>
                    %{--<img class="thumb" action="spaceGallery" src="${resource(dir: 'images/gals', file: 'gal_002.png')}"/>--}%
                    </div>
                </div>

                <div class="fila" id="filaNombre">
                    <div class="celda etiqueta">
                        Nombre:
                    </div>

                    <div class="celda">
                        <input class="texto bckg ui-corner-all" type="text" id="nombre" name="nombre"/>

                        <div id="errNombre" class='ui-state-error ui-corner-all ui-helper-hidden'
                             style="padding: 5px; margin-top:3px; font-weight:bold;">
                            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                            Ingrese el nombre de la galer&iacute;a
                        </div>

                    </div>
                </div>

                <div class="fila" style="${(tipo != 'Texto') ? 'display:none;' : ''}">
                    <div class="celda etiqueta">
                        Layout:
                    </div>

                    <div class="celda">
                        <g:select id="cmbLayoutPag" name="layoutContenido" from="${layoutsPag}" optionKey="id"
                                  optionValue="nombre" class="input ui-corner-all required texto bckg ui-corner-all"
                                  noSelection="['': '-Seleccione-']"/>
                    </div>
                </div>

                <div class="fila" style="height:170px;">
                    <div class="celda etiqueta">
                        Tags:
                    </div>
                    <ul style="width:238px; height:165px; float:left;" class="bckg ui-corner-all" id="mytags"></ul>
                </div>

                <input type="text" name="cont" value="${tipo}" style="display: none;"/>

            </div>

            <input type="text" name="idioma" id="idioma" class="ui-helper-hidden"/>
            <input type="text" name="tags" id="tags" class="ui-helper-hidden"/>
            <input type="text" name="layout" id="layout" class="ui-helper-hidden" value="awkward"/>

            </div>

            <div id="view" style="float:left;position:relative;width:480px;height:90%;margin-top:60px;overflow:auto">
            </div>

        </g:form>

        <div id="ventanaPropiedades" style="display:none">
            <input type="hidden" id="vpSeccion">

            <div id="tabla"></div>
        </div>


        <script type="text/javascript">

            function load(act) {
                if (act == "galleryView") {
                    $("#filaCont").show();
                } else {
                    $("#filaCont").hide();
                }

                $.ajax({
                    type:"POST",
                    url:"${createLink(controller: 'demos', action:'verDemo')}",
                    data:{
                        demo:act
                    },
                    success:function (msg) {
                        $("#view").html(msg);
                    }
                });
            }

            load("awkward");

            $(function () {
                /***********menu***********/
                $("ul.subnav").parent().append("<span></span>"); //Only shows drop down trigger when js is enabled (Adds empty span tag after ul.subnav*)

                $("ul.topnav li span, #seccion").click(
                        function () { //When trigger is clicked...

                            //Following events are applied to the subnav itself (moving subnav up and down)
                            $(this).parent().find("ul.subnav").slideDown('fast').show(); //Drop down the subnav on click

                            $(this).parent().hover(function () {
                            }, function () {
                                $(this).parent().find("ul.subnav").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up
                            });

                            //Following events are applied to the trigger (Hover events for the trigger)
                        }).hover(function () {
                            $(this).addClass("subhover"); //On hover over, add class "subhover"
                        }, function () {  //On Hover Out
                            $(this).removeClass("subhover"); //On hover out, remove class "subhover"
                        });

                $(".layout").click(function () {
                    var txt = $(this).attr("tipo");
                    window.location = "${createLink(action:'nuevaPagina', controller:'editor')}" + "/?id=" + txt;
                });

                $("#guardar").click(function () {
                    $("#ventanaPagina").dialog("open");
                });

                /***********menu***********/

                $("#nombre").keypress(function (evt) {
                    if (evt.keyCode == 9) {
                        $(".tagit-input").focus();
                        return false;
                    }
                });

                $(".tagit-input").keypress(function (evt) {
                    if (evt.keyCode == 9) {
                        $("#nombre").focus();
                        return false;
                    }
                });

                $(".thumb").livequery(function () {
                    $(this).click(function () {
                        var th = $(this);
                        $(".thumb").parent().removeClass("selected");
                        th.parent().addClass("selected");
                        var act = th.attr("action");
                        $("#layout").val(act);

                        load(act);
                    });
                });

                $("#mytags").tagit({
                    availableTags:["Galería", "Fotos"]
                });

                $("#guardar").click(function () {
                    var tags = "";
                    var nombre = $("#nombre").val();

                    $("#mytags li").children("span").each(function () {
                        tags += $(this).text() + " ";
                    });

                    var frm = $("[name=frmGaleria]");
                    //TODO: idioma debe ser session
                    var idioma = 6;

                    $("#idioma").val(idioma);
                    $("#tags").val(tags);

                    if (nombre.length > 0) {
                        frm.submit();

                    %{--$.ajax({--}%
                    %{--type: "POST",--}%
                    %{--url: "${createLink(action:'guardarGaleria')}",--}%
                    %{--data: frm.serialize(),--}%
                    %{--success: function(msg) {--}%
                    %{--alert("Data Saved: " + msg);--}%
                    %{--},--}%
                    %{--error: function() {--}%

                    %{--},--}%
                    %{--statusCode: {--}%
                    %{--404: function() {--}%
                    %{--alert('page not found');--}%
                    %{--},--}%
                    %{--302: function() {--}%
                    %{--alert("302");--}%
                    %{--}--}%
                    %{--}--}%
                    %{--}); //ajax--}%

                    } else {
                        $("#nombre").removeClass("bckg").addClass("ui-state-error");
                        $("#errNombre").show("pulsate");
                        $("#filaNombre").height(45);
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>
