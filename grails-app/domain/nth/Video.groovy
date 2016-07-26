package nth

class Video {

    String titulo
    String descripcion
    String codigo
    String thumbnail
    Galeria galeria
    String tags

    static hasMany = [frases: Frase]

    static constraints = {
        codigo(blank: false, nullable: false)
        thumbnail(blank: true, nullable: true)
        titulo(blank: true, nullable: true)
        descripcion(blank: true, nullable: true)
        galeria(blank: true, nullable: true)
        tags(blank: true, nullable: true, size: 1..200)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'vdeo'
        id column: 'vdeo__id'
        codigo column: 'vdeocdgo'
        titulo column: 'vdeottlo'
        descripcion column: 'vdeodscr'
        thumbnail column: 'vdeothmb'
        galeria column: 'glra__id'
        tags column: 'vdeotags'
    }

    String toString() {
        return "Video: " + this.codigo
    }

}
