package nth

class Frase {

    String frase
    Pagina pagina
    Idioma idioma
    String estado
    Seccion seccion
    Galeria galeria
    Foto foto
    Video video
    String tags
    String tipo

    String otros

    int orden = 1

    static constraints = {
        idioma(nullable: false, blank: false)
        estado(inList: ["Borrador", "Revisado", "Publicado"], blank: false, nullable: false)
        frase(blank: true, nullable: true)
        seccion(blank: true, nullable: true)
        foto(blank: true, nullable: true)
        galeria(blank: true, nullable: true)
        video(blank: true, nullable: true)
        tags(blank: true, nullable: true, size: 1..200)
        tipo(blank: true, nullable: true/*, inList: ["Titulo", "Descripcion"]*/)
        pagina(blank: true, nullable: true)
        orden(blank: false, nullable: false)

        otros(blank: true, nullable: true)

    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'frse'
        id column: 'frse__id'
        frase column: 'frsefrse'
        frase type: 'text'
        pagina column: 'pgna__id'
        idioma column: 'idma__id'
        estado column: 'frseetdo'
        seccion column: 'sccn__id'
        galeria column: 'glra__id'
        foto column: 'foto__id'
        video column: 'vdeo__id'
        tags column: 'frsetags'
        tipo column: 'frsetipo'

        orden column: 'frseordn'

        otros column: 'frseotro'
        otros type: 'text'
    }

    String toString() {
        "${this.frase}"
    }
}
