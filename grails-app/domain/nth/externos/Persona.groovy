package nth.externos

class Persona {

    String nombre
    String apellido
    String email
    String telefono
    String celular
    String comentario

    Curso curso

    Integer contactado = 0

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'prsn'
        columns {
            id column: 'prsn__id'
            nombre column: 'prsnnmbr'
            apellido column: 'prsnapll'
            email column: 'prsnmail'
            telefono column: 'prsntlfn'
            celular column: 'prsncllr'
            comentario column: 'prsncmnt'

            curso column: 'crso__id'
            contactado column: 'prsncntc'
        }
    }

    static constraints = {
        nombre blank: false, nullable: false, maxSize: 127
        apellido blank: false, nullable: false, maxSize: 127
        email blank: false, nullable: false, maxSize: 127, email: true
        telefono blank: true, nullable: true, maxSize: 127
        celular blank: true, nullable: true, maxSize: 127
        comentario blank: true, nullable: true, maxSize: 127
    }
}
