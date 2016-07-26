package nth

class TipoUsuario {

    String nombre
    String descripcion

    static constraints = {
        nombre(blank: false,nullable: false,size: 1..20)
        descripcion(blank: false,nullable: false,size: 1..100)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'tpus'
        id column: 'tpus__id'
        nombre column: 'tpusnmbr'
        descripcion column: 'tpusdscr'
    }

    String toString() {
        return this.nombre
    }
}
