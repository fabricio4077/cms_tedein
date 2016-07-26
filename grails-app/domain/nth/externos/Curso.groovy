package nth.externos

class Curso {

    String nombre

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'crso'
        columns {
            id column: 'crso__id'
            nombre column: 'crsonmbr'
        }
    }

    static constraints = {
        nombre maxSize: 100
    }
}
