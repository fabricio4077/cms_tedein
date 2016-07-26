package nth

import nth.seguridad.Shield

class MenuController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def mostrarTodos = {

    }

    def mostrarMenu = {
        def tipo = params.id
        [tipo:tipo]
    }

    def guardarTipo = {
        if(session.sitio){
            println "guardar tipo "+params
            session.sitio.tipoMenu=params.tipo
            if(session.sitio.save(flush:true)){
                println "si guardo bien"
                render "ok"
            }else{
                println "errores "+session.sitio.errors
                render "no"
            }
        }else{
            render "no"
        }
    }
}
