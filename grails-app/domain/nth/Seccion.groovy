package nth

class Seccion {
    Pagina pagina
    String nombre
    String css
    Integer top
    Integer izq
    Integer width
    Integer height
    String tipo
    Foto foto
    Video video
    Galeria galeria
    Pagina contenido
    Integer cantidad

    static hasMany = [frases: Frase]

    static constraints = {
        pagina(blank: true, nullable: true)
        nombre(blank: true, nullable: true, size: 1..30)
        css(blank: true, nullable: true, size: 0..1024)
        top(blank: false, nullable: false)
        izq(blank: false, nullable: false)
        width(blank: false, nullable: false)
        height(blank: false, nullable: false)
        tipo(blank: false, nulllable: false, inList: [
                "Texto",
                "Foto",
                "Video",
                "Galeria",
                "Publicaciones",
                "GuestBook",
                "Layout",
                "Vacio",
                "Contenido",
                "Link",
                "Contacto",
                "Descarga"
        ])
        foto(blank: true, nullable: true)
        video(blank: true, nullable: true)
        galeria(blank: true, nullable: true)
        contenido(blank: true, nullable: true)
        cantidad(blank: true, nullable: true)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'sccn'
        id column: 'sccn__id'
        pagina column: 'pgna__id'
        nombre column: 'sccnnmbr'
        css column: 'sccn_css'
        top column: 'sccn_top'
        izq column: 'sccn_izq'
        width column: 'sccnwdth'
        height column: 'sccn_hght'
        tipo column: 'sccntipo'
        foto column: 'foto__id'
        video column: 'vdeo__id'
        galeria column: 'glra__id'
        contenido column: 'sccncntn'
        cantidad column: 'sccncant'
    }

    String toString() {
        return this.nombre
    }
}
