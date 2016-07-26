<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/11/11
  Time: 11:54 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Seleccionar galer&iacute;a</title>

        <style type="text/css">
        .lista {
            list-style : none;
        }
        </style>
    </head>
    <body>
        <div id="dialog">
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Galer&iacute;as de fotos (${fotos.size()})</a></li>
                    <li><a href="#tabs-2">Galer&iacute;as de contenidos (${cont.size()})</a></li>
                    <li><a href="#tabs-3">Galer&iacute;as de videos (${videos.size()})</a></li>
                </ul>
                <div id="tabs-1">
                    <p>
                    <ul id="fotos" class="lista">
                        <g:each in="${fotos}" var="gal">
                            <li>
                                <input type="radio" name="gal" class="radio" value="${gal.id}"/> ${gal.nombre}
                            </li>
                        </g:each>
                    </ul>
                </p>
                </div>
                <div id="tabs-2">
                    <p>
                    <ul id="contenido" class="lista">
                        <g:each in="${cont}" var="gal">
                            <li>
                                <input type="radio" name="gal" class="radio" value="${gal.id}"/> ${gal.nombre}
                            </li>
                        </g:each>
                    </ul>
                </p>
                </div>
                <div id="tabs-3">
                    <p>
                    <ul id="videos" class="lista">
                        <g:each in="${videos}" var="gal">
                            <li>
                                <input type="radio" name="gal" class="radio" value="${gal.id}"/> ${gal.nombre}
                            </li>
                        </g:each>
                    </ul>
                </p>
                </div>
            </div>
        </div>

        <script>
            $(function() {
                $("#dialog").dialog({
                    title: "Galerías",
                    width: 800,
                    height: 560,
                    buttons: {
                        "Aceptar": function() {
                            var r = $(".radio:checked").val();
                            var url = '${createLink(action: "guardarSeccionGaleria", id:id)}?gal=' + r;
                            location.href = url;
                        }
                    }
                });

                $("#tabs").tabs({

                });
            })
                    ;
        </script>
    </body>
</html>