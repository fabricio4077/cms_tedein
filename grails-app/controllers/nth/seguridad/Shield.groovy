package nth.seguridad

class Shield {
    def beforeInterceptor = [action: this.&auth, except: 'login']
    /**
     * Verifica si se ha iniciado una sesión
     */
    def auth() {
        if (!session.usuario) {
            redirect(controller: 'login', action: 'index')
            session.finalize()
            return false
        } else {

            /*Todo aqui verificar permisos del usuario*/
            return true
        }
//        return true
    }
}