package nth

class Pagina {
    Sitio sitio
    String nombre
    Integer orden
    Layout layout
    String tipo
    Foto foto
    Galeria galeria
    TipoPagina tipoPagina
    Date fecha = new Date()

    static hasMany = [secciones: Seccion, menu: Frase, titulos: Frase]

    static constraints = {
        nombre(blank: false, nullable: false, size: 1..20)
        layout(blank: true, nullable: true)
        sitio(blank: true, nullable: true)
        tipo(blank: true, nullable: true, inList: ["Principal", "Secundaria", "Galeria"])
        tipoPagina(blank: true, nullable: true)
        orden(blank: false, nullable: false)
        foto(blank: true, nullable: true)
        galeria(blank: true, nullable: true)
        fecha(blank: true, nullable: true)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'pgna'
        id column: 'pgna__id'
        sitio column: 'stio__id'
        nombre column: 'pgnanmbr'
        orden column: 'pgnaordn'
        layout column: 'layt__id'
        tipo column: 'pgnatipo'
        foto column: 'foto__id'
        galeria column: 'glra__id'
        tipoPagina column: 'tppg__id'
        fecha column: 'pgnafcha'
    }

    String toString() {
        "${this.nombre}"
    }
}
