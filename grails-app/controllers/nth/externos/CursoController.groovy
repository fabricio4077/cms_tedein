package nth.externos

import nth.seguridad.Shield

class CursoController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def inscritos = {

    }

    def tablaInscritos = {
        def curso = Curso.get(params.curso)
        def estado = params.estado.toInteger()

        def personas = Persona.withCriteria {
            eq("curso", curso)
            if (estado > -1) {
                eq("contactado", estado)
            }
            order("apellido", "asc")
        }
        return [personas: personas]
    }

    def cambiarEstado = {
        def persona = Persona.get(params.id)
        persona.contactado = params.estado.toInteger()
        if (persona.save(flush: true)) {
            render "OK"
        } else {
            render "NO"
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cursoInstanceList: Curso.list(params), cursoInstanceTotal: Curso.count()]
    }

    def create = {
        def cursoInstance = new Curso()
        cursoInstance.properties = params
        return [cursoInstance: cursoInstance]
    }

    def save = {
        def cursoInstance = new Curso(params)
        if (cursoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'curso.label', default: 'Curso'), cursoInstance.id])}"
            redirect(action: "show", id: cursoInstance.id)
        } else {
            render(view: "create", model: [cursoInstance: cursoInstance])
        }
    }

    def show = {
        def cursoInstance = Curso.get(params.id)
        if (!cursoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'curso.label', default: 'Curso'), params.id])}"
            redirect(action: "list")
        } else {
            [cursoInstance: cursoInstance]
        }
    }

    def edit = {
        def cursoInstance = Curso.get(params.id)
        if (!cursoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'curso.label', default: 'Curso'), params.id])}"
            redirect(action: "list")
        } else {
            return [cursoInstance: cursoInstance]
        }
    }

    def update = {
        def cursoInstance = Curso.get(params.id)
        if (cursoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (cursoInstance.version > version) {

                    cursoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'curso.label', default: 'Curso')] as Object[], "Another user has updated this Curso while you were editing")
                    render(view: "edit", model: [cursoInstance: cursoInstance])
                    return
                }
            }
            cursoInstance.properties = params
            if (!cursoInstance.hasErrors() && cursoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'curso.label', default: 'Curso'), cursoInstance.id])}"
                redirect(action: "show", id: cursoInstance.id)
            } else {
                render(view: "edit", model: [cursoInstance: cursoInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'curso.label', default: 'Curso'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def cursoInstance = Curso.get(params.id)
        if (cursoInstance) {
            try {
                cursoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'curso.label', default: 'Curso'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'curso.label', default: 'Curso'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'curso.label', default: 'Curso'), params.id])}"
            redirect(action: "list")
        }
    }
}
