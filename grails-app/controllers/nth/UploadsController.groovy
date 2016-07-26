package nth

import nth.seguridad.Shield

class UploadsController extends Shield {

    def uploadFile = {
//        println "upload file"
        def seccion = Seccion.get(params.id)
        def idioma = session.idioma
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

        [seccion: seccion, frase: frase, fraseEsp: fraseEsp]
    }

    def upload = {

        def frase = Frase.get(params.frase)

        def acceptedExt = ["pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "odt", "ods", "odp", "zip", "rar"]

        def path = servletContext.getRealPath("/") + "archivos/"   //web-app/archivos
        new File(path).mkdirs()

        def f = request.getFile('archivo')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }
            if (acceptedExt.contains(ext)) {

                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

                def cal = Calendar.instance
                def Y = cal.get(Calendar.YEAR)
                def M = cal.get(Calendar.MONTH) + 1
                def D = cal.get(Calendar.DATE)
                def h = cal.get(Calendar.HOUR_OF_DAY)
                def m = cal.get(Calendar.MINUTE)
                def s = cal.get(Calendar.SECOND)
                def date = D + "-" + M + "-" + Y + "_" + h + ":" + m + ":" + s

                fileName = session.sitio.nombre + "_" + fileName + date + "." + ext

                def pathFile = path + File.separatorChar + fileName

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path

                def url = "/archivos/" + fileName

//                println "frase " + frase + " params " + params + " " + frase.id
                frase.frase = params.contFrase
                frase.otros = url
                frase.save(flush: true)

                def js = "<script type='text/javascript'>"
                js += "window.close();"
                js += "</script>"
                render js
            } else {
                flash.message = "Está intentando subir un archivo no permitido"
                redirect(action: "uploadFile", params: [id: params.seccion])
            }
        } else {
            if (frase.otros) {
                frase.frase = params.contFrase
                frase.save(flush: true)

                def js = "<script type='text/javascript'>"
                js += "window.close();"
                js += "</script>"
                render js
            } else {
                flash.message = "Seleccione un archivo"
                redirect(action: "uploadFile", params: [id: params.seccion])
            }
        }
    }
}
