package nth

class Idioma {

    String nombre
    byte[] imagen
    String abreviacion

    static constraints = {
        nombre(blank: false, nullable: false, size: 1..20)
        imagen(blank: true, nullable: true)
        abreviacion(blank: false, nullable: false)
    }

    static mapping = {
        cache usage:'read-write', include:'non-lazy'
        id generator:'identity'
        
        table 'idma'
        id column: 'idma__id'
        nombre column: 'idmanmbr'
        imagen column: 'idmaimgn'
        abreviacion column: 'idmaabrv'
    }

    public String toString() {
        "${this.nombre}"
    }

}
