<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/11/11
  Time: 12:59 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame"/>
        <title>Simple GSP page</title>
    </head>
    <body>

        <div id="galeria">
            ${gl.renderGal(parms)}
        </div>

        <script type="text/javascript">
            $(function() {

                var h = $("#galeria").height();
                var w = $("#galeria").children("div").first().width();

//                //console.log($("#galeria"));
//                //console.log($("#galeria").children("div").first());
//
//                //console.log("W:" + w + " H:" + h);

                var seccion = ${seccion};

                var nombreSeccion = seccion;
                var sec = $(window.opener.document.getElementById(nombreSeccion));
                sec.width(w);
                sec.height(h);

                var nombreH = seccion + "hei";
                var th = $(window.opener.document.getElementById(nombreH));
                th.val(h);

                var nombreW = seccion + "wid";
                var tw = $(window.opener.document.getElementById(nombreW));
                tw.val(w);

                var nombreTxt = "idSeccionGaleria";
                var txt = $(window.opener.document.getElementById(nombreTxt));
                txt.val(seccion);

                var nombreBtn = "botonGaleria";
                var btn = $(window.opener.document.getElementById(nombreBtn));
                btn.click();

                window.close();
            });
        </script>
    </body>
</html>