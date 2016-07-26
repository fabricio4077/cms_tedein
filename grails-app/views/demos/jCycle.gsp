<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/1/11
  Time: 11:10 AM
  To change this template use File | Settings | File Templates.
--%>

<%--

link del demo: http://spaceforaname.com/galleryview

--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Gallery View</title>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.easing.1.3.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.timers-1.2.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.cycle.all.js')}"></script>


        <style type="text/css">
        .gv-title {
            font-size     : 16px;
            font-weight   : bold;
            margin-bottom : 5px;
        }
        </style>

    </head>
    <body>

        <ul id="jc">
            <g:each in="${files}" var="f" status="i">
                <li>
                    <img src="${resource(dir: 'images/tux', file: f.file)}" title="${i}"/>
                    <div class="gv-panel-overlay">
                        <div class='gv-title'>${f.title}</div>
                        ${f.descripcion}
                    </div>
                </li>
            </g:each>
        </ul>

        <script type="text/javascript">
            $(function() {
                $('#jc').cycle({
                    fx:     'scrollLeft',
                    timeout: 5000
                });
            });
        </script>

    </body>
</html>