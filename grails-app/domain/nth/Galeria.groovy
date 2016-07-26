package nth

class Galeria {
    String nombre
    String tipo
    String tags
    String layout
    String propiedades
    Layout layoutContenido
    Sitio sitio
//    String contenido

    static hasMany = [frases: Frase, fotos: Foto, videos: Video, paginas: Pagina]

    static constraints = {
        nombre(blank: false, nullable: false, size: 1..20)
        tipo(blank: false, nullable: false, inList: ["Fotos", "Videos", "Texto"])
        tags(blank: true, nullable: true, size: 1..200)
        layout(blank: false, nullable: false)
        propiedades(blank: true, nullable: true, size:0..5000)
        layoutContenido(blank: true, nullable: true)
        sitio(blank: false,nullable: false)
//        contenido(blank: false, nullable: false, inList: ["Imagen", "Texto"])
    }

    static mapping = {
        cache usage:'read-write', include:'non-lazy'
        id generator:'identity'
        
        table 'glra'
        id column: 'glra__id'
        nombre column: 'glranmbr'
        tipo column: 'glratipo'
        tags column: 'glratags'
        layout column: 'glralayt'
        propiedades column: 'glraprpd'
        layoutContenido column: 'layt__id'
        sitio column: 'stio__id'
    }

    String toString() {
        return this.nombre
    }
}
