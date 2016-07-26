

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:importsWeb/>
    <title>${session.sitio}</title>

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'tedein_favicon.png')}">

    <style type="text/css" media="screen">
    a, a:visited, a:link {
        text-decoration : none
    }

    a:hover {
        text-decoration : underline;
    }

    * {
        margin  : 0;
        padding : 0;
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

    </style>

    %{--<link rel="stylesheet" href="estilosIdiomas.gsp" type="text/css"/>--}%
    %{--<script type="text/javascript">--}%

    %{--var _gaq = _gaq || [];--}%
    %{--_gaq.push(['_setAccount', 'UA-34381475-1']);--}%
    %{--_gaq.push(['_trackPageview']);--}%

    %{--(function() {--}%
    %{--var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;--}%
    %{--ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';--}%
    %{--var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);--}%
    %{--})();--}%

    %{--</script>--}%
</head>

<body style="${(pagina.layout?.css != null) ? pagina.layout?.css : ''}">

<g:set var="maxW" value="${pagina.layout.banner ? pagina.layout.banner.width : 0}"/>
<g:set var="maxW" value="${pagina.layout.menu ? Math.max(maxW, pagina.layout.menu.width) : maxW}"/>
<g:set var="maxW" value="${pagina.layout.idioma ? Math.max(maxW, pagina.layout.idioma.width) : maxW}"/>
<g:set var="maxW" value="${pagina.layout.contenido ? Math.max(maxW, pagina.layout.contenido.width) : maxW}"/>

<div style="width: ${maxW}px; height: 100%; margin: auto; position: relative;">
    <g:if test="${pagina.layout.banner}">
        <div class="banner"
             style="position:absolute;top:${pagina.layout.banner.top};left:${pagina.layout.banner.izq};width:${pagina.layout.banner.width};height:${pagina.layout.banner.height}; ${pagina.layout.banner.css};"
             estilo="position:absolute;top:${pagina.layout.banner.top};left:${pagina.layout.banner.izq};width:${pagina.layout.banner.width};height:${pagina.layout.banner.height}; ${pagina.layout.banner.css};">
            <g:if test="${pagina.layout?.banner.foto}">
                ${ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: pagina.layout?.banner?.foto?.id), "alt": pagina.layout?.banner?.foto?.caption, "title": pagina.layout?.banner?.foto?.caption, "thumbnailSrc": g.createLink(action: 'showImage', controller: 'image', id: pagina.layout?.banner?.foto?.id, params: [thumbnail: false])])}
            </g:if>
            <g:if test="${pagina.layout.banner.contenido}">
                <g:mostrarSeccion id="${pagina.layout.banner.id}" idioma="${session.idioma.id}"
                                  tipo="Borrador"></g:mostrarSeccion>
            </g:if>
        </div>
    </g:if>
    <g:if test="${pagina.layout.menu}">
        <div class="menu"
             style="position:absolute;top:${pagina.layout.menu.top};left:${pagina.layout.menu.izq};width:${pagina.layout.menu.width};height:${pagina.layout.menu.height}; ${pagina.layout.menu.css}"
             estilo="position:absolute;top:${pagina.layout.menu.top};left:${pagina.layout.menu.izq};width:${pagina.layout.menu.width};height:${pagina.layout.menu.height}; ${pagina.layout.menu.css}">
            <g:mostrarMenuPag tipo="web" actual="${pagina.id}"></g:mostrarMenuPag>
        </div>
    </g:if>

    <g:if test="${pagina.layout.idioma}">
        <div class="idioma"
             style="position:absolute;top:${pagina.layout.idioma.top};left:${pagina.layout.idioma.izq};width:${pagina.layout.idioma.width};height:${pagina.layout.idioma.height}; ${pagina.layout.idioma.css}"
             estilo="position:absolute;top:${pagina.layout.idioma.top};left:${pagina.layout.idioma.izq};width:${pagina.layout.idioma.width};height:${pagina.layout.idioma.height}; ${pagina.layout.idioma.css}">
            <g:mostrarIdiomas tipo="pagina" layout="${pagina?.layout?.id}"
                              pagina="${pagina.id}"/>
        </div>
    </g:if>

    <div class="contendido"
         style="position:absolute;top:${pagina.layout.contenido.top};left:${pagina.layout.contenido.izq};width:${pagina.layout.contenido.width};height:${pagina.layout.contenido.height}; ${pagina.layout.contenido.css}" estilo="position:absolute;top:${pagina.layout.contenido.top};left:${pagina.layout.contenido.izq};width:${pagina.layout.contenido.width};height:${pagina.layout.contenido.height}; ${pagina.layout.contenido.css}">

    </div>
    <g:each in="${pagina.secciones}" var="seccion">
        <g:mostrarSeccion id="${seccion.id}" idioma="${session.idioma.id}" pagina="${pagina.id}" tipo="Borrador"></g:mostrarSeccion>
    </g:each>
</div>


<script type="text/javascript">
    function compatibilidad(){
//        alert(navigator.appName)
        if(navigator.appName == "Microsoft Internet Explorer"){
            $("div").each(function(){

                var stl ="";

                if($(this).attr("style")){

                    var a = ""+ $(this).attr("estilo");
                    if(a.length==0)
                        a=""
                    if(a.match(/rgba/g)){
//                    console.log("entro en el mach")
                        var parts =  $(this).attr("estilo").split(";");
                        //console.log("entro en el split")
                        for(i=0;i<parts.length;i++){
//                        console.log(parts[i])
                            if(parts[i].length>17 && parts[i].substring(0,1)=="b"){
                                var p = parts[i].split(":");
//                            console.log("mayor que 17 "+p[0].substring(0,10))
                                if(p[0].substring(0,10) == "background"){
                                    if(!$(this).attr("estilo").match(/NaN/g)){
                                        stl+=p[0]+":"+"rgb(";
                                        var p2=p[1].split(",");
                                        stl+=p2[0].substring(5,p2[0].length)+","+p2[1]+","+p2[2]+");";
                                    }
//                                console.log(" es bg "+p[0]+"  "+p[1])

                                }else{
                                    stl+=""+p[0]+":"+p[1]+";";
                                }
                            }else{
                                stl+=""+parts[i]+";";
                            }
                        }
                        //console.log($(this))
                        //console.log(stl+" ==>  "+$(this).attr("style"))
                        $(this).attr("style",stl)
                        // $(this).attr("style",stl)

                    }

                }else{
//                console.log("no style")
                }
                //

            });
            //console.log("acabo")
        }

    }
    compatibilidad();
</script>

<g:if test="${pagina.layout.css =~ 'center'}">
    <script type="text/javascript">


        $(function () {


            var pantalla = $(document).width();

            var banner = ${pagina?.layout?.banner?.width};
            var menu = ${pagina?.layout?.menu?.width};
            var contenido = ${pagina?.layout?.contenido?.width};

            var max = Math.max(banner, menu, contenido);

            var margen = (pantalla - max) / 2;

            //console.log($("body").children().first().children("div"));


            $("body").children().first().children("div").css("left", parseInt(margen));




            //console.log(pantalla + " " + banner + " " + menu + " " + contenido + " ----- " + max + "   >>>  " + margen);
        });
    </script>
</g:if>
</body>
</html>
