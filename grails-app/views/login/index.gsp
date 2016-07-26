<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>NTH</title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'nth2.jpeg')}" type="image/x-icon" />
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.4.2.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.5.custom.min.js')}"></script>
    <link href="${resource(dir: 'js/jquery/css/dark-hive', file: 'jquery-ui-1.8.5.custom.css')}" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/galleryview/js', file: 'jquery.timers-1.2.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/cloud-carousel', file: 'cloud-carousel.1.0.5.js')}"></script>
    %{--<link href="${resource(dir: 'js/jquery/plugins/galleryview/css', file: 'jquery.galleryview-3.0.css')}" rel="stylesheet" type="text/css"/>--}%

    <style type="text/css">
    .gv-title {
        font-size     : 16px;
        font-weight   : bold;
        margin-bottom : 5px;
    }
    </style>
    <style type="text/css">
    body {
        background-color: #FFFFFF;
        color: #000000;
        font-size: 12px;
    }
    * {
        border: 0 none;
        margin: 0;
        outline: 0 none;
        padding: 0;
    }
    .titulo{
        width: 95%;
        height: 30px;
        margin: auto;
        margin-top: 0px;
        line-height: 30px;
        text-align: center;
        font-size: 18px;
        font-family: fantasy;
        font-style: italic;
        /*border-bottom: #d7d7d7 1px solid;*/
    }
    .foto{
        width: 90%;
        height: 170px;
        margin: auto;
        margin-top: 0px;
    }
    .texto{
        width: 90%;
        height: 170px;
        margin: auto;
        margin-top: 5px;
        padding: 2px;
        text-align: justify;
    }
    .box{
        width: 250px;
        height: 390px;
        float: left;
        margin-right: 20px;
    }
    .content{
        width: 250px;
        height: 105%;
        background: #F4DA6C;
        margin: auto;
        border: #6E8EA6 solid 2px;
    }
    </style>
</head>
<body>
<div id="centroArriba" style="margin: auto;margin-top: 3px;width: 900px;height:60px;padding: 10px; ">
    <div id="logo" style="width: 60px;height: 60px;float: left;" class="ui-corner-all" ><img src="${resource(dir: 'images', file: 'nth2.jpeg')}" alt="NTH" width="60px;" height="60px;"></div>
    <div id="slg"  style="width: 300px;height: 60px;font-size: 38px;font-family:fantasy;font-style: oblique;  ;float: left;line-height: 60px;margin-left: 20px;" class="ui-corner-all">NTH - nth</div>
    <div id="login" style="width: 400px;height: 60px;line-height: 60px;float: right; position: relative;">
        <g:form action="login" method="post" >

            <div id="dummy" style="width: 150px; z-index: 3; height:30px; line-height: 30px; margin-top: 15px; position: absolute; left: 160px;color: #777;">Password</div>
            <input type="text" id="usr" style=" z-index: 1; background: #ECECEC;width: 150px;height: 30px;margin-top: 15px;border:#d7d7d7 solid 1px;padding-left: 8px;color: #777;" class="ui-corner-all" value="username" name="login" >

            <input type="password" id="psw" style="background: #ECECEC;width: 150px;height: 30px;margin-top: 15px;border:#d7d7d7 solid 1px;padding-left: 8px;color: #777;" class="ui-corner-all" value="" name="pass">

            <g:submitButton value="Sign in" style="height: 30px;margin-top: 15px;width: 70px;border: 1px solid black" class="ui-corner-all" name="login_btn"/>
        </g:form>
    </div>
</div>
%{--<div style="margin-top: 5px;clear: both;overflow: hidden;height: 360px; background:none repeat scroll 0 0 #0E3460;width: 100%"  >--}%
    %{--<div style="width: 850px;height: 100%;margin: auto;;position:relative" id="carousel1">--}%
        %{--<g:each in="${files}" var="f" status="i">--}%
            %{--<g:if test="${i==0}">--}%
                %{--<img class="cloudcarousel front" src="${resource(dir: 'images/wow', file: f.file)}" title="${f.title}" alt="${f.descripcion}"/>--}%
            %{--</g:if>--}%
            %{--<g:else>--}%
                %{--<img class="cloudcarousel" src="${resource(dir: 'images/wow', file: f.file)}" title="${f.title}" alt="${f.descripcion}"/>--}%
            %{--</g:else>--}%
        %{--</g:each>--}%

    %{--</div>--}%

%{--</div>--}%
%{--<div id="centroAbajo" style="margin: auto;margin-top: 5px;width: 850px;height:400px;position: relative; ">--}%
    %{--<div class="box" style="margin-left: 20px;">--}%
        %{--<div class="ui-corner-all content" style="">--}%
            %{--<div  class="ui-corner-all titulo">Titulo</div>--}%
            %{--<div class="ui-corner-all foto"><img src="${resource(dir: 'images', file: 'nth2.jpeg')}" alt="NTH" width="100%" height="100%"></div>--}%
            %{--<div class="ui-corner-all texto">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet lacus ligula--}%
            %{--. Quisque euismod consequat nisi, a pharetra quam eleifend vel. Nunc eget massa orci--}%
            %{--. Quisque euismod consequat nisi, a pharetra quam eleifend vel. Nunc eget massa orci--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
    %{--<div class="box">--}%
        %{--<div class="ui-corner-all content" >--}%
            %{--<div  class="ui-corner-all titulo">Titulo</div>--}%
            %{--<div class="ui-corner-all foto"><img src="${resource(dir: 'images', file: 'nth2.jpeg')}" alt="NTH" width="100%" height="100%"></div>--}%
            %{--<div class="ui-corner-all texto">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet lacus ligula--}%
            %{--. Quisque euismod consequat nisi, a pharetra quam eleifend vel. Nunc eget massa orci--}%
            %{--. Quisque euismod consequat nisi, a pharetra quam eleifend vel. Nunc eget massa orci--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
    %{--<div class="box">--}%
        %{--<div class="ui-corner-all content">--}%
            %{--<div  class="ui-corner-all titulo" style="margin-left: 18px;">Titulo</div>--}%
            %{--<div class="ui-corner-all foto"  style="margin-left: 18px;"><img src="${resource(dir: 'images', file: 'nth2.jpeg')}" alt="NTH" width="100%" height="100%"></div>--}%
            %{--<div class="ui-corner-all texto"  style="margin-left: 18px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet lacus ligula--}%
            %{--. Quisque euismod consequat nisi, a pharetra quam eleifend vel. Nunc eget massa orci--}%
            %{--. Quisque euismod consequat nisi, a pharetra quam eleifend vel. Nunc eget massa orci--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%


</div>


<script>
    $(document).ready(function() {

        $("#usr").focus(function(){
            $("#usr").val("")
        });
        $("#usr").blur(function(){
            if($(this).val()=="")
                $("#usr").val("username")
        });

        $("#dummy").click(function() {
            $("#dummy").hide();
            $("#psw").focus();
        });
        $("#psw").focus(function() {
            $("#dummy").hide();
        });
        $("#psw").blur(function(){
            if($(this).val()=="")
                $("#dummy").show();
        });

        $("#left-but").button({
                    icons: {
                        primary: "ui-icon-triangle-1-w"
                    },
                    text: false
                }).click(function() {
                    return false;
                });
        $("#right-but").button({
                    icons: {
                        secondary: "ui-icon-triangle-1-e"
                    },
                    text: false
                }).click(function() {
                    return false;
                });

        $(".cloudcarousel").click(function() {
            if ($(this).hasClass("front")) {
            }
        });

        // This initialises carousels on the container elements specified, in this case, carousel1.
        $("#carousel1").CloudCarousel({
                    maxW: 500,
                    maxH:295,
                    xPos: 425,
                    yPos: 20,
                    xRadius:0,
                    yRadius:0,
                    minScale: 0.25,
                    bringToFront: true,
                    autoRotate: 'yes',
                    speed:0.2,
                    autoRotateDelay: 3500
                });
    });

</script>
</body>
</html>