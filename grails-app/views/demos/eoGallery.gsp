<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/1/11
  Time: 11:10 AM
  To change this template use File | Settings | File Templates.
--%>

<%--

link del demo: http://www.eogallery.com/

--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>EOGallery</title>
        <link href="${resource(dir: 'js/jquery/plugins/eogallery/css', file: 'main.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/jquery/plugins/eogallery/css', file: 'thickbox.css')}" rel="stylesheet" type="text/css"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/eogallery/js', file: 'slider.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/eogallery/js', file: 'global.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/eogallery/js', file: 'thickbox.js')}"></script>

        <style type="text/css">
        .gv-title {
            font-size     : 16px;
            font-weight   : bold;
            margin-bottom : 5px;
        }
        </style>

    </head>
    <body>
        <div id="container">

            <div id="main" class="clearfix">
                <div id="slider">
                    <div>
                        <div class="floating">
                            <a id="butleft" href="#"><img src="${resource(dir: 'js/jquery/plugins/eogallery/images', file: 'left.png')}" alt=""/></a>
                        </div>
                        <div class="floating">
                            <ul class="clearfix">
                                <g:each in="${files}" var="f" status="i">
                                    <li id="image${i}">
                                        <a href="${resource(dir: 'images/tux', file: f.file)}" class="thickbox imtitle" title="${f.title}">${f.title}</a>
                                        <a href="${resource(dir: 'images/tux', file: f.file)}" class="thickbox" title="${f.title}"><img src="${resource(dir: 'images/tux', file: f.file)}" alt=""/></a>

                                        <div id="text${i}" class="text">
                                            <div class='gv-title'>${f.title}</div>
                                            ${f.descripcion} ${f.descripcion} ${f.descripcion} ${f.descripcion}
                                        </div>
                                    </li>
                                </g:each>
                            </ul>
                        </div>
                        <div class="floating">
                            <a id="butright" href="#"><img src="${resource(dir: 'js/jquery/plugins/eogallery/images', file: 'right.png')}" alt=""/></a>
                        </div>
                    </div>
                    <div id="controls">
                        <a href="" id="playpause" title="Play/Pause automatic slideshow"><img src="${resource(dir: 'js/jquery/plugins/eogallery/images', file: 'playred.png')}"
                                alt="Play/Pause"/></a> <a
                            href="" id="directlink" title="Direct link to the current picture"><img
                                src="${resource(dir: 'js/jquery/plugins/eogallery/images', file: 'directlink.png')}" alt="Direct Link"
                                style="margin-bottom: 7px; margin-left: 10px;"/></a>
                    </div>
                </div>
                <div id="texts"></div>
            </div>
        </div>
    </body>
</html>