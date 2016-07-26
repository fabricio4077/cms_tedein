package nth

import nth.seguridad.Shield

class EditorGaleriasController extends Shield {

    def index = { }

    def empty = { }

    def menuFotos = {
        def galerias = Galeria.findAllByTipo("Fotos", [sort: "nombre", order: "asc"]);
        [galerias: galerias]
    }

    def deleteFoto = {

        def foto = Foto.get(params.fot)
        foto?.frases?.each {
            it.delete()
        }
        foto?.delete()

        render(params)
    }

    def nuevaGaleria = {
        if (params.tipo == "Videos") {
            redirect(action: "nuevaGaleriaVideo", params: params)
        }
        def layoutsPag = Layout.findAllByBannerIsNull()
        println layoutsPag
        return [tipo: params.tipo, layoutsPag: layoutsPag]
    }

    def nuevaGaleriaVideo = {
        render(params)
    }

    def guardarGaleria = {

        //TODO: QUITAR ESTO!!
        if (!session.sitio) {
            session.sitio = Sitio.findByNombre("fine")
        }
        println params
        def idioma = params.idioma
        def nombre = params.nombre
        def tags = params.tags
        def layout = params.layout
        def layoutContenido = Layout.get(params.layoutContenido)
        def contenido = params.cont

        def gal = new Galeria()
        gal.nombre = nombre
        gal.tipo = contenido
        gal.tags = tags
        gal.layout = layout
        gal.layoutContenido = layoutContenido
        gal.sitio = session.sitio
//        gal.contenido = contenido
        gal.save()
        println gal
        println "ERRORES GAL!!!!!: "
        println gal.errors

//        def act = (gal.contenido == "Imagen") ? "addPhotos" : "addCont"
        def act = (gal.tipo == "Fotos") ? "addPhotos" : "addCont"

        redirect(controller: 'editorGalerias', action: act, params: ['id': gal.id, 'add': true])
    }

    def addPhotos = {
        return [gal: Galeria.get(params.id), add: params.add]
    }

    def addCont = {
        println params
        def gal = Galeria.get(params.id)
        def layout = gal.layoutContenido

        def pagsDisp = Pagina.withCriteria {
            eq("layout", layout)
            or {
                ne("galeria", gal)
                isNull("galeria")
            }
        }
        def pagsAct = Pagina.findAllByGaleria(gal)

        return [gal: gal, pagsDisp: pagsDisp, pagsAct: pagsAct, add: params.add]
    }

    def customizeGal = {
        def gal = Galeria.get(params.id)
        switch (gal.layout) {
            case "galleryView":
                redirect(action: "customizeGalleryView", params: params)
                break;
            case "cloudCarousel":
                redirect(action: "customizeCloudCarousel", params: params)
                break;
            case "jCycle":
                redirect(action: "customizejCycle", params: params)
                break;
            case "squares":
                redirect(action: "customizeSquares", params: params)
                break;
            case "awkward":
                redirect(action: "customizeAwkward", params: params)
                break;
        }
    }

    def customizeSquares = {
        def gal = Galeria.get(params.id)
        def c = Propiedades.createCriteria()
        def np = c.list {
            eq("tipo", "squares")
            and {
                order("grupo", "asc")
                order("orden", "asc")
            }
        }
        return [gal: gal, np: np]
    }

    def customizejCycle = {
        def gal = Galeria.get(params.id)
        def c = Propiedades.createCriteria()
        def np = c.list {
            eq("tipo", "jcycle")
            and {
                order("grupo", "asc")
                order("orden", "asc")
            }
        }
        return [gal: gal, np: np]
    }

    def customizeCloudCarousel = {
        def gal = Galeria.get(params.id)
        def c = Propiedades.createCriteria()
        def np = c.list {
            eq("tipo", "cloudCarousel")
            and {
                order("grupo", "asc")
                order("orden", "asc")
            }
        }
        return [gal: gal, np: np]
    }

    def customizeAwkward = {
        def gal = Galeria.get(params.id)
        def c = Propiedades.createCriteria()
        def np = c.list {
            eq("tipo", "awkward")
            and {
                order("grupo", "asc")
                order("orden", "asc")
            }
        }
        return [gal: gal, np: np]
    }

    def customizeGalleryView = {
        def gal = Galeria.get(params.id)
        def c = Propiedades.createCriteria()
        def np = c.list {
            eq("tipo", "galleryView")
            and {
                order("grupo", "asc")
                order("orden", "asc")
            }
        }
        return [gal: gal, np: np]
    }

    def renderGal = {
        def gal = Galeria.get(params.id)

        def propiedades = ""

        params.eachWithIndex {prop, i ->
            if (prop.key != "id" && prop.key != "controller" && prop.key != "action" && !prop.key.startsWith("_")) {
                if (prop.value == "on") {
                    propiedades += prop.key + ":true,"
                } else {
                    propiedades += prop.key + ":" + prop.value + ","
                }
            }
        }
        if (propiedades.size() > 0) {
            propiedades = propiedades.substring(0, propiedades.size() - 1)

            gal.propiedades = propiedades
            gal.save(failOnError: true)
        }

        params.galeria = gal

        render(gl.renderGal(params))
    }

    def renameGal = {
        def gal = Galeria.get(params.id)
        gal.nombre = params.nombre
        gal.save()
        render("OK")
    }

    def fotosGal = {
        def gal = Galeria.get(params.id)
        def fotos = Foto.findAllByGaleria(gal, [sort: 'id'])

        def fotosL = []

        fotos.each { foto ->
            def m = [:]
            m.obj = foto
            def frases = foto.frases
            m.titulo = frases.find { it.tipo == "Titulo"}
            m.descripcion = frases.find { it.tipo == "Descripcion"}
            fotosL.add(m)
        }

        return [gal: gal, fotos: fotosL]
    }

    def textosGal = {
        def gal = Galeria.get(params.id)
        def pags = Pagina.findAllByTipoAndGaleriaIsNull("Galeria")
        return [gal: gal, pags: pags]
    }

    def deleteGal = {
        def gal = Galeria.get(params.id)

        // elimina frases
        def fra = Frase.findAllByGaleria(gal)
        fra.each {
            it.delete()
        }

        // elimina frases fotos
        // elimina fotos
        def fot = Foto.findAllByGaleria(gal)
        fot.each { foto ->
            def fr = Frase.findAllByFoto(foto)
            fr.each {
                it.delete()
            }
            foto.delete()
        }

        // elimina gal
        gal.delete()

        render("OK")
    }

    def savePagToGal = {
        println "save pag to gal"
        println params
        println "____"
        def gal = Galeria.get(params.gal)

        if ((params.sel).size() > 0) {
            (params.sel).each { id ->
                def pag = Pagina.get(id.toInteger())
                if (pag?.galeria?.id != gal.id) {
                    pag.galeria = gal
                    pag.save(flush: true, failOnError: true)
                }
            }
        }
        if ((params.disp).size() > 0) {
            (params.disp).each { id ->
                def pag = Pagina.get(id.toInteger())
                if (!(pag.galeria).is(null)) {
                    pag.galeria = null
                    pag.save(flush: true, failOnError: true)
                }
            }
        }

        redirect(action: "customizeGal", id: params.gal)

//        render(params)
    }
}
