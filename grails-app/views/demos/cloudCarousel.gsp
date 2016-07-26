<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/1/11
  Time: 11:12 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Cloud Carousel</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.timers-1.2.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/cloud-carousel', file: 'cloud-carousel.1.0.5.js')}"></script>
        %{--<link href="${resource(dir: 'js/jquery/plugins/galleryview/css', file: 'jquery.galleryview-3.0.css')}" rel="stylesheet" type="text/css"/>--}%

        <style type="text/css">
        .gv-title {
            font-size     : 16px;
            font-weight   : bold;
            margin-bottom : 5px;
        }
        </style>

    </head>
    <body>

        <!-- This is the container for the carousel. -->
        <div id="carousel1" class="ui-widget-content ui-corner-all" style="width:400px; height:360px;/*background:#000;*/overflow:scroll;position:relative;">
        <!-- All images with class of "cloudcarousel" will be turned into carousel items -->
        <!-- You can place links around these images -->
            <g:each in="${files}" var="f" status="i">
                <g:if test="${i==0}">
                    <img class="cloudcarousel front" src="${resource(dir: 'images/tux', file: f.file)}" title="${f.title}" alt="${f.descripcion}"/>
                </g:if>
                <g:else>
                    <img class="cloudcarousel" src="${resource(dir: 'images/tux', file: f.file)}" title="${f.title}" alt="${f.descripcion}"/>
                </g:else>
            </g:each>

        <!-- Define left and right buttons. -->
            <a href="#" id="left-but" style="position:absolute; left: 0; bottom: 0;">Anterior</a>
            <a href="#" id="right-but" style="position:absolute; right: 0; bottom: 0;">Siguiente</a>
        </div>

        <div class="ui-widget-content ui-corner-all" style="width:390px; padding:5px;">
            <!-- Define elements to accept the alt and title text from the images. -->
            <div class="gv-title" id="title-text"></div>
            <p id="alt-text"></p>
        </div>

        <script>
            $(document).ready(function() {

                $("#left-but").button({
                    icons: {
                        primary: "ui-icon-triangle-1-w"
                    },
                    text: false
                }).click(function() {
                    return false;
                });
                $("#right-but").button({
                    icons: {
                        secondary: "ui-icon-triangle-1-e"
                    },
                    text: false
                }).click(function() {
                    return false;
                });

                $(".cloudcarousel").click(function() {
                    if ($(this).hasClass("front")) {
                        ////console.log($(this).attr("src"));
                    }
                });

                // This initialises carousels on the container elements specified, in this case, carousel1.
                $("#carousel1").CloudCarousel({
                    maxW: 200,
                    maxH:200,
                    xPos: 200,
                    yPos: 50,
                    buttonLeft: $("#left-but"),
                    buttonRight: $("#right-but"),
                    altBox: $("#alt-text"),
                    titleBox: $("#title-text"),
                    minScale: 0.25,
                    bringToFront: true
                });
            });

        </script>

    </body>
</html>