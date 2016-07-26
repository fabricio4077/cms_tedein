package nth

class TipoPagina {

    String nombre
    String descripcion
    Sitio sitio
    Pagina pagina
    Layout layout

    int mostrar = 0

    static constraints = {
        nombre(nullable: false, blank: false, size: 3..20)
        descripcion(nullable: true, blank: true)
        sitio(blank: true, nullable: true)
        pagina(blank: true, nullable: true)
        layout(blank:true, nullable: true)
        mostrar(blank: true, nullable: true)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'tppg'
        id column: 'tppg__id'
        nombre column: 'tppgnmbr'
        descripcion column: 'tppgdscr'
        sitio column: 'stio__id'
        pagina column: 'pgna__id'
        layout column: 'layt__id'
        mostrar column: 'tppgmstr'
    }

    String toString() {
        return this.nombre
    }
}
