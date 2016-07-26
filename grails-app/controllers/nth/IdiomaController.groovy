package nth

import nth.seguridad.Shield

class IdiomaController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def getString(css, cssI, search) {
        def str = ""
        int position = css.lastIndexOf(search);
        for (def i = position + search.size(); i < cssI.size(); i++) {
            if (cssI[i] != "{" && cssI[i] != "}") {
                str += cssI[i]
            }
            if (cssI[i] == "}") {
                break
            }
        }
        return str
    }

    def makeJs(str) {
        def js = "{"
        def lines = str.split(";")
        lines.each { l ->
            println l
            def p = l.split(":")
            js += '"' + p[0].trim() + '":"' + p[1].trim() + '",'
        }
        if (js != "{") {
            js = js[0..js.size() - 2]
        }
        js += "}"
        return js
    }

    def config = {
        def layout = Layout.get(params.id)
        def tipo = layout.tipoIdioma
        if (!tipo) {
            tipo = "select"
        }
        def cssI = layout.cssIdioma
        if (!cssI) {
            cssI = "<style type='text/css'>"
            cssI += ".divIdioma a:link {"
            cssI += "text-decoration : none;"
            cssI += "color           : black;"
            cssI += "}"

            cssI += ".divIdioma a:visited {"
            cssI += "text-decoration : none;"
            cssI += "color           : black;"
            cssI += "}"

            cssI += ".divIdioma a:active {"
            cssI += "text-decoration : none;"
            cssI += "color           : black;"
            cssI += "}"

            cssI += ".divIdioma a:hover {"
            cssI += "text-decoration : underline;"
            cssI += "color           : red;"
            cssI += "}"

            cssI += ".idiomaActual {"
            cssI += "background : orange;"
            cssI += "}"
            cssI += "</style>"
        }

        def aLink, aVisited, aActive, aHover, actual
        def cssLink, cssVisited, cssActive, cssHover, cssActual
        StringBuffer css = new StringBuffer(cssI);

        aLink = getString(css, cssI, "a:link {")
        aVisited = getString(css, cssI, "a:visited {")
        aActive = getString(css, cssI, "a:active {")
        aHover = getString(css, cssI, "a:hover {")
        actual = getString(css, cssI, ".idiomaActual {")

        cssLink = makeJs(aLink)
        cssVisited = makeJs(aVisited)
        cssActive = makeJs(aActive)
        cssHover = makeJs(aHover)
        cssActual = makeJs(actual)

        println "CSS " + cssLink

        return [layout: layout, tipo: tipo, cssLink: cssLink, cssVisited: cssVisited, cssActive: cssActive, cssHover: cssHover, cssActual: cssActual]
    }

    def saveConfig = {
        def layout = Layout.get(params.id)
        layout.tipoIdioma = params.tipo
        if (layout.save(flush: true)) {
            render "OK"
        } else {
            render "NO"
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def nuevoIdioma = {
        def idioma
        if (params.id)
            idioma = Idioma.get(params.id)
        [idioma: idioma]
    }


    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [idiomaInstanceList: Idioma.list(params), idiomaInstanceTotal: Idioma.count()]
    }

    def create = {
        def idiomaInstance = new Idioma()
        idiomaInstance.properties = params
        return [idiomaInstance: idiomaInstance]
    }

    def save = {
        println "save idioma " + params
        def idiomaInstance
        if (!params.id)
            idiomaInstance = new Idioma(params)
        else {
            idiomaInstance = Idioma.get(params.id)
            idiomaInstance.properties = params
        }
        if (idiomaInstance.save(flush: true)) {
            redirect(controller: "editor", action: "empty")
        }
        else {
            render(view: "nuevoIdioma", model: [idioma: idiomaInstance])
        }
    }

    def show = {
        def idiomaInstance = Idioma.get(params.id)
        if (!idiomaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'idioma.label', default: 'Idioma'), params.id])}"
            redirect(action: "list")
        }
        else {
            [idiomaInstance: idiomaInstance]
        }
    }



    def edit = {
        def idiomaInstance = Idioma.get(params.id)
        if (!idiomaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'idioma.label', default: 'Idioma'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [idiomaInstance: idiomaInstance]
        }
    }

    def update = {
        def idiomaInstance = Idioma.get(params.id)
        if (idiomaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (idiomaInstance.version > version) {

                    idiomaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'idioma.label', default: 'Idioma')] as Object[], "Another user has updated this Idioma while you were editing")
                    render(view: "edit", model: [idiomaInstance: idiomaInstance])
                    return
                }
            }
            idiomaInstance.properties = params
            if (!idiomaInstance.hasErrors() && idiomaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'idioma.label', default: 'Idioma'), idiomaInstance.id])}"
                redirect(action: "show", id: idiomaInstance.id)
            }
            else {
                render(view: "edit", model: [idiomaInstance: idiomaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'idioma.label', default: 'Idioma'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def idiomaInstance = Idioma.get(params.id)
        if (idiomaInstance) {
            try {
                idiomaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'idioma.label', default: 'Idioma'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'idioma.label', default: 'Idioma'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'idioma.label', default: 'Idioma'), params.id])}"
            redirect(action: "list")
        }
    }
}
