package nth

class LoginController {

    def index = {
        return [files: getFiles(4)]
    }

    def login = {
        println "LOGIN " //+ params
        def usuario = Usuario.findByLoginAndPass(params.login, (params.pass).encodeAsMD5());
        println "USUARIO: " + usuario
        if (usuario != null) {
            session.usuario = usuario;
            redirect(controller: "editor", action: "sitios")

        } else {
            flash.message = "ERROR: No se encontr&oacute; la combinación usuario/contraseña ingresada."
            flash.clase = 'ui-state-error ui-corner-all'
            redirect(action: "index")
        }
    } //login

    def logout = {
        if (session.usuario) {
            session.usuario = null
            redirect(action: "index")
        } else {
            redirect(action: 'index')
        }
    }

    def edit = {
        println session
    }



    List getFiles(max) {
        def path = grailsApplication.parentContext.getResource("images/wow/").file.toString()
        def files = []
        def i = 0;
        new File(path).eachFile { f ->
            if (!max || i < max) {
                if (f.isFile()) {
                    def m = [:]
                    m.file = f.name
                    m.title = "Titulo: " + f.name
                    m.descripcion = "Descripcion: " + f
                    files.add(m)
                    i++
                }
            }
        }
        return files
    }
}
