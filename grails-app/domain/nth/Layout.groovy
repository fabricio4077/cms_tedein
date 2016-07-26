package nth

class Layout {
    String nombre
    String descripcion
    Seccion contenido
    Seccion menu
    Seccion banner
    Seccion idioma
    String css
    Sitio sitio

    String tipoIdioma
    String cssIdioma

    static constraints = {
        contenido(blank: false, nullable: false)
        menu(blank: true, nullable: true)
        banner(blank: true, nullable: true)
        idioma(blank: true, nullable: true)
        nombre(blank: false, nullable: false)
        descripcion(blank: true, nullable: true, size: 4..30)
        css(blank: true, nullable: true, size: 1..300)
        sitio(blank: false, nullable: false)

        tipoIdioma(blank: true, nullable: true)
        cssIdioma(blank: true, nullable: true)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'layt'
        id column: 'layt__id'
        nombre column: 'laytnmbr'
        descripcion column: 'laytdscr'
        contenido column: 'laytcntn'
        menu column: 'laytmenu'
        banner column: 'laytbnnr'
        idioma column: 'laytidma'
        css column: 'layt_css'
        sitio column: 'stio__id'

        tipoIdioma column: 'layttpid'
        cssIdioma column: 'laytcsid'
    }

    String toString() {
        "${this.nombre}"
    }
}
