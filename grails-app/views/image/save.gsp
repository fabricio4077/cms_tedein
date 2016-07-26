<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="frame"/>
        <style type="text/css" media="screen">
        * {
            margin  : 0;
            padding : 0;
        }

        body {
            font    : 12px Arial, Verdana, Sans-Serif;
            padding : 0 20px;
        }

        h4 {
            margin : 15px 0 5px 0;
        }

        h4, p {
            font-size : 1.2em;
        }

        ul li {
            display : inline;
        }

        .wide {
            border-bottom : 1px #000 solid;
            width         : 4000px;
        }
        </style>
        <title>NTH</title>
    </head>
    <body>
        NTH
        <input type="hidden" value="${seccion.id}" name="seccion" id="seccion">
        <script type="text/javascript">
            jQuery(function($) {

                var nombre = $("#seccion").val() + "Contenido"
                var elem = $(window.opener.document.getElementsByClassName("frmEditarPagina"));

                elem.submit()
                window.close()


            });

        </script>
    </body>
</html>