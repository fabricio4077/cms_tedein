package nth

import nth.seguridad.Shield

class ContactoController extends Shield  {

    def getTb(seccion, idioma) {
        def tb = ""
        def es = Idioma.findByAbreviacion("es")
        def frases = Frase.findAllBySeccionAndIdioma(seccion, idioma, [sort: "orden"])
        def b = false
        if (idioma.id != es.id) {
            b = true
        }
        if (frases.size() == 0) {
            frases = Frase.findAllBySeccionAndIdioma(seccion, es, [sort: "orden"])
            b = true
        }

        frases.each { fr ->
            tb += "<tr frase='" + fr.frase + "' tipo='" + fr.tags + "'>"

            tb += "<td style='text-align:center;'>"
            tb += fr.orden
            tb += "</td>"

            tb += "<td>"
            tb += fr.frase
            tb += "</td>"

            if (b) {
                tb += "<td>&nbsp;</td>"
            }

            tb += "<td>"
            switch (fr.tags) {
                case "textfield":
                    tb += "Campo de texto"
                    break;
                case "textarea":
                    tb += "Area de texto"
                    break;
                case "boton":
                    tb += "Botón guardar"
                    break;
            }
            tb += "</td>"

            tb += "<td style='text-align:center;'>"
            tb += "<a href='#' class='del' id='" + fr.id + "'>Eliminar</a>"
            tb += "</td>"

            tb += "</tr>"
        }

        tb += "<script type='text/javascript'>"
        tb += '$(".del").button({'
        tb += 'icons:{'
        tb += 'primary:"ui-icon-trash"'
        tb += '},'
        tb += 'text:false'
        tb += '}).click(function () {'
        tb += 'var id = $(this).attr("id");'
        tb += '$.ajax({'
        tb += 'url:"' + createLink(action: "removeField") + '",'
        tb += 'data:{'
        tb += "seccion:" + seccion.id + ","
        tb += "id:id"
        tb += '},'
        tb += 'success:function (msg) {'
        tb += '$("#fieldName").val("");'
        tb += '$("#fieldType").val("textfield");'
        tb += '$("#tb").html(msg);'
        tb += 'o = $("#tb tr").length + 1;'
        tb += '$("#fieldOrder").val(o);'
        tb += '}'
        tb += '});'
        tb += '});'
        tb += '</script>'

        return tb
    }

    def index = { }

    def config = {
        def seccion = Seccion.get(params.id)
        def idioma = Idioma.get(session.idioma.id)
        def tb = getTb(seccion, idioma)
        return [seccion: seccion, tb: tb]
    }

    def addField = {
        def seccion = Seccion.get(params.seccion)
        def field = params.field
        def tipo = params.tipo
        def orden = params.orden
        if (!orden) {
            orden = -1
        } else {
            orden = orden.toInteger()
        }
        def idioma = Idioma.get(session.idioma.id)
        def frase = new Frase()

        if (params.id) {
            frase = Frase.get(params.id)
        }

        frase.frase = field
        frase.estado = "Publicado"
        frase.tags = tipo
        frase.idioma = idioma
        frase.seccion = seccion
        frase.orden = orden

        def cont = frase.save(flush: true)

        if (cont) {
            def tb = getTb(seccion, idioma)
            render tb
        } else {
            println frase.errors
            render("NO")
        }
    }

    def removeField = {
//        println "RF: " + params
        def seccion = Seccion.get(params.seccion)
//        println "SECCION: " + seccion
        def idioma = Idioma.get(session.idioma.id)
//        println "IDIOMA: " + idioma
        def frase = Frase.get(params.id)
//        println "FRASE: " + frase
        frase.delete(flush: true)
        render getTb(seccion, idioma)
    }



}
