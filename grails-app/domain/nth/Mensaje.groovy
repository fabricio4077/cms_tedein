package nth

class Mensaje {

    Sitio sitio
    String mensaje
    String estado
    UsuarioSitio usuario

    static constraints = {
        sitio(blank: false, nullable: false)
        mensaje(blank: false, nullable: false)
        estado(blank: false, nullable: false, size: 1..5, inList: ["N", "A"])
        usuario(blank: false, nullable: false)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'mnsj'
        id column: 'mnsj__id'
        sitio column: 'stio__id'
        mensaje column: 'mnsjmnsj'
        mensaje type: 'text'
        estado column: 'mnsjetdo'
        usuario column: 'usst__id'
    }

    String toString() {
        return this.mensaje
    }
}
