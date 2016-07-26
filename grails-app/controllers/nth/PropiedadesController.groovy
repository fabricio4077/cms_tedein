package nth

import nth.seguridad.Shield

class PropiedadesController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [propiedadesInstanceList: Propiedades.list(params), propiedadesInstanceTotal: Propiedades.count()]
    }

    def create = {
        def propiedadesInstance = new Propiedades()
        propiedadesInstance.properties = params
        return [propiedadesInstance: propiedadesInstance]
    }

    def save = {
        def propiedadesInstance = new Propiedades(params)
        if (propiedadesInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), propiedadesInstance.id])}"
            redirect(action: "show", id: propiedadesInstance.id)
        }
        else {
            render(view: "create", model: [propiedadesInstance: propiedadesInstance])
        }
    }

    def show = {
        def propiedadesInstance = Propiedades.get(params.id)
        if (!propiedadesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), params.id])}"
            redirect(action: "list")
        }
        else {
            [propiedadesInstance: propiedadesInstance]
        }
    }

    def edit = {
        def propiedadesInstance = Propiedades.get(params.id)
        if (!propiedadesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [propiedadesInstance: propiedadesInstance]
        }
    }

    def update = {
        def propiedadesInstance = Propiedades.get(params.id)
        if (propiedadesInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (propiedadesInstance.version > version) {

                    propiedadesInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'propiedades.label', default: 'Propiedades')] as Object[], "Another user has updated this Propiedades while you were editing")
                    render(view: "edit", model: [propiedadesInstance: propiedadesInstance])
                    return
                }
            }
            propiedadesInstance.properties = params
            if (!propiedadesInstance.hasErrors() && propiedadesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), propiedadesInstance.id])}"
                redirect(action: "show", id: propiedadesInstance.id)
            }
            else {
                render(view: "edit", model: [propiedadesInstance: propiedadesInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def propiedadesInstance = Propiedades.get(params.id)
        if (propiedadesInstance) {
            try {
                propiedadesInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'propiedades.label', default: 'Propiedades'), params.id])}"
            redirect(action: "list")
        }
    }
}
