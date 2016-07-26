package nth

import nth.seguridad.Shield

class DemosController extends Shield {

    /*
    Demos controller
     */

    def index = { }

    def jpicker = {

    }

    def submenu = {
        def galerias = Galeria.findAllByTipo("Fotos", [sort: "nombre", order: "asc"]);
        [galerias: galerias]
    }

    def verDemo = {
        redirect(action: params.demo)
    }

    def dragNdrop = {

    }

    def getTablaPropiedades = {
        def props = Propiedades.list()
        def propiedades = ""
        def band = false

        propiedades += "id^nombre^mostrar^tipo^explicacion^sufijo^contenido^orden^grupo" + "\n"

        props.each { prop ->
            propiedades += prop.id + "^"
            propiedades += prop.nombre + "^"
            propiedades += prop.mostrar + "^"
            propiedades += prop.tipo + "^"
            propiedades += prop.explicacion + "^"
            propiedades += prop.sufijo + "^"
            propiedades += prop.contenido + "^"
            propiedades += prop.orden + "^"
            propiedades += prop.grupo + "\n"
            band = true
        }

        def cal = Calendar.instance
        def Y = cal.get(Calendar.YEAR)
        def M = cal.get(Calendar.MONTH) + 1
        def D = cal.get(Calendar.DATE)
        def h = cal.get(Calendar.HOUR_OF_DAY)
        def m = cal.get(Calendar.MINUTE)
        def s = cal.get(Calendar.SECOND)
        def path = servletContext.getRealPath("/") + "backups/"
        def filename = Y + M.toString().padLeft(2, "0") + D.toString().padLeft(2, "0") + "_" + h.toString().padLeft(2, "0") + m.toString().padLeft(2, "0") + s.toString().padLeft(2, "0")
        def ext = ".bck"
        new File(path).mkdirs()

        if (band) {
            //delete old files
            def pathD = grailsApplication.parentContext.getResource("backups/").file.toString()
            new File(pathD).eachFileMatch(~/.*.bck/) { file ->
                println "deleting: " + file.name
//                file.delete()
            }

            File backup = new File(path + filename + "_propiedades" + ext)
            backup.write("Propiedades (" + D.toString().padLeft(2, "0") + "-" + M.toString().padLeft(2, "0") + "-" + Y + " " + h.toString().padLeft(2, "0") + ":" + m.toString().padLeft(2, "0") + ":" + s.toString().padLeft(2, "0") + ")\n")

            backup.append(propiedades)
        }
        return [propiedades: propiedades]
    }

    /** ****************** DEMOS DE LAS GALERIAS                                ********************/
    def galleryView = {
        return [files: getFiles(false)]
    }

    def galleryViewText = {
        def pags = Pagina.list()
        return [pags: pags]
    }

    def cloudCarousel = {
        return [files: getFiles(10)]
    }
    def squares = {
        return [files: getFiles(false)]
    }
    def gallerific = {
        return [files: getFiles(false)]
    }
    def spaceGallery = {
        return [files: getFiles(10)]
    }
    def jCycle = {
        return [files: getFiles(false)]
    }
    def imageFlow = {
        return [files: getFiles(false)]
    }
    def polaroid = {
        return [files: getFiles(false)]
    }
    def eoGallery = {
        return [files: getFiles(false)]
    }

    def awkward = {
        return [files: getFiles(false)]
    }
    def awkwardText = {
        def pags = Pagina.findAllByFotoIsNotNull()
        println pags
        return [pags: pags]
    }

    /** ****************** FIN DEMOS DE LAS GALERIAS                                ********************/
    List getFiles(max) {
        def path = grailsApplication.parentContext.getResource("images/tux/").file.toString()
        def files = []
        def i = 0;
        new File(path).eachFile { f ->
            if (!max || i < max) {
                if (f.isFile()) {
                    def m = [:]
                    m.file = f.name
                    m.title = "Titulo: " + f.name
                    m.descripcion = "Descripcion: " + f
                    files.add(m)
                    i++
                }
            }
        }
        return files
    }

}
