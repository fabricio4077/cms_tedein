package nth

import nth.seguridad.Shield

class LayoutController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [layoutInstanceList: Layout.list(params), layoutInstanceTotal: Layout.count()]
    }

    def create = {
        def layoutInstance = new Layout()
        layoutInstance.properties = params
        return [layoutInstance: layoutInstance]
    }

    def save = {
        def layoutInstance = new Layout(params)
        if (layoutInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'layout.label', default: 'Layout'), layoutInstance.id])}"
            redirect(action: "show", id: layoutInstance.id)
        }
        else {
            render(view: "create", model: [layoutInstance: layoutInstance])
        }
    }

    def show = {
        def layoutInstance = Layout.get(params.id)
        if (!layoutInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'layout.label', default: 'Layout'), params.id])}"
            redirect(action: "list")
        }
        else {
            [layoutInstance: layoutInstance]
        }
    }

    def edit = {
        def layoutInstance = Layout.get(params.id)
        if (!layoutInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'layout.label', default: 'Layout'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [layoutInstance: layoutInstance]
        }
    }

    def update = {
        def layoutInstance = Layout.get(params.id)
        if (layoutInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (layoutInstance.version > version) {
                    
                    layoutInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'layout.label', default: 'Layout')] as Object[], "Another user has updated this Layout while you were editing")
                    render(view: "edit", model: [layoutInstance: layoutInstance])
                    return
                }
            }
            layoutInstance.properties = params
            if (!layoutInstance.hasErrors() && layoutInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'layout.label', default: 'Layout'), layoutInstance.id])}"
                redirect(action: "show", id: layoutInstance.id)
            }
            else {
                render(view: "edit", model: [layoutInstance: layoutInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'layout.label', default: 'Layout'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def layoutInstance = Layout.get(params.id)
        if (layoutInstance) {
            try {
                layoutInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'layout.label', default: 'Layout'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'layout.label', default: 'Layout'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'layout.label', default: 'Layout'), params.id])}"
            redirect(action: "list")
        }
    }
}
