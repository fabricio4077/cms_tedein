<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 8/29/12
  Time: 12:34 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Awkward</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/awkward-showcase', file: 'jquery.aw-showcase.min.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins/awkward-showcase/css', file: 'style.css')}" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <div style="width: 845px; margin: auto;">

            <!-- This is the button used to switch between One Page and Slideshow. -->
            <p>
                <a id="awOnePageButton" href="#">
                    <span class="view-page">View As One Page</span><span class="view-slide">View As Slideshow</span>
                </a>
            </p>

            <div id="showcase" class="showcase">

                <g:each in="${pags}" var="p">
                    <div class="showcase-slide" style="height: ${p.layout.contenido.height}px;">
                        <div class="showcase-content">
                            <g:each in="${p.secciones}" var="seccion">
                                <g:mostrarSeccion tipo="Borrador" idioma="0" id="${seccion.id}"/>
                            </g:each>
                        </div>

                        <div class="showcase-thumbnail">
                            %{--<img src="${resource(dir: 'images/wow', file: f.file)}" alt="${f.title}" width="140px"/>--}%

                            <ig:img src="${g.createLink(controller: 'image', action: 'showImage', id: p.fotoId)}" alt="${p.foto?.caption}" title="${p.foto?.caption}" width="140px"/>

                            <div class="showcase-thumbnail-caption">${p.nombre}</div>

                            <div class="showcase-thumbnail-cover"></div>
                        </div>

                        <div class="showcase-caption">
                            <h2>${p.nombre}</h2>
                        </div>
                    </div>
                </g:each>

            %{--<!-- Each child div in #showcase with the class .showcase-slide represents a slide. -->--}%
            %{--<div class="showcase-slide">--}%
            %{--<!-- Put the slide content in a div with the class .showcase-content. -->--}%
            %{--<div class="showcase-content">--}%
            %{--<img src="${resource(dir: 'images/wow', file: 'blacktemple-1024x.jpg')}" alt="black temple" width="700"/>--}%
            %{--</div>--}%
            %{--<!-- Put the thumbnail content in a div with the class .showcase-thumbnail -->--}%
            %{--<div class="showcase-thumbnail">--}%
            %{--<img src="${resource(dir: 'images/wow', file: 'blacktemple-1024x.jpg')}" alt="01" width="140px"/>--}%
            %{--<!-- The div below with the class .showcase-thumbnail-caption contains the thumbnail caption. -->--}%
            %{--<div class="showcase-thumbnail-caption">Black Temple</div>--}%
            %{--<!-- The div below with the class .showcase-thumbnail-cover is used for the thumbnails active state. -->--}%
            %{--<div class="showcase-thumbnail-cover"></div>--}%
            %{--</div>--}%
            %{--<!-- Put the caption content in a div with the class .showcase-caption -->--}%
            %{--<div class="showcase-caption">--}%
            %{--<h2>Be creative. Get Noticed!</h2>--}%
            %{--</div>--}%
            %{--</div>--}%

            %{--<div class="showcase-slide">--}%
            %{--<div class="showcase-content">--}%
            %{--<img src="${resource(dir: 'images/wow', file: 'bloodelf_vs_draenei-800x.jpg')}" alt="black temple" width="700"/>--}%
            %{--</div>--}%

            %{--<div class="showcase-thumbnail">--}%
            %{--<img src="${resource(dir: 'images/wow', file: 'bloodelf_vs_draenei-800x.jpg')}" alt="01" width="140px"/>--}%

            %{--<div class="showcase-thumbnail-caption">Caption Text</div>--}%

            %{--<div class="showcase-thumbnail-cover"></div>--}%
            %{--</div>--}%

            %{--<div class="showcase-caption">--}%
            %{--<h2>Be creative. Get Noticed!</h2>--}%
            %{--</div>--}%
            %{--</div>--}%

            </div>
        </div>




        <script type="text/javascript">

            $(document).ready(function () {
                $("#showcase").awShowcase(
                        {
                            content_width:700,
                            content_height:700,
                            fit_to_parent:false,
                            auto:true,
                            interval:3000,
                            continuous:true,
                            loading:true,
                            tooltip_width:200,
                            tooltip_icon_width:32,
                            tooltip_icon_height:32,
                            tooltip_offsetx:18,
                            tooltip_offsety:0,
                            arrows:true,
                            buttons:false,
                            btn_numbers:true,
                            keybord_keys:true,
                            mousetrace:false, /* Trace x and y coordinates for the mouse */
                            pauseonover:true,
                            stoponclick:false,
                            transition:'fade', /* hslide/vslide/fade */
                            transition_delay:0,
                            transition_speed:500,
                            show_caption:'show', /* onload/onhover/show */
                            thumbnails:true,
                            thumbnails_position:'outside-first', /* outside-last/outside-first/inside-last/inside-first */
                            thumbnails_direction:'horizontal', /* vertical/horizontal */
                            thumbnails_slidex:1, /* 0 = auto / 1 = slide one thumbnail / 2 = slide two thumbnails / etc. */
                            dynamic_height:false, /* For dynamic height to work in webkit you need to set the width and height of images in the source. Usually works to only set the dimension of the first slide in the showcase. */
                            speed_change:true, /* Set to true to prevent users from swithing more then one slide at once. */
                            viewline:false, /* If set to true content_width, thumbnails, transition and dynamic_height will be disabled. As for dynamic height you need to set the width and height of images in the source. */
                            custom_function:null /* Define a custom function that runs on content change */
                        });
            });

        </script>
    </body>
</html>