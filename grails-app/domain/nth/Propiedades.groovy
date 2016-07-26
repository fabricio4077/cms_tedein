package nth

class Propiedades {
    String nombre
    String mostrar
    String tipo
    String explicacion
    String sufijo
    String contenido
    Integer orden
    String grupo

    static constraints = {
        nombre(blank: false, nullable: false, size: 1..30)
        mostrar(blank: false, nullable: false, size: 1..30)
        tipo(size: 1..10000)
        explicacion(blank: true, nullable: true, size: 1..10000)
        sufijo(blank: true, nullable: true, size: 1..5)
        contenido(blank: true, nullable: true, size: 1..10000)
        orden(blank: false, nullable: false)
        grupo(blank: false, nullable: false)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'prpd'
        id column: 'prpd__id'
        nombre column: 'prpdnmbr'
        mostrar column: 'prpdmstr'
        tipo column: 'prpdtipo'
        explicacion column: 'prpdexpl'
        explicacion type: 'text'
        sufijo column: 'prpdsfjo'
        contenido column: 'prpdcntn'
        contenido type: 'text'
        orden column: 'prpdordn'
        grupo column: 'prpdgrpo'
    }

    String toString() {
        return this.mostrar
    }

}
