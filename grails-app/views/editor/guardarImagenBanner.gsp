<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="frame"/>

    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.tag-it.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins', file: 'jquery.ui.autocomplete.custom.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'css', file: 'editor.css')}" rel="stylesheet" type="text/css"/>

    <title>NTH</title>
</head>
<body>
<div style="position:absolute;left:39%;top:35%;"><img src="${resource(dir:'images',file:'load.gif')}"></div>
<script type="text/javascript">
    /* TODO  hacer la verificacion del # de caracteres en el textfield de tags........... hacer todas las validaciones con js */

    function recargar(){
        var btn = $(window.opener.document.getElementById("reloadBanner"));
        btn.click();
        window.close()
    }

    jQuery(function($) {

    setTimeout("recargar()",2500);

    });
</script>
</body>
</html>
