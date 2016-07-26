package nth

class ImageController {
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }


    def list = {
        List<Foto> images = []
        Integer count
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        images = Foto.list(params)
        count = Foto.count()

        [images: images, imageTotal: count]
    }
    def showImageIdioma = {
        def something = Idioma.get(params.id)
        byte[] image = something.imagen
        response.outputStream << image
    }
    def create = {
        println "image create " + params
        def idioma = Idioma.get(params.idioma.toInteger());
        def image = new Foto()
        image.properties = params
        def seccion = Seccion.get(params.id)

        def size = [:]
        size.width = params.w
        size.height = params.h
//        if (params.w > params.h)
//            size.width = params.w
//        else
//            size.height = params.h
        return [image: image, seccion: seccion, idioma: idioma, tags: "[]", size: size]
    }

    def addToGal = {
//        println "add photo to gal " + params
        def idioma = Idioma.get(params.idioma.toInteger());

        def image = Foto.get(params.foto)
//        image.properties = params

        /*
       ["Galería", "Fotos"]
        */
        def titulo = "", descripcion = "", tags = "[]", stags = ""
        if (image) {
            titulo = image.frases.find {it.tipo == "Titulo"}
            descripcion = image.frases.find {it.tipo == "Descripcion"}
            tags = '['
            def t = image.tags.split()
            t.each {
                tags += '"' + it + '",'
                stags += it + " "
            }
            if (tags != '[') {
                tags = tags.substring(0, tags.size() - 1)
            }
            tags += ']'
        }

        def galeria = Galeria.get(params.id)
        return [image: image, galeria: galeria, idioma: idioma, titulo: titulo, descripcion: descripcion, tags: tags, stags: stags]
    }

    def save = {ImageCO imageCO ->
        def image = imageCO?.image
        println "save image " + params
        def seccion = Seccion.get(params.seccion)
        if (seccion.tipo == "Foto") {
            if (seccion.foto != null) {
                seccion.foto.caption = image.caption
                seccion.foto.data = image.data
                def ancho
                def alto
                try {
                    ancho = params.width.toInteger()
                } catch (e) {
                    ancho = 0
                }
                try {
                    alto = params.height.toInteger()
                } catch (e) {
                    alto = 0
                }
                seccion.foto.width = ancho
                seccion.foto.height = alto
                seccion.foto.tags = params.tags
                seccion.foto.save(flush: true)
                println "errores " + seccion.errors + " !!! foto " + seccion.foto.errors
                //render(seccion.foto.id)

            } else {
                def ancho
                def alto
                try {
                    ancho = params.width.toInteger()
                } catch (e) {
                    ancho = 0
                }
                try {
                    alto = params.height.toInteger()
                } catch (e) {
                    alto = 0
                }

                image.width = ancho
                image.height = alto
                image.tags = params.tags
                image.save(flush: true)
                seccion.foto = image
                seccion.save(flush: true)
                println "w2 " + seccion.width + " h " + seccion.height
                println "errores " + seccion.errors + " !!! foto " + seccion.foto.errors
            }
            [seccion: seccion]

        }
        /*
        if (!image?.hasErrors() && image.save()) {
          flash.message = "Image has been uploaded"

          render "ok"
        } else {
          println "errores "+image.errors
          render(view: "create", model: [image: image])
        }
        */
    }


    def saveToGal = { ImageCO imageCO ->

        // TODO: Idioma debe venir de la sesion
//        def idioma = Idioma.findByAbreviacion("es")

        def idioma = session.idioma

        def imageId = params.imagen
        def foto
        def image = imageCO?.image
        println "save image " + params
        def gal = Galeria.get(params.galeria)

        def defW = 1024
        def defTW = 150

        if (imageId) {
            foto = Foto.get(imageId)
            foto.width = defTW
            foto.dataWidth = defW
            foto.tags = params.tags
            foto.galeria = gal
            foto.data = image.data
            foto.save(flush: true, failOnError: true)

            def titulo = foto.frases.find {it.tipo == "Titulo"}
            titulo.frase = params.titulo
            titulo.idioma = idioma
            titulo.estado = "Publicado"
            titulo.tags = params.titulo
            titulo.save(flush: true, failOnError: true)

            def descripcion = foto.frases.find {it.tipo == "Descripcion"}
            descripcion.frase = params.descripcion
            descripcion.idioma = idioma
            descripcion.estado = "Publicado"
            descripcion.tags = params.descripcion
            descripcion.save(flush: true, failOnError: true)
        } else {
            image.width = defTW
            image.dataWidth = defW
            image.tags = params.tags
            image.galeria = gal
            image.save(flush: true, failOnError: true)
            gal.addToFotos(image)

            def titulo = new Frase()
            titulo.frase = params.titulo
            titulo.idioma = idioma
            titulo.estado = "Publicado"
            titulo.foto = image
            titulo.tags = params.titulo
            titulo.tipo = "Titulo"
            titulo.save(flush: true, failOnError: true)

            def descripcion = new Frase()
            descripcion.frase = params.descripcion
            descripcion.idioma = idioma
            descripcion.estado = "Publicado"
            descripcion.foto = image
            descripcion.tags = params.descripcion
            descripcion.tipo = "Descripcion"
            descripcion.save(flush: true, failOnError: true)
        }

    }


    def show = {
        def image = Foto.get(params.id)
        if (!image) {
            flash.message = "Image not found"
            redirect(action: "list")
        }
        else {
            [image: image]
        }
    }

    def edit = {
        def image = Foto.get(params.id)
        if (!image) {
            flash.message = "Image not found"
            redirect(action: "list")
        }
        else {
            return [image: image]
        }
    }

    def update = {
        def image = Foto.get(params.id)
        if (image) {
            image.properties = params
            if (!image.hasErrors() && image.save(flush: true)) {
                flash.message = "Image has been updated"
                redirect(action: "show", id: image.id)
            }
            else {
                render(view: "edit", model: [image: image])
            }
        }
        else {
            flash.message = "Image not found"
            redirect(action: "list")
        }
    }


    def delete = {
        def image = Foto.get(params.id)
        if (image) {
            try {
                image.delete(flush: true)
                flash.message = "Image has been deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Image could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "Image could not be found"
            redirect(action: "list")
        }
    }

    def showImage = {
        Foto image = Foto?.get(params?.id)
        response.setContentType('image/jpg')
        if (params.thumbnail == "true" || params.thumbnail.is(true)) {
            response.outputStream << (image?.thumbnail)
        } else {
            response.outputStream << (image?.data)
        }
    }

    def showImageSeccion = {
        println "show imagen seccion !! " + params
        def seccion = Seccion.get(params.id)
        Foto image = seccion.foto
        println "foto " + seccion + " foto " + image
        render ig.img(["src": g.createLink(action: 'showImage', controller: 'image', id: image?.id), "alt": image?.caption, "title": image?.caption, "thumbnailSrc": g.createLink(action: 'showImage', controller: 'image', id: image?.id, params: [thumbnail: true])])
    }
}
