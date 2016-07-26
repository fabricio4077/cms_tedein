package nth
import nth.Foto

class GaleriasTagLib {

    static namespace = "gl"

    def renderGal = { params ->

//        println "mostrando galeria con layout: " + params.galeria.layout

        switch (params.galeria.layout) {
            case "galleryView":
                out << gl.galleryView(params)
                break;
            case "cloudCarousel":
                out << gl.cloudCarousel(params)
                break;
            case "jCycle":
                out << gl.jCycle(params)
                break;
            case "squares":
                out << gl.squares(params)
                break;
            case "awkward":
                out << gl.awkward(params)
                break;
        }
    } //renderGal

    def awkward = { params ->
        def gal = params.galeria

//        println "awkward de la galeria " + gal
//        println params

        def includes, css, html, js

        def w = params.remove("thumbWidth")
        def h = params.remove("thumbHeight")
        def caption = params.remove("thumbCaption")
        caption = (caption == "on")

        def panelWidth = 0
        def panelHeight = 0

        def conf = [
                content_width: 450,
                content_height: 450,
                fit_to_parent: false,
                auto: true,
                interval: 3000,
                continuous: true,
                loading: true,
                tooltip_width: 200,
                tooltip_icon_width: 32,
                tooltip_icon_height: 32,
                tooltip_offsetx: 18,
                tooltip_offsety: 0,
                arrows: true,
                buttons: false,
                btn_numbers: true,
                keybord_keys: true,
                mousetrace: false, /* Trace x and y coordinates for the mouse */
                pauseonover: true,
                stoponclick: false,
                transition: "'fade'", /* hslide/vslide/fade */
                transition_delay: 0,
                transition_speed: 500,
                show_caption: false, /* onload/onhover/show */
                thumbnails: true,
                thumbnails_position: "'outside-last'", /* outside-last/outside-first/inside-last/inside-first */
                thumbnails_direction: "'horizontal'", /* vertical/horizontal */
                thumbnails_slidex: 1, /* 0 = auto / 1 = slide one thumbnail / 2 = slide two thumbnails / etc. */
                dynamic_height: true, /* For dynamic height to work in webkit you need to set the width and height of images in the source. Usually works to only set the dimension of the first slide in the showcase. */
                speed_change: true, /* Set to true to prevent users from swithing more then one slide at once. */
                viewline: false, /* If set to true content_width, thumbnails, transition and dynamic_height will be disabled. As for dynamic height you need to set the width and height of images in the source. */
                custom_function: null /* Define a custom function that runs on content change */
        ]

        params.each {
            if (conf[it.key] != null) {
                try {
//                    if (it.key == "transition_interval" && (it.value).toInteger() < 1000) {
//                        conf[it.key] = (it.value).toInteger() * 1000
//                    } else if ((it.key).contains("opacity") && (it.value).toInteger() > 1) {
//                        conf[it.key] = (it.value).toInteger() / 100
//                    } else {
                    conf[it.key] = (it.value).toInteger()
//                    }

                } catch (e) {
                    if (it.value == "true" || it.value == "false") {
                        conf[it.key] = it.value
                    } else {
                        conf[it.key] = "'" + it.value + "'"
                    }
                }
            }
        }
/*
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/awkward-showcase', file: 'jquery.aw-showcase.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins/awkward-showcase/css', file: 'style.css')}" rel="stylesheet" type="text/css"/>
*/

        includes = '<script type="text/javascript" src="' + g.resource(dir: 'js/jquery/plugins/awkward-showcase', file: 'jquery.aw-showcase.js') + '"></script>' + "\n"
        includes += '<link rel="stylesheet" type="text/css" href="' + g.resource(dir: 'js/jquery/plugins/awkward-showcase/css', file: 'style.css') + '" />' + "\n"

        def paginas = (Pagina.findAllByGaleria(gal, [sort: "id"]))
        def hh = paginas.size() > 0 ? paginas[0].layout.contenido.height : false
        def shh = hh ? "style='height:" + hh + "px;'" : ""
//        println "*****************************************************" + hh + "    " + shh

        css = '<style type="text/css">' + "\n"
        css += '</style>' + "\n"

        html = '<div id="showcase_' + gal.id + '" class="showcase" ' + shh + ' >'
        (Foto.findAllByGaleria(gal, [sort: "id"])).each { foto ->
            def titulo = foto.frases.find { it.tipo == "Titulo" }
            def descrp = foto.frases.find { it.tipo == "Descripcion" }

            html += '<div class="showcase-slide" ' + shh + '>'

            html += '<div class="showcase-content" ' + shh + '>'
            html += ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: false]), "alt": titulo, "title": titulo, "width": conf.content_width]) + "\n"
            html += '</div>' //showcase-content

            html += '<div class="showcase-thumbnail" style="width: ' + w + 'px; height: ' + h + 'px;">'
            html += ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: false]), "alt": titulo, "title": titulo, "width": w, "height": h]) + "\n"

            if (caption) {
                html += '<div class="showcase-thumbnail-caption">'
                html += titulo
                html += '</div>' //showcase-thumbnail-caption
            }
            html += '</div>' //showcase-thumbnail

            html += '<div class="showcase-caption">'
            html += descrp
            html += '</div>' //showcase-caption

            html += '</div>' //showcase-slide

        }
        paginas.each { pagina ->
            def thumb = ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: pagina?.foto?.id, params: [thumbnail: false]), "alt": "", "title": "", "width": w, "height": h]) + "\n"
//            println "\t" + pagina.layout.contenido.height
            html += '<div class="showcase-slide" ' + shh + '>'

            html += '<div class="showcase-content" ' + shh + '>'
            (pagina.secciones).each { seccion ->
                html += g.mostrarSeccion(tipo: "Borrador", idioma: 0, id: seccion.id)
            }
            html += '</div>' //showcase-content

            html += '<div class="showcase-thumbnail" style="width: ' + w + 'px; height: ' + h + 'px;">'
            html += thumb

            if (caption) {
                html += '<div class="showcase-thumbnail-caption">'
                html += pagina.nombre
                html += '</div>' //showcase-thumbnail-caption
            }
            html += '</div>' //showcase-thumbnail

            html += '</div>' //showcase-slide


            if (pagina.layout.contenido.width > panelWidth) {
                panelWidth = pagina.layout.contenido.width
            }
            if (pagina.layout.contenido.height > panelHeight) {
                panelHeight = pagina.layout.contenido.height
            }

        } //paginas.each
        html += '</div>' //showcase

        println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>W+H:" + panelHeight + " " + panelWidth

        def props = ""
        conf.eachWithIndex { obj, i ->
            if (panelWidth > 0 && panelHeight > 0) {
                if (obj.key == "content_width") {
                    props += "" + obj.key + ":" + panelWidth
                } else if (obj.key == "content_height") {
                    props += "" + obj.key + ":" + panelHeight
                } else {
                    props += "" + obj.key + ":" + obj.value
                }
            } else {
                props += "" + obj.key + ":" + obj.value
            }

            if (i < conf.size() - 1) {
                props += ","
            }
            props += "\n"
        }

        js = '<script type="text/javascript">' + "\n"
        js += '$("#showcase_' + gal.id + '").awShowcase({' + "\n"
        js += props
        js += '});' + "\n"
        if (hh) {
            js += "\n" + '$(".showcase-content,.showcase-content-container").height(' + hh + ');'
        }
        js += "</script>"


        out << includes + "\n"
        out << css + "\n"
        out << html + "\n"
        out << js + "\n"
    }

    def squares = { params ->

//        println "SQUARES"
//        println params

        def gal = params.galeria
        def fotos = Foto.findAllByGaleria(gal, [sort: "id"])

        def includes, css, html, js

        def maxX = (params.maxX) ? (params.remove("maxX")).toInteger() : 3;
        def maxY = (params.maxY) ? (params.remove("maxY")).toInteger() : 0;
        if (maxY <= 0) {
            if (fotos.size() % maxX == 0) {
                maxY = fotos.size() / maxX
            } else {
                maxY = Math.ceil(fotos.size() / maxX)
            }
        }

        def tableBorder = (params.border) ? " border='" + params.remove("border") + "'" : ""
        def space = (params.cellspacing) ? " cellspacing='" + params.remove("cellspacing") + "'" : ""
        def pad = (params.cellpadding) ? " cellpadding='" + params.remove("cellpadding") + "'" : ""

        def cont = 0
        def tableCss = "", cellCss = ""

        params.findAll { it.key =~ 'table-' }.each {
            def k = (it.key).replaceAll("table-", "")
            if (it.value != "" && it.value != -1 && it.value != "-1") {
                tableCss += k + ":" + it.value + "; "
            }
        }
        params.findAll { it.key =~ 'cell-' }.each {
            def k = (it.key).replaceAll("cell-", "")
            if (it.value != "" && it.value != -1 && it.value != "-1") {
                cellCss += k + ":" + it.value + "; "
            }
        }
        params.findAll { it.key =~ 'desc-' }.each {
            def k = (it.key).replaceAll("desc-", "")
            if (it.value != "" && it.value != -1 && it.value != "-1") {
                cellCss += k + ":" + it.value + "; "
            }
        }

        html = ""
        html += '<table ' + tableBorder + space + pad + ' style="' + tableCss + '">'

        maxY.times {
            html += '<tr>'
            maxX.times {
                if (cont < fotos.size()) {
                    def foto = fotos[cont]
                    def titulo = foto.frases.find { it.tipo == "Titulo" }
                    def descrp = foto.frases.find { it.tipo == "Descripcion" }
                    cont++
                    html += '<td style="' + cellCss + '">'
                    html += ig.img(["class": "linkFotoLight", "src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: true]), "big": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: false]), "alt": titulo, "title": descrp]) + "\n"
//                    html += ig.img(["class": "linkFotoLight", "src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id), "alt": foto?.caption, "title": foto?.caption, "thumbnailSrc": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: true])])
                    if (params.info == "title") {
                        html += "<div style='width:" + foto.width + "px;'>"
                        html += titulo
                        html += "</div>"
                    } else if (params.info == "desc") {
                        html += "<div style='width:" + foto.width + "px;'>"
                        html += descrp
                        html += "</div>"
                    }
                    html += '</td>'
                }
            }
            html += '</tr>'
        }

        html += '</table>'

        js = ''
        js += '<script>'
        js += '$(function() {'
        /** *********prettyPhoto  ***********/
        js += '$.fn.prettyPhoto();'
        js += '$(".linkFotoLight").click(function() {'
        js += '$.prettyPhoto.open($(this).attr("big"),$(this).attr("alt") , $(this).attr("title"));'
        js += '});'
        /** *********prettyPhoto  ***********/
        js += '});'
        js += '</script>'

//        out << includes
        out << html
        out << js
    }

    /*
  map "\n"indX:"\n"ind X,"\n"indY:"\n"ind Y,"\n"indZ:"\n"ind Z,cover:Cover,curtainX:Curtain X,curtainY:Curtain Y,fade:Fade,fadeZoom:Fade Zoom,growX:Grow X,growY:Grow Y,scrollUp:Scroll Up,scrollDown:Scroll Down,scrollLeft:Scroll Left,scrollRight:Scroll Right,scrollHorz:Scroll X,scrollVert:Scroll Y,shuffle:Shuffle,slideX:Slide X,slideY:Slide Y,toss:Toss,turnUp:Turn Up,turnDown:Turn Down,turnLeft:Turn Left,turnRight:Turn Right,uncover:Uncover,wipe:Wipe,zoom:Zoom
    */

    def jCycle = { params ->

//        println params

        def gal = params.galeria

        def includes, css, html, js

        def nav = params.remove("nav")
        def pager = params.remove("pager")

        def info = params.remove("info")

        def w = params.remove("width")
        def h = params.remove("height")
        def width = (w?.toInteger() > 0) ? ("width:" + w + "px;") : ("")
        def height = (h?.toInteger() > 0) ? ("height:" + h + "px;") : ("")

        def background = params.remove("background")
        def color = params.remove("font_color")
        def font = params.remove("font")

        def conf = [
                fx: "'scrollLeft'",
                timeout: 5000,
                delay: -2000,
                pause: 1,
                random: 1,
                sync: 0,
                next: "'#next2'",
                prev: "'#prev2'",
                pager: "'#nav'"
        ]

        params.each {
            if (conf[it.key] != null) {
                try {
                    if (it.key == "timeout" || it.key == "delay" && (it.value).toInteger() < 1000) {
                        conf[it.key] = (it.value).toInteger() * 1000
                    } else {
                        conf[it.key] = (it.value).toInteger()
                    }
                } catch (e) {
                    if (it.value == "true" || it.value == "false") {
                        conf[it.key] = it.value
                    } else if (it.value == 'on') {
                        conf[it.key] = true
                    } else {
                        conf[it.key] = "'" + it.value + "'"
                    }
                }
            }
        }

        includes = '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.timers-1.2.js") + '"></script>' + "\n"
        includes += '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.easing.1.3.js") + '"></script>' + "\n"
        includes += '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins", file: "jquery.cycle.all.js") + '"></script>' + "\n"

        css = '<style type="text/css">' + "\n"
        css += '#nav a { border: 1px solid #ccc; background: #fc0; text-decoration: none; margin: 0 5px; padding: 3px 5px;  }'
        css += '#nav a.activeSlide { background: #ea0 }'
        css += '#nav a:focus { outline: none; }'
        css += '</style>' + "\n"

        html = ""

        /*
        if (pager == "true" || pager == true || pager == "on") {
            html += '<div class="nav" id="nav"></div>'
        }
        if (nav == "true" || nav == true || nav == "on") {
            html += '<div class="nav">'
            html += '<a href="#" id="prev2">Prev</a>'
            html += '<a href="#" id="next2">Next</a>'
            html += '</div>'
        }
        */

        html += '<ul id="jc">' + "\n"
        (Foto.findAllByGaleria(gal, [sort: "id"])).eachWithIndex { foto, i ->
            def titulo = foto.frases.find { it.tipo == "Titulo" }
            def descrp = foto.frases.find { it.tipo == "Descripcion" }


            html += '<li>' + "\n"
            html += ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: false]), "alt": titulo, "title": titulo, "style": width + height]) + "\n"
            html += '<div class="gv-panel-overlay ui-corner-all" style="padding:3px; background:' + background + '; color:' + color + '; font-family:' + font + '">' + "\n"
            if (info == "true" || info == true || info == "on") {
                html += '<div class="gv-title">' + titulo.toString() + '</div>' + "\n"
                html += descrp.toString() + "\n"
                html += '</div>' + "\n"
            }
            html += '</li>' + "\n"
        }
        html += '</ul>' + "\n"

        js = '<script type="text/javascript">' + "\n"
        js += '$(document).ready(function() {' + "\n"

        js += '$("#jc").cycle({' + "\n"

        def props = ""
        conf.eachWithIndex {
            obj, i ->
                props += "" + obj.key + ":" + obj.value
                if (i < conf.size() - 1) {
                    props += ","
                }
                props += "\n"
        }
        js += props

        js += '});' + "\n"
        js += '});' + "\n"
        js += '</script>'

//        println js

        out << includes + "\n"
        out << css + "\n"
        out << html + "\n"
        out << js + "\n"

    } //jCycle

    def cloudCarousel = { params ->
        def gal = params.galeria

        def includes, css, html, js

        def altBox = params.remove("altBox")
        def titleBox = params.remove("titleBox")

        def flechas = params.remove("navigation")

        def background = params.remove("background")
        def desc_background = params.remove("desc_background")
        def font_color = params.remove("font_color")

        def mw, mh

        def conf = [
                maxW: 800,
                maxH: 800,
                reflHeight: 0,
                reflOpacity: 0.5,
                reflGap: 0,
                minScale: 0.5,
                xPos: 0,
                yPos: 0,
                xRadius: 0,
                yRadius: 0,
                altBox: null,
                titleBox: null,
                FPS: 30,
                autoRotate: "'no'",
                autoRotateDelay: 1500,
                speed: 0.2,
                mouseWheel: false,
                bringToFront: false,

                buttonLeft: '$("#left-but")',
                buttonRight: '$("#right-but")',
                altBox: '$("#alt-text")',
                titleBox: '$("#title-text")'
        ]

        params.each {
            if (conf[it.key] != null) {
                try {
                    if (it.key == "autoRotateDelay" && (it.value).toInteger() < 1000) {
                        conf[it.key] = (it.value).toInteger() * 1000
                    } else if (it.key == "reflOpacity" && (it.value).toInteger() > 1 ||
                            it.key == "minScale" && (it.value).toInteger() > 1 ||
                            it.key == "speed" && (it.value).toInteger() > 1) {
                        conf[it.key] = (it.value).toInteger() / 100
                    } else {
                        conf[it.key] = (it.value).toInteger()
                    }
                } catch (e) {
                    if (it.value == "true" || it.value == "false") {
                        conf[it.key] = it.value
                    } else if (it.value == 'on') {
                        conf[it.key] = true
                    } else {
                        conf[it.key] = "'" + it.value + "'"
                    }
                }
            }
        }

        mw = (conf.maxW * 2) + 50
        mh = conf.maxH + conf.reflHeight + 80

        includes = '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.timers-1.2.js") + '"></script>' + "\n"
        includes += '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/cloud-carousel", file: "cloud-carousel.1.0.5.js") + '"></script>' + "\n"

        css = '<style type="text/css">' + "\n"
        css += '.gv-title {' + "\n"
        css += 'font-size     : 16px;' + "\n"
        css += 'font-weight   : bold;' + "\n"
        css += 'margin-bottom : 5px;' + "\n"
        css += '}' + "\n"
        css += '</style>' + "\n"


        html = ""
        // This is the container for the carousel.
        html += '<div id="carousel1" class="ui-corner-all" style="width:' + mw + 'px; height:' + mh + 'px;background:' + background + ';overflow:scroll;position:relative;">' + "\n"
        // All images with class of "cloudcarousel" will be turned into carousel items
        // You can place links around these images
        (Foto.findAllByGaleria(gal, [sort: "id"])).eachWithIndex { foto, i ->
            def titulo = foto.frases.find { it.tipo == "Titulo" }
            def descrp = foto.frases.find { it.tipo == "Descripcion" }

            if (i == 0) {
                html += ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: false]), "alt": descrp, "title": titulo, "class": "cloudcarousel front"]) + "\n"
            } else {
                html += ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: false]), "alt": descrp, "title": titulo, "class": "cloudcarousel"]) + "\n"
            }
        }

        if (flechas == "true" || flechas == true || flechas == "on") {
            // Define left and right buttons.
            html += '<a href="#" id="left-but" style="position:absolute; left: 0; bottom: 0;">Anterior</a>' + "\n"
            html += '<a href="#" id="right-but" style="position:absolute; right: 0; bottom: 0;">Siguiente</a>' + "\n"
        }

        html += '</div>' + "\n"

        if (altBox == "true" || altBox == true || altBox == "on" || titleBox == "true" || titleBox == true || titleBox == "on") {
            html += '<div class="ui-corner-all" style="width:' + (mw - 5) + 'px; padding:5px; background:' + desc_background + '; color:' + font_color + ';">' + "\n"
            // Define elements to accept the alt and title text from the images.
            if (titleBox == "true" || titleBox == true || titleBox == "on") {
                html += '<div class="gv-title" id="title-text"></div>' + "\n"
            } else {
                conf.titleBox = "null"
            }
            if (altBox == "true" || altBox == true || altBox == "on") {
                html += '<p id="alt-text"></p>' + "\n"
            } else {
                conf.altBox = "null"
            }
            html += '</div>' + "\n"
        }

        js = '<script type="text/javascript">' + "\n"
        js += '$(document).ready(function() {' + "\n"

        js += '$("#left-but").button({' + "\n"
        js += 'icons: {' + "\n"
        js += 'primary: "ui-icon-triangle-1-w"' + "\n"
        js += '},' + "\n"
        js += 'text: false' + "\n"
        js += '}).click(function() {' + "\n"
        js += 'return false;' + "\n"
        js += '});' + "\n"
        js += '$("#right-but").button({' + "\n"
        js += 'icons: {' + "\n"
        js += 'secondary: "ui-icon-triangle-1-e"' + "\n"
        js += '},' + "\n"
        js += 'text: false' + "\n"
        js += '}).click(function() {' + "\n"
        js += 'return false;' + "\n"
        js += '});' + "\n"

        js += '$(".cloudcarousel").click(function() {' + "\n"
        js += 'if ($(this).hasClass("front")) {' + "\n"
//        js += 'console.log($(this).attr("src"));' + "\n"
        js += '}' + "\n"
        js += '});' + "\n"

        // This initialises carousels on the container elements specified, in this case, carousel1.
        js += '$("#carousel1").CloudCarousel({' + "\n"
        def props = ""
        conf.eachWithIndex { obj, i ->
            props += "" + obj.key + ":" + obj.value
            if (i < conf.size() - 1) {
                props += ","
            }
            props += "\n"
        }
        js += props
        js += '});' + "\n"
        js += '});' + "\n"

        js += '</script>'

        out << includes + "\n"
        out << css + "\n"
        out << html + "\n"
        out << js + "\n"

    } //cloudCarousel

    def galleryView = { params ->
        def gal = params.galeria
//        println "galleryView de la galeria " + gal
        def includes, css, html, js
        def background = params.remove("background")
        def borderWidth = params.remove("border-width")
        def borderColor = params.remove("border-color")
        def borderStyle = params.remove("border-style")
        def h = params.remove("infoH")
        try {
            h = h.toInteger()
        } catch (e) {
            h = 50
        }
        def panelWidth = 0
        def panelHeight = 0
        def conf = [
                panel_width: 300,
                panel_height: 300,
                frame_width: 60,
                frame_height: 60,
                pause_on_hover: true,
                panel_scale: "'nocrop'",
                frame_scale: "'crop'",
                show_overlays: true,
                panel_animation: "'slide'",
                pointer_size: 15,
                transition_interval: 2000,
                filmstrip_position: "'bottom'",
//                panel_animation: "'crossfade'",
                overlay_position: "'bottom'",
                frame_gap: 10,
                overlay_opacity: 0.8,
                frame_opacity: 0.3,
                show_filmstrip: true,
                show_panel_nav: true,
                show_filmstrip_nav: true,
                show_captions: true
        ]

        params.each {
            if (conf[it.key] != null) {
                try {
                    if (it.key == "transition_interval" && (it.value).toInteger() < 1000) {
                        conf[it.key] = (it.value).toInteger() * 1000
                    } else if ((it.key).contains("opacity") && (it.value).toInteger() > 1) {
                        conf[it.key] = (it.value).toInteger() / 100
                    } else {
                        conf[it.key] = (it.value).toInteger()
                    }

                } catch (e) {
                    if (it.value == "true" || it.value == "false") {
                        conf[it.key] = it.value
                    } else {
                        conf[it.key] = "'" + it.value + "'"
                    }
                }
            }
        }

        includes = '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.easing.1.3.js") + '"></script>' + "\n"
        includes += '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.galleryview-3.0.js") + '"></script>' + "\n"
        includes += '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/galleryview/js", file: "jquery.timers-1.2.js") + '"></script>' + "\n"
        includes += '<link href="' + g.resource(dir: "js/jquery/plugins/galleryview/css", file: "jquery.galleryview-3.0.css") + '" rel="stylesheet" type="text/css"/>' + "\n"

//        includes = '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/GalleryView-new/js", file: "jquery.easing.1.3.js") + '"></script>' + "\n"
//        includes += '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/GalleryView-new/js", file: "jquery.galleryview-3.0-dev.js") + '"></script>' + "\n"
//        includes += '<script type="text/javascript" src="' + g.resource(dir: "js/jquery/plugins/GalleryView-new/js", file: "jquery.timers-1.2.js") + '"></script>' + "\n"
//        includes += '<link href="' + g.resource(dir: "js/jquery/plugins/GalleryView-new/css", file: "jquery.galleryview-3.0-dev.css") + '" rel="stylesheet" type="text/css"/>' + "\n"

        css = '<style type="text/css">' + "\n"
        css += '.gv-title {' + "\n"
        css += 'font-size     : 16px;' + "\n"
        css += 'font-weight   : bold;' + "\n"
        css += 'margin-bottom : 5px;' + "\n"
        css += '}' + "\n"
        css += '</style>' + "\n"

        html = ""
        html += '<ul id="myGallery">' + "\n"
        (Foto.findAllByGaleria(gal, [sort: "id"])).each { foto ->

            def titulo = foto.frases.find { it.tipo == "Titulo" }
            def descrp = foto.frases.find { it.tipo == "Descripcion" }

            html += '<li>' + "\n"
            html += ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: foto?.id, params: [thumbnail: false]), "alt": titulo, "title": titulo]) + "\n"
            html += '<div class="gv-panel-overlay">' + "\n"
            html += '<div class="gv-title">' + titulo + '</div>' + "\n"
            html += descrp.toString() + "\n"
            html += '</div>' + "\n"
            html += '</li>' + "\n"
        }
        (Pagina.findAllByGaleria(gal, [sort: "id"])).each { pagina ->
            html += '<li>'

            html += ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: pagina?.foto?.id, params: [thumbnail: false]), "alt": "", "title": ""]) + "\n"

            html += '<div id="pagina_' + pagina.id + '" class="gv-panel-content" style="width:' + pagina.layout.contenido.width + 'px; height:' + pagina.layout.contenido.height + 'px; position:relative;">'
            (pagina.secciones).each { seccion ->
                html += g.mostrarSeccion(tipo: "Borrador", idioma: 0, id: seccion.id)
            }
            html += '</div>'
            html += '</li>'

            if (pagina.layout.contenido.width > panelWidth) {
                panelWidth = pagina.layout.contenido.width
            }
            if (pagina.layout.contenido.height > panelHeight) {
                panelHeight = pagina.layout.contenido.height
            }
        }

        html += '</ul>' + "\n"

        js = '<script type="text/javascript">' + "\n"
        js += '$(document).ready(function() {' + "\n"
        js += "setTimeout(function(){ "
        js += '$("#myGallery").galleryView({' + "\n"
        def props = ""

        conf.eachWithIndex { obj, i ->
            if (panelWidth > 0 && panelHeight > 0) {
                if (obj.key == "panel_width") {
                    props += "" + obj.key + ":" + panelWidth
                } else if (obj.key == "panel_height") {
                    props += "" + obj.key + ":" + panelHeight
                } else {
                    props += "" + obj.key + ":" + obj.value
                }
            } else {
                props += "" + obj.key + ":" + obj.value
            }

            if (i < conf.size() - 1) {
                props += ","
            }
            props += "\n"
        }

        js += props
        js += '});' + "\n"

//        if (background.is(true) || background == "true" || background == "on") {
        //            js += '$(".gv-panel_wrap").addClass("ui-widget-content ui-corner-all");' + "\n"
        //        } else {
        //            js += '$(".gv-panel_wrap").addClass("ui-corner-all");' + "\n"
        //        }

        js += '$(".gv-panel_wrap").addClass("ui-corner-all").css("background", "' + background + '");' + "\n"

        def b = 2

        if (borderWidth.toDouble() > 0) {
            def col = (borderColor?.size() > 0) ? borderColor : "black"
            def sty = (borderStyle) ? borderStyle : "solid"

            js += '$(".gv-panel_wrap").css({' + "\n"
            js += 'border: "' + sty + ' ' + borderWidth + 'px ' + col + '"' + "\n"
            js += '});' + "\n"

            b += (borderWidth.toDouble() * 2);

            js += 'var alto = parseInt($(".gv-gallery").height());' + "\n"
            js += '$(".gv-gallery").height(alto+' + b + ');' + "\n"
        }

        js += '$(".gv-panel-overlay").height(' + h + ');' + "\n"
        js += '$(".gv-overlay-background").height(' + h + ');' + "\n"
        js += 'var w = parseInt($(".gv-gallery").width());' + "\n"
        js += '$(".gv-gallery").width(w+' + b + ');' + "\n"

//        js+='$("#myGallery").css("visibility", "visible");'
//        js+='$("#myGallery").show();'
//        js+='$(".gv-loader").hide();'
        js += "}, 500);"
        js += '});' + "\n"
        js += '</script>' + "\n"

//        println js

        out << includes + "\n"
        out << css + "\n"
        out << html + "\n"
        out << js + "\n"
    } //galleryView

}
