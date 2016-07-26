<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <title>Polaroid Photobar Gallery with jQuery</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="description" content="Polaroid Photobar Gallery"/>
        <meta name="keywords" content="polaroid, jquery, css3, rotation, image gallery"/>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/Polaroid/css', file: 'style.css')}" type="text/css" media="screen"/>
        <script src="${resource(dir: 'js/jquery/plugins/Polaroid/js', file: 'jquery.transform-0.8.0.min.js')}"></script>

        <style type="text/css">
        h1 {
            font-size : 50px;
            margin    : 50px;
            color     : #333;
        }

        span.reference {
            font-family : Arial;
            position    : fixed;
            right       : 10px;
            top         : 10px;
            font-size   : 15px;
        }

        span.reference a {
            color           : #fff;
            text-transform  : uppercase;
            text-decoration : none;
        }

        </style>
    </head>

    <body>
        <div id="pp_gallery" class="pp_gallery">
            <div id="pp_loading" class="pp_loading"></div>
            <div id="pp_next" class="pp_next"></div>
            <div id="pp_prev" class="pp_prev"></div>

            <div id="pp_thumbContainer">

                <div class="album">
                    <g:each in="${files}" var="f" status="i">
                        <div class="content">
                            <img src="${resource(dir: 'images/tux', file: f.file)}" alt="${resource(dir: 'images/tux', file: f.file)}" title="${i}"/>
                            <span>${f.descripcion}</span>
                        </div>
                    </g:each>

                    <div class="descr">
                        Gal 1
                    </div>
                </div>

                <div class="album">
                    <g:each in="${files}" var="f" status="i">
                        <div class="content">
                            <img src="${resource(dir: 'images/tux', file: f.file)}" alt="${resource(dir: 'images/tux', file: f.file)}" title="${i}"/>
                            <span>${f.descripcion}</span>
                        </div>
                    </g:each>

                    <div class="descr">
                        Gal 2
                    </div>
                </div>


                <div class="pp_back">Albums</div>
            </div>
        </div>

        <script type="text/javascript">
            $(function() {
                var ie = false;
                if ($.browser.msie) {
                    ie = true;
                }

                //current album/image displayed
                var enableshow = true;
                var current = -1;
                var album = -1;
                //windows width (container width)
                var w_width = $(window).width();
                w_width = 500;
                //caching
                var $albums = $('#pp_thumbContainer div.album');
                var $loader = $('#pp_loading');
                var $next = $('#pp_next');
                var $prev = $('#pp_prev');
                var $images = $('#pp_thumbContainer div.content img');
                var $back = $('#pp_back');

                //we want to spread the albums through the page equally
                //number of spaces to divide with:number of albums plus 1
                var nmb_albums = $albums.length;
                var spaces = w_width / (nmb_albums + 1);
                var cnt = 0;
                //preload all the images (thumbs)
                var nmb_images = $images.length;
                var loaded = 0;
                $images.each(function(i) {
                    var $image = $(this);
                    $('<img />').load(
                            function() {
                                loaded++;
                                if (loaded == nmb_images) {
                                    //let's spread the albums equally on the bottom of the page
                                    $albums.each(
                                            function() {
                                                var $this = $(this);
                                                ++cnt;
                                                var left = spaces * cnt - $this.width() / 2;
                                                $this.css('left', left + 'px');
                                                $this.stop().animate({'bottom':'0px'}, 500);
                                            }).unbind('click').bind('click', spreadPictures);
                                    //also rotate each picture of an album with a random number of degrees
                                    $images.each(function() {
                                        var $this = $(this);
                                        var r = Math.floor(Math.random() * 41) - 20;
                                        $this.transform({'rotate'    : r + 'deg'});
                                    });
                                }
                            }).attr('src', $image.attr('src'));
                });

            });
        </script>

    </body>
</html>