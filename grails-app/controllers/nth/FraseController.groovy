package nth

import nth.seguridad.Shield

class FraseController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fraseInstanceList: Frase.list(params), fraseInstanceTotal: Frase.count()]
    }

    def create = {
        def fraseInstance = new Frase()
        fraseInstance.properties = params
        return [fraseInstance: fraseInstance]
    }

    def save = {
        def fraseInstance = new Frase(params)
        if (fraseInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'frase.label', default: 'Frase'), fraseInstance.id])}"
            redirect(action: "show", id: fraseInstance.id)
        }
        else {
            render(view: "create", model: [fraseInstance: fraseInstance])
        }
    }

    def show = {
        def fraseInstance = Frase.get(params.id)
        if (!fraseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'frase.label', default: 'Frase'), params.id])}"
            redirect(action: "list")
        }
        else {
            [fraseInstance: fraseInstance]
        }
    }

    def edit = {
        def fraseInstance = Frase.get(params.id)
        if (!fraseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'frase.label', default: 'Frase'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [fraseInstance: fraseInstance]
        }
    }

    def update = {
        def fraseInstance = Frase.get(params.id)
        if (fraseInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (fraseInstance.version > version) {
                    
                    fraseInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'frase.label', default: 'Frase')] as Object[], "Another user has updated this Frase while you were editing")
                    render(view: "edit", model: [fraseInstance: fraseInstance])
                    return
                }
            }
            fraseInstance.properties = params
            if (!fraseInstance.hasErrors() && fraseInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'frase.label', default: 'Frase'), fraseInstance.id])}"
                redirect(action: "show", id: fraseInstance.id)
            }
            else {
                render(view: "edit", model: [fraseInstance: fraseInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'frase.label', default: 'Frase'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def fraseInstance = Frase.get(params.id)
        if (fraseInstance) {
            try {
                fraseInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'frase.label', default: 'Frase'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'frase.label', default: 'Frase'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'frase.label', default: 'Frase'), params.id])}"
            redirect(action: "list")
        }
    }
}
