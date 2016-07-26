package nth

class UsuarioSitio {

    String nombre
    String apellido
    String email
    String pass
    Sitio sitio
    TipoUsuario tipo

    static constraints = {
        nombre(blank: false, nullable: false, size: 1..40)
        apellido(blank: false, nullable: false, size: 1..40)
        email(blank: false, nullable: false, size: 1..60)
        sitio(nullable: false, blank: false)
        tipo(nullable: true, blank: true)
        pass(nullable: true, blank: true, size: 1..255)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'usst'
        id column: 'usst__id'
        nombre column: 'usstnmbr'
        apellido column: 'usstapll'
        email column: 'usstemail'
        pass column: 'usstpssw'
        sitio column: 'stio__id'
        tipo column: 'tpus__id'
    }

    String toString() {
        return this.nombre
    }
}
