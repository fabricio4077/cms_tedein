<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/1/11
  Time: 11:11 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Spacegallery</title>
        <link rel="stylesheet" media="screen" type="text/css" href="${resource(dir: 'js/jquery/plugins/spacegallery/css', file: 'layout.css')}"/>
        <link rel="stylesheet" media="screen" type="text/css" href="${resource(dir: 'js/jquery/plugins/spacegallery/css', file: 'spacegallery.css')}"/>
        %{--<link rel="stylesheet" media="screen" type="text/css" href="${resource(dir: 'js/jquery/plugins/spacegallery/css', file: 'custom.css')}"/>--}%

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.timers-1.2.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/spacegallery/js', file: 'eye.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/spacegallery/js', file: 'utils.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/spacegallery/js', file: 'spacegallery.js')}"></script>
        %{--<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/spacegallery/js', file: 'layout2.js')}"></script>--}%

        <style type="text/css">
        #myGallery {
        /*width  : 100%;*/
            width  : 500px;
            height : 500px;
        }

        #myGallery img {
            border : 2px solid #52697E;
        }

        a.loading {
            background : #fff url(../images/ajax_small.gif) no-repeat center;
        }
        </style>

    </head>
    <body>

        <div id="myGallery" class="spacegallery">
            <g:each in="${files}" var="f" status="i">
                <img src="${resource(dir: 'images/tux', file: f.file)}" title="${i}"/>
            </g:each>
        </div>

        <script type="text/javascript">
            (function($) {
                var initLayout = function() {
                    $('#myGallery').spacegallery({
                        loadingClass: 'loading',
                        border: 2
                    });
                };

                EYE.register(initLayout, 'init');
            })(jQuery)
        </script>

    </body>
</html>