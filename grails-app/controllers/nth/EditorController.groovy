package nth

import nth.seguridad.Shield

class EditorController extends Shield {

    def index = {
        if (!session.idioma)
            session.idioma = Idioma.findByAbreviacion("es")
        if (!session.sitio)
            redirect(action: "sitios")
    }

    def uploader = {

    }

    def sitios = {
        def sitios = []
        println "sitios " + session.usuario.sitio
        if (session.usuario.sitio)
            sitios = session.usuario.sitio
        else
            sitios = Sitio.list()

        def prc = ["0": "No", "1": "Si"]
        [prc: prc, sitios: sitios]
    }

    def saveSitio = {
        def sitio = new Sitio(params)
        if (sitio.save(flush: true)) {
            session.sitio = sitio
            println "steando sitio save" + session.sitio

            redirect(action: "index")
        } else {
            render(view: "sitios", model: [sitioInstance: sitio])
        }

    }

    def setSitio = {
        session.sitio = Sitio.get(params.sitio)
        println "seteando sitio " + session.sitio
        if (session.sitio)
            render "ok"
        else
            render "no"
    }

    def empty = {}

    def upload = {
        def downloadedfile = request.getFile('file');
        downloadedfile.transferTo(new File('prueba.jpeg'))
    }

    def submenu = {
        def tipo = params.tipo
        def lista = []
        def alto = '320px' /*'280px'*/
        def linkNuevo
        def submenus = [:]

        switch (tipo) {
            case "pagina":
                linkNuevo = '<a href="' + createLink(controller: 'editor', action: 'nuevaPagina') + '" class="boton new" target="contenido">Crear nueva</a>'

                def c = Pagina.createCriteria()
                def pags = c.list {
                    and {
                        eq("sitio", session.sitio)
                        or {
                            isNull("tipoPagina")
                            eq("tipoPagina", TipoPagina.get(1))
                        }
                    }
                    and {
                        order("nombre", "asc")
                    }
                }

                //(Pagina.findAllBySitio(session.sitio, [sort: "nombre"]))
                pags.each {
                    def m = [:]
                    m.nombre = it.nombre
                    m.id = 'btn_pag_' + it.id
                    m.link = createLink(controller: 'editor', action: 'editarPagina', params: ['id': it.id, 'add': false])
                    m.target = "contenido"
                    m.clase = ""
                    lista.add(m)
                }
                break;
            case "galeria":
                def gal = new Galeria()
                (gal.constraints.tipo.inList).each {

                    def sm = [:]
                    def listaGal = []

                    (Galeria.findAllByTipoAndSitio(it, session.sitio)).each { item ->
                        def accion

                        if (it == "Fotos") {
                            accion = "addPhotos"
                        } else if (it == "Texto") {
                            accion = "addCont"
                        }

                        def n = [:]
                        n.nombre = item.nombre
                        n.id = 'btn_gal_' + item.id
                        n.link = createLink(controller: 'editorGalerias', action: accion, params: ['id': item.id, 'add': false])
                        n.target = "contenido"
                        n.clase = ""
                        listaGal.add(n)
                    }

                    sm.lista = listaGal
                    sm.linkNuevo = '<a href="' + createLink(controller: 'editorGalerias', action: 'nuevaGaleria', params: [tipo: it]) + '" class="boton new" target="contenido">Crear nueva</a>'

                    submenus[it] = sm

                    def m = [:]
                    m.nombre = it + '  (<span id="cant_' + it + '">' + sm.lista.size() + "</span>)"
                    m.link = ""
                    m.target = ""
                    m.toggle = it
                    m.clase = "noLink"
                    lista.add(m)
                }
                break;
            case "publicacion":
                linkNuevo = '<a href="' + createLink(controller: 'editorPublicaciones', action: 'nuevoTipo') + '" class="boton new" target="contenido">Crear nueva</a>'

                def sitio = session.sitio


                (TipoPagina.findAllBySitio(sitio, [sort: "nombre"])).each {

                    def sm = [:]
                    def listaPag = []

                    (Pagina.findAllByTipoPagina(it)).each { item ->
                        def accion = "add"

                        def n = [:]
                        n.nombre = item.nombre
                        n.id = 'btn_pag_' + item.id
                        n.link = createLink(controller: 'editorPublicaciones', action: 'editarPagina', params: ['id': item.id, 'add': false])
                        n.target = "contenido"
                        n.clase = ""
                        listaPag.add(n)
                    }

                    sm.lista = listaPag
                    sm.linkNuevo = '<a href="' + createLink(controller: 'editorPublicaciones', action: 'preEditarPagina', params: [tipo: it.id]) + '" class="boton new" target="contenido">Crear nuevo</a>'

                    submenus[it] = sm

                    def m = [:]
                    m.nombre = it.nombre + '  (<span id="cant_' + it.nombre + '">' + sm.lista.size() + "</span>)"
                    m.id = 'btn_tipo_' + it.id
                    m.link = createLink(controller: 'editor', action: 'editarPagina', params: ['id': it.pagina.id, 'add': false])
                    m.target = "contenido"
                    m.toggle = it.nombre
                    m.clase = "noLink"
                    lista.add(m)
                }
                break;
            case "layout":
                linkNuevo = '<a href="' + createLink(controller: 'editor', action: 'nuevaPagina') + '" class="boton new" target="contenido">Crear nuevo</a>'

                def sitio = session.sitio
                if (!sitio) {
                    redirect(action: "sitios")
                }

                //(Layout.findAllBySitio(sitio, [sort: "nombre"])).each {
                (Layout.findAllBySitio(session.sitio, [sort: "nombre"])).each {
                    def m = [:]
                    m.nombre = it.nombre
                    m.id = 'btn_layout_' + it.id
                    m.link = createLink(controller: 'editor', action: 'nuevaPagina', params: ['id': it.id, 'add': false])
                    m.target = "contenido"
                    m.clase = ""
                    lista.add(m)
                }
                break;
            case "idioma":
                linkNuevo = '<a href="' + createLink(controller: 'idioma', action: 'nuevoIdioma') + '" class="boton new" target="contenido">Crear nuevo</a>'
                (Idioma.list([sort: "nombre"])).each {
                    def m = [:]
                    m.nombre = it.nombre
                    m.id = 'btn_idioma_' + it.id
                    m.link = createLink(controller: 'idioma', action: 'nuevoIdioma', params: ['id': it.id, 'add': false])
                    m.target = "contenido"
                    m.clase = ""
                    lista.add(m)
                }
                break;

        }

        return [lista: lista, linkNuevo: linkNuevo, submenus: submenus]
    }

    def menuPagina = {
        def paginas = Pagina.list([sort: "nombre"])
        [paginas: paginas]
    }

    def saveBgImg = {
        def cal = Calendar.instance
        def Y = cal.get(Calendar.YEAR)
        def M = cal.get(Calendar.MONTH) + 1
        def D = cal.get(Calendar.DATE)
        def h = cal.get(Calendar.HOUR_OF_DAY)
        def m = cal.get(Calendar.MINUTE)
        def s = cal.get(Calendar.SECOND)

        def date = D + "-" + M + "-" + Y + "_" + h + ":" + m + ":" + s

        def seccion = Seccion.get(params.id)

        def nop = ["layout", "action", "controller"]
        def css = ""

        def sitio = session.sitio
        def nombreSitio = sitio.nombre

        def dir = servletContext.getRealPath("/") + "images/Sitios"   //web-app/archivos
//        def dir = grailsApplication.config.images.location.toString() + "Sitios"
        def file = dir + File.separatorChar + nombreSitio + "_" + date

        def f = request.getFile('background-url')
        params.remove('background-url')
        if (!f.empty) {
            println "image bg"
            def filename = f.getOriginalFilename()
            def parts = filename.split("\\.")
            def ext = parts[parts.size() - 1]
            file += "." + ext
            println 'Your file has been uploaded to ' + file
            new File(dir).mkdirs()
            f.transferTo(new File(file))

//            params["background-image"] = "url(" + resource(dir: "images/Sitios", file: nombreSitio + "_" + date + "." + ext) + ")"
            params["background-image"] = "url(" + "/images" + File.separatorChar + "Sitios" + File.separatorChar + nombreSitio + "_" + date + "." + ext + ")"
        }
        else {
            nop.add("background-url")
            println 'file is empty'
        }

        def r = "", g = "", b = "", a = "";

        params.eachWithIndex { param ->
            if (!nop.contains(param.key)) {
                if (param.key == "background-alpha") {
                    if (param.value == "-1") {
                        a = 1;
                    } else {
                        a = param.value.toInteger() / 100;
                    }
                } else {
                    if (!param.key.contains("invi") && param.value != "" && param.value != "-1") {
                        if (param.key == "background-color") {
                            r = (Integer.parseInt(param.value[1..2], 16)).toString().padLeft(2, '0')
                            g = (Integer.parseInt(param.value[3..4], 16)).toString().padLeft(2, '0')
                            b = (Integer.parseInt(param.value[5..6], 16)).toString().padLeft(2, '0')
                        } else {
                            css += param.key + ":" + param.value + ";"
                        }
                    }
                }
            }
        }
        css += "background-color: rgba(" + r + "," + g + "," + b + "," + a + ");"
//        println "*************************************************************\n\n"

//        println css
        seccion.css = css
        seccion.save(flush: true, failOnError: true)

        redirect(action: "editarPagina", id: params.pid)
    }

    def editarPagina = {
        /* TODO quitar esto del sitio */
        if (!session.idioma)
            session.idioma = Idioma.findByNombre("Español")

        def pagina = Pagina.get(params.id)
        def menu = Frase.findByPaginaAndIdioma(pagina, session.idioma)
        def seccion = new Seccion()
        def props = Propiedades.findAll("from Propiedades where tipo like '%editPag%' order by grupo,orden")
        def orden = []
        20.times {
            orden.add(it + 1)
        }
        [pagina: pagina, seccion: seccion, add: params.add, props: props, orden: orden, menu: menu]
    }

    def guardarMenuPagina = {
//        println "guardar menu pag " + params
        def pagina = Pagina.get(params.id)
        def idioma = Idioma.get(params.idioma)
        def menu = Frase.findByPaginaAndIdioma(pagina, idioma)
        if (!menu) {
            menu = new Frase()
            menu.pagina = pagina
            menu.idioma = idioma
        }
        menu.frase = params.frase
        /* TODO pilas con ese estado */
        menu.estado = "Borrador"
        pagina.orden = params.orden.toInteger()
        menu.save()
        pagina.save()
        println "errores menu " + menu.errors
        render "ok"
    }

    def deletePagina = {
//        println "delete pagina " + params
        def pagina = Pagina.get(params.id)

        def pgs = TipoPagina.findAllByPagina(pagina)
        pgs.each {

        }

        def secciones = Seccion.findAllByPagina(pagina)
        /* TODO aumentar el resto de tipos de secciones*/
        secciones.each {seccion ->
            //println "!!!! tipo " + seccion.tipo + " frases ! " + Frase.findAllBySeccion(seccion)
            seccion?.foto?.frases?.each {
                it.delete()
            }
            seccion?.foto?.delete()
            seccion?.video?.frases?.each {
                it.delete()
            }
            seccion?.video?.delete()
            def frases = Frase.findAllBySeccion(seccion)
            frases.each {
                if (it)
                    it.delete()
            }

            seccion?.delete(flush: true)
        }

        def frases = Frase.findAllByPagina(pagina)
        frases.each {
            it.delete(flush: true)
        }

//        if(pagina.delete(flush:true))
        //            render("ok")
        //        else
        //            render("error")

        pagina.delete(flush: true)
        render "ok"
    }

    def guardarSeccionesPagina = {
//        println "guardarSeccionesPagina  " + params
        def pagina = Pagina.get(params.pagina.id)
        params.secciones.each {
            if (it.value.class == null) {
                ////println "it " + it.value.id + "  class --> " + it.value.class
                def seccion = Seccion.get(it.value.id)
                seccion.top = Math.floor(it.value.top.toDouble())
                seccion.izq = Math.floor(it.value.izq.toDouble())
                if (seccion.tipo != "Foto") {
                    seccion.height = Math.floor(it.value.height.toDouble())
                    seccion.width = Math.floor(it.value.width.toDouble())
                } else {
                    if (seccion.foto) {
                        seccion.height = seccion.foto.height
                        seccion.width = seccion.foto.width
                    } else {
                        seccion.height = Math.floor(it.value.height.toDouble())
                        seccion.width = Math.floor(it.value.width.toDouble())
                    }
                }
                //println "css "+it.value.css+" seccion "+seccion.id
                seccion.css = it.value.css
                seccion.save(flush: true)
                //println "errors " + seccion.errors
            }
        }
        redirect(action: "editarPagina", controller: "editor", params: ["id": pagina.id])
    }

    def seleccionarGaleria = {
//        println params

        def fotos = Galeria.findAllByTipo("Fotos")
        def cont = Galeria.findAllByTipo("Texto")
        def videos = Galeria.findAllByTipo("Videos")

        return [fotos: fotos, cont: cont, videos: videos, id: params.id]
    }

    def guardarSeccionGaleria = {
        def seccion = Seccion.get(params.id)
        def gal = Galeria.get(params.gal)

        seccion.tipo = "Galeria"
        seccion.galeria = gal
        seccion.save(flush: true, failOnError: true)

        /** *******************************************/
        def parms = [:]
        parms.galeria = gal

        def props = gal.propiedades
        def parts = props.split(",")
        parts.each {
            def p = it.split(":")
            if (p.size() == 2) {
                parms[p[0]] = p[1]
            }
        }
        /** *******************************************/

        return [seccion: params.id, parms: parms]
    }

    def loadGaleria = {
//        println params
        def seccion = Seccion.get(params.id)
        def gal = seccion.galeria

        def parms = [:]
        parms.galeria = gal

        def props = gal.propiedades
        def parts = props.split(",")
        parts.each {
            def p = it.split(":")
            if (p.size() == 2) {
                parms[p[0]] = p[1]
            }
        }

        render(gl.renderGal(parms))
    }

    def idioma = {

    }

    def rte = {
        //println "rte " + params
        def seccion = Seccion.get(params.id)
        def idioma = Idioma.get(params.idioma.toInteger());
        def frase = Frase.findBySeccionAndIdioma(seccion, idioma);
        def fraseEsp = null
        if (!frase) {
            frase = new Frase()
            frase.seccion = seccion
            frase.idioma = idioma
            frase.estado = "Borrador"
            frase.save(flush: true)
        }
        def espanol = Idioma.findByNombre("Español")
        if (idioma != espanol) {
            fraseEsp = Frase.findBySeccionAndIdioma(seccion, espanol)
        }
        def pags = []
        def sel = null
        if (params.link == "1" || params.link == 1) {
            def sitio = session.sitio
            pags = Pagina.findAllBySitioAndTipoPaginaIsNull(sitio)

            sel = seccion?.contenido?.id
        }
        [seccion: seccion, frase: frase, pags: pags, sel: sel, fraseEsp: fraseEsp]
    }
    def guardarContenidoFrase = {
        def frase = Frase.get(params.frase)
//        println "frase " + frase + " params " + params + " " + frase.id
        frase.frase = params.contFrase
        frase.save(flush: true)

        if (params.pagLink) {
            def seccion = Seccion.get(params.seccion)
            def link = Pagina.get(params.pagLink)
            seccion.contenido = link
            seccion.save(flush: true, failOnError: true)
        }

        def js = "<script type='text/javascript'>"
        js += "window.close();"
        js += "</script>"
        render js
    }

    def nuevaSeccion = {
//        println "nueva seccion " + params
        def seccion = new Seccion()
        seccion.tipo = params.tipo
        seccion.pagina = Pagina.get(params.pagina)
        seccion.css = params.css
        seccion.top = params.top?.toInteger()
        seccion.izq = params.left?.toInteger()
        seccion.width = params.width?.toInteger()
        seccion.height = params.height?.toInteger()
        seccion.save()

        if (params.tipo == "GuestBook") {
            def es = Idioma.findByAbreviacion("es")
            def fNombre = new Frase()
            fNombre.frase = "Nombre"
            fNombre.idioma = es
            fNombre.estado = "Publicado"
            fNombre.tipo = "gb_Nombre"
            fNombre.orden = 1
            fNombre.tags = "nombre"
            fNombre.seccion = seccion
            fNombre.save(flush: true)

            def fImagen = new Frase()
            fImagen.frase = "Imagen"
            fImagen.idioma = es
            fImagen.estado = "Publicado"
            fImagen.tipo = "gb_Imagen"
            fImagen.orden = 2
            fImagen.tags = "foto"
            fImagen.seccion = seccion
            fImagen.save(flush: true)

            def fComentario = new Frase()
            fComentario.frase = "Comentario"
            fComentario.idioma = es
            fComentario.estado = "Publicado"
            fComentario.tipo = "gb_Comentario"
            fComentario.orden = 3
            fComentario.tags = "texto"
            fComentario.seccion = seccion
            fComentario.save(flush: true)

            def fBotonSave = new Frase()
            fBotonSave.frase = "Guardar"
            fBotonSave.idioma = es
            fBotonSave.estado = "Publicado"
            fBotonSave.tipo = "gb_Boton_Guardar"
            fBotonSave.seccion = seccion
            fBotonSave.save(flush: true)

            def fBotonCancelar = new Frase()
            fBotonCancelar.frase = "Cancelar"
            fBotonCancelar.idioma = es
            fBotonCancelar.estado = "Publicado"
            fBotonCancelar.tipo = "gb_Boton_Cancelar"
            fBotonCancelar.seccion = seccion
            fBotonCancelar.save(flush: true)

            def fTitulo = new Frase()
            fTitulo.frase = "Nuevo comentario"
            fTitulo.idioma = es
            fTitulo.estado = "Publicado"
            fTitulo.tipo = "gb_Titulo"
            fTitulo.seccion = seccion
            fTitulo.save(flush: true)

            def fBotonAgregar = new Frase()
            fBotonAgregar.frase = "Nuevo comentario"
            fBotonAgregar.idioma = es
            fBotonAgregar.estado = "Publicado"
            fBotonAgregar.tipo = "gb_Boton_Agregar"
            fBotonAgregar.seccion = seccion
            fBotonAgregar.save(flush: true)

            def fAnonimo = new Frase()
            fAnonimo.frase = "Anónimo"
            fAnonimo.idioma = es
            fAnonimo.estado = "Publicado"
            fAnonimo.tipo = "gb_Anonimo"
            fAnonimo.seccion = seccion
            fAnonimo.save(flush: true)
        }

        render seccion.id
    }

    def deleteSeccion = {
        //println "delete " + params
        def seccion = Seccion.get(params.id)
        //println "!!!! tipo " + seccion.tipo + " frases ! " + Frase.findAllBySeccion(seccion)
        seccion?.foto?.frases?.each {
            it.delete()
        }
        seccion?.foto?.delete()
        seccion?.video?.frases?.each {
            it.delete()
        }
        seccion?.video?.delete()
        def frases = Frase.findAllBySeccion(seccion)
        frases.each {
            it.delete()
        }

        def comentarios = Comentario.findAllBySeccion(seccion)
        comentarios.each {
            it.delete()
        }

        seccion?.delete(flush: true)
        render " "
    }

    def nuevaPagina = {
//        println "nueva pagina " + session.sitio
        if (!session.sitio)
            redirect(action: sitios)
        def orden = []
        20.times {
            orden.add(it + 1)
        }

        def c = Propiedades.createCriteria()
        def np = c.list {
            ilike("tipo", "%body%")
            and {
                order("grupo", "asc")
                order("orden", "asc")
            }
        }
        def props = Propiedades.findAll("from Propiedades where tipo like '%editPag%' order by grupo,orden")

        def criteria = TipoPagina.createCriteria()
        def tiposPagina = criteria.list {
            or {
                eq("sitio", session.sitio)
                isNull("sitio")
            }
            eq("mostrar", 1)
            order("nombre", "asc")
        }


        if (params.id) {
            def layout = Layout.get(params.id)
            return [layout: layout, orden: orden, np: np, props: props]
        } else {
            return [orden: orden, np: np, props: props, tiposPagina: tiposPagina]
        }
    }
    def saveBodyProp = {
        def cal = Calendar.instance
        def Y = cal.get(Calendar.YEAR)
        def M = cal.get(Calendar.MONTH) + 1
        def D = cal.get(Calendar.DATE)
        def h = cal.get(Calendar.HOUR_OF_DAY)
        def m = cal.get(Calendar.MINUTE)
        def s = cal.get(Calendar.SECOND)

        def date = D + "-" + M + "-" + Y + "_" + h + ":" + m + ":" + s

        def layout = Layout.get(params.layout)

        def nop = ["layout", "action", "controller"]
        def css = ""

        def sitio = session.sitio
        def nombreSitio = sitio.nombre

        def dir = grailsApplication.config.images.location.toString() + "Sitios"
        def file = dir + File.separatorChar + nombreSitio + "_" + date

        def f = request.getFile('background-url')
        params.remove('background-url')
        if (!f.empty) {
            println "BODY image bg"
            def filename = f.getOriginalFilename()
            def parts = filename.split("\\.")
            def ext = parts[parts.size() - 1]
            file += "." + ext
            println 'Your file has been uploaded to ' + file
            new File(dir).mkdirs()
            f.transferTo(new File(file))

            params["background-image"] = "url(" + resource(dir: "images/Sitios", file: nombreSitio + "_" + date + "." + ext) + ")"
        }
        else {
            nop.add("background-url")
//            println 'file is empty'
        }

        params.eachWithIndex { param ->
            if (!nop.contains(param.key)) {
                if (param.value != "" && param.value != "-1") {
                    css += param.key + ":" + param.value + ";"
                }
            }
        }
//        println css
        layout.css = css
        layout.save(flush: true, failOnError: true)

        redirect(action: "nuevaPagina", id: params.layout)

    }

    def propiedades = {
        def props = Propiedades.findAll("from Propiedades where tipo in ('editPagina') order by grupo")

        //def fuente = Propiedades.findAllByTipo("Fuente", [sort: "orden"]);
        //def tam = Propiedades.findAllByTipo("Tamaño", [sort: "orden"]);
        //def texto = Propiedades.findAllByTipo("Texto", [sort: "orden"]);
        //def formato = Propiedades.findAllByTipo("Formato", [sort: "orden"]);
        //def posicion = Propiedades.findAllByTipo("Posición", [sort: "orden"]);
        //def color = Propiedades.findAllByTipo("Color", [sort: "orden"]);
        //[color: color, formato: formato, fuente: fuente, tam: tam, texto: texto, posicion: posicion]
        [props: props]
    }

    def guardarPagina = {ImageCO imageCO ->

//        println "guardar pagina"
//        println params

        def image = imageCO?.image
        image.width = 150
        image.height = 0
        image.dataHeight = 0
        image.dataWidth = 150
        image.tags = ""
//        println "GUARDAR PAGINA"
//        println params.pagina
        if (!session.idioma)
            session.idioma = Idioma.findByNombre("Español")
        /* TODO las frases del menu estan como publicadas ojo */
        if (params.layout.id && params.layout.id != "") {
            def layout = Layout.get(params.layout.id)
            def pagina = new Pagina()
            pagina.nombre = params.pagina.nombre
            pagina.sitio = session.sitio
            pagina.orden = params.pagina.orden.toInteger()
            pagina.layout = layout
            if (params.pagina.tipo == "Galeria") {
//                println "tipo !!! " + nth.TipoPagina.findByNombre(params.pagina.tipo)
                pagina.tipoPagina = TipoPagina.findByNombre(params.pagina.tipo)
                image.save(flush: true)
                //println "save image "+image.errors
                pagina.foto = image
            }

            if (pagina.save(flush: true)) {
                if (params.pagina.menu != "" && params.pagina.menu != " ") {
                    def fraseMenu = new Frase(["pagina": pagina, "idioma": session.idioma, "frase": params.pagina.menu, "estado": "Publicado"])
                    fraseMenu.save(flush: true)
                    //println "errores "+fraseMenu.errors
                }
                redirect(action: "editarPagina", params: ["id": pagina.id, "add": true])
            } else {
//                println "errores pag " + pagina.errors
                redirect(action: "nuevaPagina")
            }

        } else {
            def pagina = new Pagina()
            pagina.nombre = params.pagina.nombre
            pagina.sitio = session.sitio
            pagina.orden = params.pagina.orden.toInteger()
            if (params.pagina.tipo == "Galeria") {
                pagina.tipo = params.pagina.tipo
                image.save(flush: true)
                //println "save image "+image.errors
                pagina.foto = image
            }
            pagina.save()
//            //println "save pagina "+params.pagina
            if (pagina.save(flush: true)) {
                if (params.pagina.menu != "" && params.pagina.menu != " ") {
                    def fraseMenu = new Frase(["pagina": pagina, "idioma": session.idioma, "frase": params.pagina.menu, "estado": "Publicado"])
                    fraseMenu.save(flush: true)
                    //println "errores "+fraseMenu.errors
                }
                def layout = new Layout(["nombre": params.layout.nombre, "descripcion": params.layout.descripcion])
//                //println "save layout "+params.layout
                if (params.layout.banner != "0") {
                    def banner = new Seccion(params.banner)
                    banner.tipo = "Layout"
                    banner.save(flush: true)
                    //println "save banner "+banner.errors
                    layout.banner = banner

                }
                if (params.layout.menu != "0") {
                    def menu = new Seccion(params.menu)
                    menu.tipo = "Layout"
                    menu.save(flush: true)
                    //println "save menu "+menu.errors
                    layout.menu = menu
                }
                def contenido = new Seccion(params.contenido)
                contenido.tipo = "Layout"
                contenido.save(flush: true)
                layout.contenido = contenido
//                //println "banner "+layout.banner+" "+layout.banner.class
                ////println "errores secciones " + menu.errors
                if (layout.save(flush: true))
                    pagina.layout = layout
//                //println "errores layout- " + layout.errors
                pagina.save(flush: true)
                redirect(action: "editarPagina", params: ["id": pagina.id, "add": true])
            }
            else {
//                //println "errores " + pagina.errors
                redirect(action: "nuevaPagina")
            }
        }
    }

    def guardarLayout = {

        if (params.layout.id && params.layout.id != "") {
            //println "editar layout " + params
            def layout = Layout.get(params.layout.id)
            //println "bbaner "+params.layout.banner+" "+params.layout.banner.class
            if (params.layout.banner == "0") {
                if (layout.banner)
                    layout.banner.delete()
                layout.banner = null
            } else {
                layout.banner.properties = params.banner
                layout.banner.save()
            }
            if (params.layout.menu == "0") {
                if (layout.menu)
                    layout.menu.delete()
                layout.menu = null
            } else {
                layout.menu.properties = params.menu
                layout.menu.save()
            }
            if (params.layout.idioma == "0") {
                if (layout.idioma)
                    layout.idioma.delete()
                layout.idioma = null
            } else {
                layout.idioma.properties = params.idioma
                layout.idioma.save()
            }
            layout.contenido.properties = params.contenido
            //println "cont "+params.contenido+" errrors "+layout.contenido.errors+" "+layout.contenido.id+" "+layout.contenido.top
            layout.contenido.save()

            layout.nombre = params.nombre
            layout.descripcion = params.descripcion

            if (layout.save(flush: true)) {
                render("ok")
            } else {
                //println "error layout "+layout.errors
                render("Error")
            }
        } else {
//            println "save layout " + params
            if (!session.sitio)
                redirect(action: "sitios")
            def layout = new Layout(["nombre": params.nombre, "descripcion": params.descripcion, "sitio": session.sitio])
            if (params.layout.banner != "0") {
                def banner = new Seccion(params.banner)
                banner.tipo = "Layout"
                banner.save(flush: true)
                layout.banner = banner
            }
            if (params.layout.menu != "0") {
                def menu = new Seccion(params.menu)
                menu.tipo = "Layout"
                menu.save(flush: true)
                layout.menu = menu
            }
            if (params.layout.idioma != "0") {
                def idioma = new Seccion(params.idioma)
                idioma.tipo = "Layout"
                idioma.save(flush: true)
                layout.idioma = idioma
            }
            def contenido = new Seccion(params.contenido)
            contenido.tipo = "Layout"
            contenido.save(flush: true)
            layout.contenido = contenido
            if (layout.save(flush: true)) {
                render(layout.id + "_" + layout.nombre)
            } else {
                //println "error layout "+layout.errors
                render("Error")
            }


        }
    }


    def eliminarLayout = {
        //println "eliminar layout "+params
        if (params.layout != "") {
            def layout = Layout.get(params.layout)
            if (Pagina.findAllByLayout(layout).size() == 0) {
                layout.delete()
                render "ok"
                //println "aqui"
            } else {
                render "error"
            }
        } else {
            render "ok"
        }
    }

    def editarContenido = {
//        println "editar contenido " + params
        def seccion = Seccion.get(params.id)

        def disponibles = Pagina.findAllByTipoPagina(TipoPagina.findByNombre("Galeria"), [sort: "nombre"])

        return [seccion: seccion, disponibles: disponibles]
    }
    def guardarContenido = {
//        println "guardar contenido " + params
        def seccion = Seccion.get(params.seccion.toLong())
        seccion.contenido = Pagina.get(params.pagina)
        seccion.save()
        println "errores " + seccion.errors
        render "ok"
    }
    def editarBanner = {
//        println "editar banner " + params
        def layout = Layout.get(params.id)
        def banner = layout.banner
        def foto = banner.foto
        def disponibles = Pagina.findAllByTipoPagina(TipoPagina.findByNombre("Galeria"), [sort: "nombre"])
        [seccion: banner, foto: foto, disponibles: disponibles]
    }

    def guardarContenidoBanner = {

//        println "guardar contenido banner " + params
        def seccion = Seccion.get(params.banner)
        seccion.contenido = Pagina.get(params.pagina)
        seccion.save()
        println "errores " + seccion.errors
        render "ok"
    }

    def guardarImagenBanner = {
        def image
        def seccion = Seccion.get(params.seccion)
//        println "guardar imagen banner " + params + "    " + seccion + " "
        if (seccion.foto) {
            image = seccion.foto
            image.properties = params
        } else
            image = new Foto (["caption": params.caption, "data": params.data])
        image.width = seccion.width
        image.height = seccion.height
        image.dataHeight = seccion.height
        image.dataWidth = seccion.width
        image.tags = ""
        image.save(flush: true)
        println "save image " + image.errors
        seccion.foto = image
        seccion.save(flush: true)
        [seccion: seccion]
    }



    def editarSecciones = {
        render "oks"
    }

    def cambiarIdioma = {
        //println "cambiar idioma "+params
        session.idioma = Idioma.get(params.id)
        render "ok"
    }

}
