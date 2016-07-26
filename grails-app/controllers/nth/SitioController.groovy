package nth

import nth.seguridad.Shield

class SitioController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sitioInstanceList: Sitio.list(params), sitioInstanceTotal: Sitio.count()]
    }

    def create = {
        def sitioInstance = new Sitio()
        sitioInstance.properties = params
        return [sitioInstance: sitioInstance]
    }

    def save = {
        def sitioInstance = new Sitio(params)
        if (sitioInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'sitio.label', default: 'Sitio'), sitioInstance.id])}"
            session.sitio = sitioInstance
            redirect(controller: 'editor', action: "index")
        }
        else {
            render(view: "create", model: [sitioInstance: sitioInstance])
        }
    }

    def show = {
        def sitioInstance = Sitio.get(params.id)
        if (!sitioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sitio.label', default: 'Sitio'), params.id])}"
            redirect(action: "list")
        }
        else {
            [sitioInstance: sitioInstance]
        }
    }

    def edit = {
        def sitioInstance = Sitio.get(params.id)
        if (!sitioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sitio.label', default: 'Sitio'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [sitioInstance: sitioInstance]
        }
    }

    def update = {
        def sitioInstance = Sitio.get(params.id)
        if (sitioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sitioInstance.version > version) {

                    sitioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sitio.label', default: 'Sitio')] as Object[], "Another user has updated this Sitio while you were editing")
                    render(view: "edit", model: [sitioInstance: sitioInstance])
                    return
                }
            }
            sitioInstance.properties = params
            if (!sitioInstance.hasErrors() && sitioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sitio.label', default: 'Sitio'), sitioInstance.id])}"
                session.sitio = sitioInstance
                redirect(action: "show", id: sitioInstance.id)
            }
            else {
                render(view: "edit", model: [sitioInstance: sitioInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sitio.label', default: 'Sitio'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def sitioInstance = Sitio.get(params.id)
        if (sitioInstance) {
            try {
                sitioInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sitio.label', default: 'Sitio'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sitio.label', default: 'Sitio'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sitio.label', default: 'Sitio'), params.id])}"
            redirect(action: "list")
        }
    }
}
