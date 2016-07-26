<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:imports/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/lightbox/css', file: 'prettyPhoto.css')}"
          type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8"/>
    <script src="${resource(dir: 'js/jquery/plugins/lightbox/js', file: 'jquery.prettyPhoto.js')}"
            type="text/javascript" charset="utf-8"></script>
    <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hoverIntent.minified.js')}" type="text/javascript"
            charset="utf-8"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jCarouselLite.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.ba-throttle-debounce.js')}" type="text/javascript"
            charset="utf-8"></script>

    <meta name="layout" content="frame"/>

    <style type="text/css" media="screen">
    * {
        margin  : 0;
        padding : 0;
    }

    body {

        padding : 0 20px;
        font-size: 12px !important;
    }

    ul li {
        display : inline;
    }

    .wide {
        border-bottom : 1px #000 solid;
        width         : 4000px;
    }

    .selected {
        border     : solid 1px #9932cc;
        background : #d8bfd8;
    }
    .select {
        cursor: pointer;
    }

    </style>
    <title>NTH: Idiomas</title>
</head>

<body>

<div style="width:800px ;height:750 ;float: left">
    <div style="width: 400px;height: 60px;margin: auto;margin-top: 55px;text-align: center;font-size: 18px;line-height: 18px;font-family: fantasy;font-style: oblique;font-weight: bold;">
        Escoja un tipo de menu para su sitio
    </div>
    <div style="width: 340px;height: 80px;margin-left: 40px;margin-top: 20px;float: left;border: 1px solid black;background: white;">
        <iframe src="${createLink(action:'mostrarMenu',id:'deepBlue')}" style="width: 100%;height: 60px;border: none" ></iframe>
        <span class="ui-icon ui-icon-circle-plus select" style="float:right;" title="Seleccionar" tipo="deepBlue">Seleccionar</span>
    </div>
    <div style="width: 340px;height: 80px;margin-left: 20px;margin-top: 20px;float: left;border: 1px solid black;background: white;">
        <iframe src="${createLink(action:'mostrarMenu',id:'menu1')}" style="width: 100%;height: 60px;border: none"></iframe>
        <span class="ui-icon ui-icon-circle-plus select" style="float:right;" title="Seleccionar" tipo="menu1">Seleccionar</span>
    </div>

    <div style="width: 340px;height: 80px;margin-left: 40px;margin-top: 20px;float: left;border: 1px solid black;background: white;">
        <iframe src="${createLink(action:'mostrarMenu',id:'menu2')}" style="width: 100%;height: 60px;border: none"></iframe>
        <span class="ui-icon ui-icon-circle-plus select" style="float:right;" title="Seleccionar" tipo="menu2">Seleccionar</span>
    </div>
    <div style="width: 340px;height: 80px;margin-left: 20px;margin-top: 20px;float: left;border: 1px solid black;background: white;">
        <iframe src="${createLink(action:'mostrarMenu',id:'menu3')}" style="width: 100%;height: 60px;border: none"></iframe>
        <span class="ui-icon ui-icon-circle-plus select" style="float:right;" title="Seleccionar" tipo="menu3">Seleccionar</span>
    </div>

    <div style="width: 340px;height: 80px;margin-left: 40px;margin-top: 20px;float: left;border: 1px solid black;background: white;">
        <iframe src="${createLink(action:'mostrarMenu',id:'menu4')}" style="width: 100%;height: 60px;border: none;overflow-x: hidden"></iframe>
        <span class="ui-icon ui-icon-circle-plus select" style="float:right;" title="Seleccionar" tipo="menu4">Seleccionar</span>
    </div>
</div>


<script type="text/javascript">

    $(".select").click(function(){
        $.ajax({
            type: "POST",
            url: "${createLink(controller:"menu",action:"guardarTipo")}",
            data:"tipo="+$(this).attr("tipo"),
            success: function(msg) {
                if(msg=="ok"){
                    window.parent.location.reload("true")
                }
            }
        });
    })
</script>
</body>
</html>
