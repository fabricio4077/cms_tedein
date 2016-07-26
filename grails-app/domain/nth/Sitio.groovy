package nth

class Sitio {

    String nombre
    String organizacion
    String contacto
    String telefono
    String tipoMenu
    Integer principal = 0

    static constraints = {
        nombre(nullable: false, blank: false, size: 3..20)
        organizacion(nullable: false, blank: false, size: 3..60)
        contacto(nullable: true, blank: true, size: 1..100)
        telefono(nullable: true, blank: true, size: 1..10)
        tipoMenu(blank: true, nullable: true, inList: ["deepBlue","menu1","menu2","menu3","menu4"], size: 3..20)
        principal(nullable: true, blank: true)
    }

    static mapping = {
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'

        table 'stio'
        id column: 'stio__id'
        nombre column: 'stionmbr'
        organizacion column: 'stioorgn'
        contacto column: 'stiocntc'
        telefono column: 'stiotlfn'
        tipoMenu column: 'stiotpmn'
        principal column: 'stioprnc'
    }

    String toString() {
        return this.nombre
    }
}
