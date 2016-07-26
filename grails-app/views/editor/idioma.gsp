<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/5/11
  Time: 1:09 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="nth.Idioma" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Selector de idioma</title>

        <style type="text/css">
        .option {
            border : solid 2px #ddd;
            margin : 5px;
        }
        </style>

    </head>

    <body>
        <div id="select" class="option ui-corner-all">
            <g:select from="${Idioma.list()}" optionKey="id" class="idioma " name="idioma"/>
        </div>

        <div id="links" class="option ui-corner-all">
            <g:each in="${Idioma.list()}" var="idioma">
                <a href="#">
                    ${idioma.nombre}
                </a>
                &nbsp;&nbsp;
            </g:each>
        </div>

        <div id="images" class="option ui-corner-all">
            <g:each in="${Idioma.list()}" var="idioma">
                <a href="#">
                    <img src="${createLink(controller:'idioma', action:'showImage', id: idioma.id)}"/>
                </a>
                &nbsp;&nbsp;
            </g:each>
        </div>
    </body>
</html>