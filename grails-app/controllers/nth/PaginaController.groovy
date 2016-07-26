package nth

import nth.seguridad.Shield

class PaginaController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [paginaInstanceList: Pagina.list(params), paginaInstanceTotal: Pagina.count()]
    }

    def create = {
        def paginaInstance = new Pagina()
        paginaInstance.properties = params
        return [paginaInstance: paginaInstance]
    }

    def save = {
        def paginaInstance = new Pagina(params)
        if (paginaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'pagina.label', default: 'Pagina'), paginaInstance.id])}"
            redirect(action: "show", id: paginaInstance.id)
        }
        else {
            render(view: "create", model: [paginaInstance: paginaInstance])
        }
    }

    def show = {
      println "pagina show"
        def paginaInstance = Pagina.get(params.id)
        if (!paginaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pagina.label', default: 'Pagina'), params.id])}"
            redirect(action: "list")
        }
        else {
            [paginaInstance: paginaInstance]
        }
    }

    def edit = {
        def paginaInstance = Pagina.get(params.id)
        if (!paginaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pagina.label', default: 'Pagina'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [paginaInstance: paginaInstance]
        }
    }

    def update = {
        def paginaInstance = Pagina.get(params.id)
        if (paginaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (paginaInstance.version > version) {
                    
                    paginaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'pagina.label', default: 'Pagina')] as Object[], "Another user has updated this Pagina while you were editing")
                    render(view: "edit", model: [paginaInstance: paginaInstance])
                    return
                }
            }
            paginaInstance.properties = params
            if (!paginaInstance.hasErrors() && paginaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'pagina.label', default: 'Pagina'), paginaInstance.id])}"
                redirect(action: "show", id: paginaInstance.id)
            }
            else {
                render(view: "edit", model: [paginaInstance: paginaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pagina.label', default: 'Pagina'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def paginaInstance = Pagina.get(params.id)
        if (paginaInstance) {
            try {
                paginaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'pagina.label', default: 'Pagina'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'pagina.label', default: 'Pagina'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pagina.label', default: 'Pagina'), params.id])}"
            redirect(action: "list")
        }
    }
}
