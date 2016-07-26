package nth

import nth.seguridad.Shield

class GaleriaController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [galeriaInstanceList: Galeria.list(params), galeriaInstanceTotal: Galeria.count()]
    }

    def create = {
        def galeriaInstance = new Galeria()
        galeriaInstance.properties = params
        return [galeriaInstance: galeriaInstance]
    }

    def save = {
        def galeriaInstance = new Galeria(params)
        if (galeriaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'galeria.label', default: 'Galeria'), galeriaInstance.id])}"
            redirect(action: "show", id: galeriaInstance.id)
        }
        else {
            render(view: "create", model: [galeriaInstance: galeriaInstance])
        }
    }

    def show = {
        def galeriaInstance = Galeria.get(params.id)
        if (!galeriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'galeria.label', default: 'Galeria'), params.id])}"
            redirect(action: "list")
        }
        else {
            [galeriaInstance: galeriaInstance]
        }
    }

    def edit = {
        def galeriaInstance = Galeria.get(params.id)
        if (!galeriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'galeria.label', default: 'Galeria'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [galeriaInstance: galeriaInstance]
        }
    }

    def update = {
        def galeriaInstance = Galeria.get(params.id)
        if (galeriaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (galeriaInstance.version > version) {
                    
                    galeriaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'galeria.label', default: 'Galeria')] as Object[], "Another user has updated this Galeria while you were editing")
                    render(view: "edit", model: [galeriaInstance: galeriaInstance])
                    return
                }
            }
            galeriaInstance.properties = params
            if (!galeriaInstance.hasErrors() && galeriaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'galeria.label', default: 'Galeria'), galeriaInstance.id])}"
                redirect(action: "show", id: galeriaInstance.id)
            }
            else {
                render(view: "edit", model: [galeriaInstance: galeriaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'galeria.label', default: 'Galeria'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def galeriaInstance = Galeria.get(params.id)
        if (galeriaInstance) {
            try {
                galeriaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'galeria.label', default: 'Galeria'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'galeria.label', default: 'Galeria'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'galeria.label', default: 'Galeria'), params.id])}"
            redirect(action: "list")
        }
    }
}
