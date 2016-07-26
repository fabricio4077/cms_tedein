<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/4/11
  Time: 11:34 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Gallery View</title>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.easing.1.3.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.timers-1.2.js')}"></script>

        <style type="text/css">
        .gv-title {
            font-size     : 16px;
            font-weight   : bold;
            margin-bottom : 5px;
        }

        .squaresItem {
            cursor : pointer;
        }
        </style>

    </head>
    <body>

        <ul id="myGallery">
            <g:each in="${files}" var="f" status="i">
                <li class="squaresItem">
                    <img width="100" height="100" src="${resource(dir: 'images/tux', file: f.file)}" title="${i}"/>
                </li>
            </g:each>
        </ul>

        <script type="text/javascript">
            $(function() {
                $(".squaresItem").click(function() {
                    ////console.log("CLICK");
                });
            });
        </script>

    </body>
</html>