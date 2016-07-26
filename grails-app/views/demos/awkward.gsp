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

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/awkward-showcase', file: 'jquery.aw-showcase.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins/awkward-showcase/css', file: 'style.css')}" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <g:set var="w" value="450"/>
        <g:set var="h" value="450"/>

        <div style="width: 845px; margin: auto;">

            <!-- This is the button used to switch between One Page and Slideshow. -->
            %{--<p>--}%
            %{--<a id="awOnePageButton" href="#">--}%
            %{--<span class="view-page">View As One Page</span><span class="view-slide">View As Slideshow</span>--}%
            %{--</a>--}%
            %{--</p>--}%

            <div id="showcase" class="showcase">

                <g:each in="${files}" var="f">
                    <div class="showcase-slide">
                        <div class="showcase-content">
                            <img src="${resource(dir: 'images/tux', file: f.file)}" alt="${f.title}" height="${h}"/>
                        </div>

                        <div class="showcase-thumbnail" %{--style="width: 150px; height: 150px;"--}%>
                            <img src="${resource(dir: 'images/tux', file: f.file)}" alt="${f.title}" width="150px"/>

                            <div class="showcase-thumbnail-caption">${f.title}</div>

                            %{--<div class="showcase-thumbnail-cover">--}%
                                %{--<img src="${resource(dir: 'images/tux', file: f.file)}" alt="${f.title}" width="50px"/>--}%
                            %{--</div>--}%
                        </div>

                        <div class="showcase-caption">
                            <h2>${f.descripcion}</h2>
                        </div>
                    </div>
                </g:each>

            </div>
        </div>


        <script type="text/javascript">

            $(document).ready(function () {
                $("#showcase").awShowcase(
                        {
                            content_width:${w},
                            content_height:${h},
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
                            show_caption:false, /* onload/onhover/show */
                            thumbnails:true,
                            thumbnails_position:'outside-first', /* outside-last/outside-first/inside-last/inside-first */
                            thumbnails_direction:'horizontal', /* vertical/horizontal */
                            thumbnails_slidex:1, /* 0 = auto / 1 = slide one thumbnail / 2 = slide two thumbnails / etc. */
                            dynamic_height:true, /* For dynamic height to work in webkit you need to set the width and height of images in the source. Usually works to only set the dimension of the first slide in the showcase. */
                            speed_change:true, /* Set to true to prevent users from swithing more then one slide at once. */
                            viewline:false, /* If set to true content_width, thumbnails, transition and dynamic_height will be disabled. As for dynamic height you need to set the width and height of images in the source. */
                            custom_function:null /* Define a custom function that runs on content change */
                        });
            });

        </script>
    </body>
</html>