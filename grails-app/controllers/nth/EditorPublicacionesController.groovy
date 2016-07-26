package nth

import nth.seguridad.Shield

class EditorPublicacionesController extends Shield {

    def index = { }

    def menuPublicaciones = {
        def sitio = session.sitio
        if (!sitio) {
            sitio = Sitio.findByNombre("fine")
        }
        def tipos = TipoPagina.findAllBySitio(sitio, [sort: "nombre"])
        return [tipos: tipos]
    }

    def nuevoTipo = {
        def layouts = Layout.findAllByBannerIsNotNull()
        def layoutsPag = Layout.findAllByBannerIsNull()
        return [layouts: layouts, layoutsPag: layoutsPag]
    }

    def saveTipo = {

        def sitio = session.sitio
        if (!sitio) {
            sitio = Sitio.findByNombre("fine")
        }

        def tipoPagina = new TipoPagina()

        def pagina = new Pagina()
        pagina.sitio = sitio
        pagina.nombre = params.nombrePag
        pagina.orden = params.orden
        pagina.layout = Layout.get(params.cmbLayouts)
        if (pagina.save(flush: true, failOnError: true)) {
            if (params.menu != "" && params.menu != " ") {
                /* TODO las frases del menu estan como publicadas ojo */
                def fraseMenu = new Frase(["pagina": pagina, "idioma": session.idioma, "frase": params.menu, "estado": "Publicado"])
                fraseMenu.save(flush: true, failOnError: true)
                //println "errores "+fraseMenu.errors
            }

            def seccion = new Seccion();
            seccion.pagina = pagina
            seccion.top = 200
            seccion.izq = 150
            seccion.width = pagina.layout.contenido.width
            seccion.height = pagina.layout.contenido.height
            seccion.tipo = "Publicaciones"
            seccion.css = ""
            seccion.save(flush: true, failOnError: true)

            tipoPagina.nombre = params.nombre
            tipoPagina.descripcion = params.descripcion
            tipoPagina.sitio = sitio
            tipoPagina.pagina = pagina
            tipoPagina.mostrar = 1
            tipoPagina.layout = Layout.get(params.cmbLayoutPag)
            tipoPagina.save(flush: true, failOnError: true)
        }

        redirect(action: "editarPublicaciones", params: [id: tipoPagina.id, add: true])
    }

    def editarPublicaciones = {
        def tipoPagina = TipoPagina.get(params.id)
        def pagina = tipoPagina.pagina

        def seccion = new Seccion()
        def props = Propiedades.findAll("from Propiedades where tipo like 'editPag%' order by grupo,orden")
        return [pagina: pagina, seccion: seccion, add: params.add, props: props]
    }

    def nuevaPagina = {
        println "nueva pagina publicaciones"
        println params
        // TODO: quitar esto!!!
        if (!session.sitio)
            session.sitio = Sitio.findByNombre("fine")

        def tipo = TipoPagina.get(params.tipo)
        def layout = tipo.layout

        def orden = []
        20.times {
            orden.add(it + 1)
        }

        def c = Propiedades.createCriteria()
        def np = c.list {
            eq("tipo", "body")
            and {
                order("grupo", "asc")
                order("orden", "asc")
            }
        }
        def props = Propiedades.findAll("from Propiedades where tipo like 'editPag%' order by grupo,orden")

        return [layout: layout, orden: orden, np: np, props: props, tipo: tipo]
    }

    def preEditarPagina = {
        def tipo = TipoPagina.get(params.tipo)
        return [tipo: tipo]
    }

    def guardarPagina = { ImageCO imageCO ->
        def tags = ""
        (params["item[tags][]"]).each {
            tags += it + " "
        }

        /* TODO quitar esto del sitio */
        if (!session.idioma)
            session.idioma = Idioma.findByAbreviacion("es")

        if (!session.sitio)
            session.sitio = Sitio.findByNombre("fine")

        def defW = 150

        def image = imageCO?.image

        def foto = new Foto()
        foto.width = defW
        foto.dataWidth = defW
        foto.tags = tags
        foto.data = image.data
        foto.save(flush: true, failOnError: true)

        def tipo = TipoPagina.get(params.tipo)

        def pagina = new Pagina()
        pagina.nombre = params.nombre
        pagina.sitio = session.sitio
        pagina.layout = tipo.layout
        pagina.tipoPagina = tipo
        pagina.foto = foto
        pagina.orden = 1
        pagina.save(flush: true, failOnError: true)
        redirect(action: "editarPagina", id: pagina.id, params: ["add": true, tipo: params.tipo])
    }

    def editarPagina = {

        def pagina = Pagina.get(params.id)
        def tipo = TipoPagina.get(params.tipo)

        def menu = Frase.findByPaginaAndIdioma(pagina, session.idioma)
        def seccion = new Seccion()
        def props = Propiedades.findAll("from Propiedades where tipo like 'editPag%' order by grupo,orden")
        def orden = []
        20.times {
            orden.add(it + 1)
        }
        [pagina: pagina, seccion: seccion, add: params.add, props: props, orden: orden, menu: menu, tipo: tipo]
    }

    def deletePagina = {
        println "delete pagina " + params
        def pagina = Pagina.get(params.id)
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

    def getLayout = {
        def layout = Layout.get(params.id)
        return [layout: layout]
    }
}
