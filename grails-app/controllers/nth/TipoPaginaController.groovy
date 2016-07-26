package nth

import nth.seguridad.Shield

class TipoPaginaController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoPaginaInstanceList: TipoPagina.list(params), tipoPaginaInstanceTotal: TipoPagina.count()]
    }

    def create = {
        def tipoPaginaInstance = new TipoPagina()
        tipoPaginaInstance.properties = params
        return [tipoPaginaInstance: tipoPaginaInstance]
    }

    def save = {
        def tipoPaginaInstance = new TipoPagina(params)
        if (tipoPaginaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), tipoPaginaInstance.id])}"
            redirect(action: "show", id: tipoPaginaInstance.id)
        }
        else {
            render(view: "create", model: [tipoPaginaInstance: tipoPaginaInstance])
        }
    }

    def show = {
        def tipoPaginaInstance = TipoPagina.get(params.id)
        if (!tipoPaginaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tipoPaginaInstance: tipoPaginaInstance]
        }
    }

    def edit = {
        def tipoPaginaInstance = TipoPagina.get(params.id)
        if (!tipoPaginaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [tipoPaginaInstance: tipoPaginaInstance]
        }
    }

    def update = {
        def tipoPaginaInstance = TipoPagina.get(params.id)
        if (tipoPaginaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoPaginaInstance.version > version) {

                    tipoPaginaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoPagina.label', default: 'TipoPagina')] as Object[], "Another user has updated this TipoPagina while you were editing")
                    render(view: "edit", model: [tipoPaginaInstance: tipoPaginaInstance])
                    return
                }
            }
            tipoPaginaInstance.properties = params
            if (!tipoPaginaInstance.hasErrors() && tipoPaginaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), tipoPaginaInstance.id])}"
                redirect(action: "show", id: tipoPaginaInstance.id)
            }
            else {
                render(view: "edit", model: [tipoPaginaInstance: tipoPaginaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def tipoPaginaInstance = TipoPagina.get(params.id)
        if (tipoPaginaInstance) {
            try {
                tipoPaginaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoPagina.label', default: 'TipoPagina'), params.id])}"
            redirect(action: "list")
        }
    }
}
