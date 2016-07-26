package nth

class PaginaWebController {

    def mailService

    def index = { }

    def show = {
        //println "show " + params
        if (params.idioma) {
            def idioma = Idioma.get(params.idioma)
            session.idioma = idioma
            //println "\n\nCAMBIADO EL IDIOMA A " + idioma
        }

        if (!session.idioma)
            session.idioma = Idioma.findByAbreviacion("es")
        def sitio = null
        if (params.sitio)
            sitio = Sitio.findByNombre(params.sitio)
        if (sitio)
            session.sitio = sitio
        else {
            sitio = Sitio.findByPrincipal(1)
            session.sitio = sitio
            if (!sitio)
                response.sendError(404)
        }


        def pagina = Pagina.findByNombreAndSitio(params.pagina, sitio)
        if (!pagina) {
            pagina = Pagina.findByTipoPagina(TipoPagina.get(1))
        }

        session.pagina = pagina

        def tipo = TipoPagina.findByPagina(pagina)
        def pags = []
        if (tipo) {
            if (!params.id) {
                pags = Pagina.findAllByTipoPagina(tipo)
            }
        }
//        println "mostrando pagina " + pagina + " sitio " + sitio + " tipo " + tipo
        if (pagina)
            [pagina: pagina, pags: pags]
        else
            response.sendError(404)
    }

    def showContenido = {
        //println "show cont " + params
        if (!session.idioma)
            session.idioma = Idioma.get(6)
        def pagina = Pagina.get(params.id)
        if (pagina)
            [pagina: pagina]
        else
            response.sendError(404)
    }


    def submitFormContacto = {
        //println "Contacto: " + params
        def sep = "</n>"

        def str = "Nueva petición de contacto: " + sep + sep
        def nop = ["action", "controller"]

        params.each { k, v ->
            if (!nop.contains(k)) {
                str += k + ": " + v + sep
            }
        }

        mailService.sendMail {
            to "guido8a@gmail.com","informacion@tedein.com.ec"
            from "tedein.sa.ecuador@gmail.com"
            subject "Contacto"
//            html str
            body str
        }

        redirect(controller: "paginaWeb", action: "show", params: [sitio: session.sitio, pagina: "gracias"])
    }


    def saveComment = {

//        println params
//        println session.sitio.nombre
//        println "\n"

        def pagina = Pagina.get(params.pagina.id)

        def comentario = new Comentario()
        comentario.nombre = params.nombre
        comentario.texto = params.texto
        comentario.seccion = Seccion.get(params.seccion.id)
        comentario.estado = "Publicado"
        comentario.fecha = new Date()

        if (comentario.save(flush: true, failOnError: true)) {

            //handle uploaded file
//            def uploadedFile = request.getFile('foto')
//            if (!uploadedFile.empty) {
////                println "Class: ${uploadedFile.class}"
////                println "Name: ${uploadedFile.name}"
////                println "OriginalFileName: ${uploadedFile.originalFilename}"
////                println "Size: ${uploadedFile.size}"
////                println "ContentType: ${uploadedFile.contentType}"
//
//                def webRootDir = servletContext.getRealPath("/")
//                def userDir = new File(webRootDir, "/fotos/${session.sitio.nombre}/${pagina.nombre}")
//                userDir.mkdirs()
//
//                def nom = uploadedFile.originalFilename
//                def pnom = nom.split("\\.")
//                def ext = pnom[pnom.size() - 1]
//                nom = ""
//                pnom.eachWithIndex { p, i ->
//                    if (i < pnom.size() - 1) {
//                        nom += p
//                    }
//                }
//
//                nom += "_" + comentario.id + "." + ext
//                uploadedFile.transferTo(new File(userDir, nom))
//                comentario.foto = nom
////                println "nom: " + nom
//                comentario.save(flush: true, failOnError: true)
//            }


            redirect(controller: "paginaWeb", action: "show", params: [pagina: pagina.nombre, sitio: session.sitio.nombre])

//            def seccion = Seccion.get(params.seccion.id)
//
//            def comentarios = Comentario.findAllBySeccionAndEstado(seccion, "Publicado", [sort: 'fecha', order: 'desc'])
//            def str = ""
//
//            comentarios.each { com ->
//                str += com.display()
//            }
//
//            render(str)
        }
        else {
            render("ERROR")
        }
    }
}
