<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 5/31/11
  Time: 3:58 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="frame" />
        <title>Simple GSP page</title>

        <link rel="stylesheet" href="${g.resource(dir: 'js/jquery/plugins/jpicker', file: 'jPicker.css')}"
              type="text/css" />

        <link rel="stylesheet" href="${g.resource(dir: 'js/jquery/plugins/jpicker/css', file: 'jPicker-1.1.6.css')}"
              type="text/css" />
        <script type="text/javascript"
                src="${g.resource(dir: 'js/jquery/plugins/jpicker', file: 'jpicker-1.1.6.js')}"></script>

    </head>

    <body>
        <script type="text/javascript">
            $(document).ready(
                    function() {
                        $('.multiple').jPicker({
                                    window: {
                                        alphaSupport: true,
                                        position:
                                        {
                                            x: 0, /* acceptable values "left", "center", "right", "screenCenter", or relative px value */
                                            y: 0 /* acceptable values "top", "bottom", "center", or relative px value */
                                        }
                                    },
                                    images:
                                    {
                                        clientPath: '${resource(dir:"js/jquery/plugins/jpicker/images")}/' /* Path to image files */
                                    }
                                });

                        $('.button').click(function() {
                            var n = $(this).attr("n");
                            var col = $.jPicker.List[n].color.active.val('rgba');
                            var rgba
                            if (col != null) {
                                var a = (col.a) / 255;
                                rgba = "rgba(" + col.r + "," + col.g + "," + col.b + "," + a + ")";
                            } else {
                                rgba = "none";
                            }
                            $("#bg").css("background", rgba);
                            ////console.log(rgba);
                        });

                    });
        </script>

        %{--<div id="Inline"></div>--}%

        <input class="multiple" type="text" value="e2ddcf" /><br />
        <input class="button" n="0" type="button" value="Get Active Color" /><br />

        <input class="multiple" type="text" value="" /><br />
        <input class="button" n="1" type="button" value="Get Active Color" /><br />

        <input class="multiple" type="text" value="fda0f7" /><br />
        <input class="button" n="2" type="button" value="Get Active Color" /><br />

        <div style="width: 200px; height: 200px; position: absolute; top: 100px; left: 300px; border:  solid black 3px; z-index: 1;">
            PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA PRUEBA
        </div>

        <div id='bg'
             style="width: 200px; height: 200px; position: absolute; top: 130px; left: 330px; border:  solid #b85700 3px; z-index: 2;">
        </div>

    </body>
</html>