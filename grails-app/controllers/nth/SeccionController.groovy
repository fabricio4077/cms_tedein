package nth

import nth.seguridad.Shield

class SeccionController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [seccionInstanceList: Seccion.list(params), seccionInstanceTotal: Seccion.count()]
    }

    def create = {
        def seccionInstance = new Seccion()
        seccionInstance.properties = params
        return [seccionInstance: seccionInstance]
    }

    def save = {
        def seccionInstance = new Seccion(params)
        if (seccionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'seccion.label', default: 'Seccion'), seccionInstance.id])}"
            redirect(action: "show", id: seccionInstance.id)
        }
        else {
            render(view: "create", model: [seccionInstance: seccionInstance])
        }
    }

    def show = {
        def seccionInstance = Seccion.get(params.id)
        if (!seccionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'seccion.label', default: 'Seccion'), params.id])}"
            redirect(action: "list")
        }
        else {
            [seccionInstance: seccionInstance]
        }
    }

    def edit = {
        def seccionInstance = Seccion.get(params.id)
        if (!seccionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'seccion.label', default: 'Seccion'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [seccionInstance: seccionInstance]
        }
    }

    def update = {
        def seccionInstance = Seccion.get(params.id)
        if (seccionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (seccionInstance.version > version) {
                    
                    seccionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'seccion.label', default: 'Seccion')] as Object[], "Another user has updated this Seccion while you were editing")
                    render(view: "edit", model: [seccionInstance: seccionInstance])
                    return
                }
            }
            seccionInstance.properties = params
            if (!seccionInstance.hasErrors() && seccionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'seccion.label', default: 'Seccion'), seccionInstance.id])}"
                redirect(action: "show", id: seccionInstance.id)
            }
            else {
                render(view: "edit", model: [seccionInstance: seccionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'seccion.label', default: 'Seccion'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def seccionInstance = Seccion.get(params.id)
        if (seccionInstance) {
            try {
                seccionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'seccion.label', default: 'Seccion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'seccion.label', default: 'Seccion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'seccion.label', default: 'Seccion'), params.id])}"
            redirect(action: "list")
        }
    }
}
