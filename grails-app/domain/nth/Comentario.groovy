package nth

class Comentario {

    String nombre
    String mail
    String url

    String texto
    String foto

    Date fecha

    String estado

    Seccion seccion


    static constraints = {
        nombre(maxSize: 50, blank: true, nullable: true)
        mail(maxSize: 128, blank: true, nullable: true)
        url(maxSize: 128, blank: true, nullable: true)

        texto(maxSize: 5000, blank: false, nullable: false)
        foto(blank: true, nullable: true)

        fecha(blank: false, nullable: false)

        estado(inList: ["Rechazado", "Publicado"], blank: false, nullable: false)

        seccion(blank: false, nullable: false)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'cmnt'
        id column: 'cmnt__id'

        nombre column: 'cmntnmbr'
        mail column: 'cmntmail'
        url column: 'cmnt_url'

        texto column: 'cmnttxto'
        texto type: 'text'
        foto column: 'cmntfoto'
        foto type: 'text'

        fecha column: 'cmntfcha'

        estado column: 'cmntetdo'

        seccion column: 'sccn__id'
    }
}
