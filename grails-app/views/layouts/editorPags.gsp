<html>
<head>
    <title>CMS - NTH - ${session.sitio}</title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'nth2.jpeg')}" type="image/x-icon"/>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.4.2.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.5.custom.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'interface.js')}"></script>
    <link href="${resource(dir: 'css', file: 'style.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/jquery/css/dark-hive', file: 'jquery-ui-1.8.5.custom.css')}" rel="stylesheet"
          type="text/css"/>
    <g:layoutHead/>
    <!--[if lt IE 7]>
 <style type="text/css">
 .dock img { behavior: url(iepngfix.htc) }
  </style>
<![endif]-->
</head>

<body>
<g:layoutBody/>
<div class="contenido">
    <iframe id="contenido" style="border:none;width:1000px;height:550px" name="contenido"></iframe>

    <div style="position:absolute;left:200px;bottom:30px;cursor:pointer;width:150px;height:100px;line-height:30px;padding-left:10px;z-index:99999"
         id="idiomas" class="ui-widget-content ui-corner-all">
        <div>
            Idioma:
            <g:select from="${nth.Idioma.list()}" optionKey="id" class="idioma " name="idioma"
                      value="${session.idioma.id}"></g:select>
        </div>

        <div>
            Sitio: ${session.sitio.nombre} <g:link style="margin-left: 15px;" controller="editor"
                                                   action="sitios">Cambiar</g:link>
        </div>

        <div>
            <g:link controller="login" action="logout">Logout</g:link>
        </div>
    </div>

</div>
<g:render template="../layouts/menu"/>


<script type="text/javascript">

    calcSize();

    function calcSize() {
        var hMenu = 85;
        var wMenu = 520;

        var h1 = $(window).height();   // returns height of browser viewport
        var h2 = $(document).height(); // returns height of HTML document
        var w1 = $(window).width();   // returns width of browser viewport
        var w2 = $(document).width(); // returns width of HTML document

        var hh = Math.min(h1, h2);
        hh -= hMenu;
        hh = Math.max(hh, 550);

        var ww = Math.min(w1, w2);
        ww -= wMenu;
        ww = Math.max(ww, 700);

        $(".contenido").height(hh).width(ww);
        $("#contenido").height(hh).width(ww);

        //                //console.log(h1 + "  " + h2 + "  " + w1 + "  " + w2);
    }

    $(window).resize(function () {
        calcSize();
    });

    $("#idiomas").draggable()
    $(".idioma").change(function () {
        $.ajax({
            type:"POST",
            url:"${createLink(controller:'editor',action:'cambiarIdioma')}",
            data:"id=" + $(this).val(),
            success:function (msg) {
                window.location.reload();
            }});
    })



</script>

</body>
</html>