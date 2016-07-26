package nth

import nth.seguridad.Shield

class FotoController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fotoInstanceList: Foto.list(params), fotoInstanceTotal: Foto.count()]
    }

    def create = {
        def fotoInstance = new Foto()
        fotoInstance.properties = params
        return [fotoInstance: fotoInstance]
    }

    def save = {
        def fotoInstance = new Foto(params)
        if (fotoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'foto.label', default: 'Foto'), fotoInstance.id])}"
            redirect(action: "show", id: fotoInstance.id)
        }
        else {
            render(view: "create", model: [fotoInstance: fotoInstance])
        }
    }

    def show = {
        def fotoInstance = Foto.get(params.id)
        if (!fotoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'foto.label', default: 'Foto'), params.id])}"
            redirect(action: "list")
        }
        else {
            [fotoInstance: fotoInstance]
        }
    }

    def edit = {
        def fotoInstance = Foto.get(params.id)
        if (!fotoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'foto.label', default: 'Foto'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [fotoInstance: fotoInstance]
        }
    }

    def update = {
        def fotoInstance = Foto.get(params.id)
        if (fotoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (fotoInstance.version > version) {
                    
                    fotoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'foto.label', default: 'Foto')] as Object[], "Another user has updated this Foto while you were editing")
                    render(view: "edit", model: [fotoInstance: fotoInstance])
                    return
                }
            }
            fotoInstance.properties = params
            if (!fotoInstance.hasErrors() && fotoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'foto.label', default: 'Foto'), fotoInstance.id])}"
                redirect(action: "show", id: fotoInstance.id)
            }
            else {
                render(view: "edit", model: [fotoInstance: fotoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'foto.label', default: 'Foto'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def fotoInstance = Foto.get(params.id)
        if (fotoInstance) {
            try {
                fotoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'foto.label', default: 'Foto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'foto.label', default: 'Foto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'foto.label', default: 'Foto'), params.id])}"
            redirect(action: "list")
        }
    }
}
