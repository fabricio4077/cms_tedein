package nth

class GuestbookTagLib {
    static namespace = "gbk"

    def displayItem = { params ->

        def edit = params.edit ? params.edit : false
        def max = params.max ? params.max : 800
        def seccion = Seccion.get(params.seccion)
        def item = Comentario.get(params.id)
//        def anonimo = Frase.findByTipoAndIdioma("gb_Anonimo", session.idioma)

        def anonimo = Frase.withCriteria {
            and {
                eq("tipo", "gb_Anonimo")
                eq("idioma", session.idioma)
                eq("seccion", seccion)
            }
        }
        anonimo = anonimo[0]

        def str = ""

        str += "<div class='comentario'>"
        str += "<div class='fecha'>"
        str += g.formatDate(date: item.fecha, format: "dd-MM-yyyy hh:mm")

        if (edit) {
            str += "<a href='#' id='del_${item.id}' style='margin-left:10px;'>Eliminar</a>"
            str += "<script type='text/javascript'>"
            str += '$(function() {'
            str += '$("#del_' + item.id + '").click(function() {'
            str += 'var btn = $(this);'
            str += 'if(confirm("Esta seguro de querer eliminar este comentario? Esta acción no se puede deshacer...")) {'
            str += '$.ajax({'
            str += 'type: "POST",'
            str += 'url: "' + g.createLink(controller: 'guestbook', action: 'deleteComment', id: item.id) + '",'
            str += 'success: function(msg) {'
            str += "btn.parents('.comentario').remove();"
            str += '}'
            str += '});'
            str += '}'
            str += "return false;"
            str += '});'
            str += '})'
            str += "</script>"
        }

        str += '</div>'

        str += "<div class='nombre ui-state-default ui-corner-all'>"
        if (item.nombre && item.nombre?.trim() != "") {
            str += item.nombre
        } else {
            str += anonimo
        }
        str += '</div>'

        if (item.foto) {
            str += "<div class='foto'>"
            def path = g.resource(dir: 'fotos/' + item.seccion.pagina.sitio.nombre + "/" + item.seccion.pagina.nombre, file: item.foto)
            str += "<a href='${path}' id='foto_${item.id}' rel='prettyPhoto' title='${item.texto}' >"
            str += "<img src='${path}' height='75' />"
            str += "</a>"
            str += '</div>'

            str += "<script type='text/javascript'>"
            str += '$(function() {'
            str += '$("#foto_' + item.id + '").prettyPhoto();'
            str += '})'
            str += "</script>"
        }
        str += "<div class='texto ui-corner-all'"
        if (!item.foto) {
            str += " style='width: ${max - 50}' "
        }
        str += ">"
        str += item.texto
        str += '</div>'



        str += '</div>'
        out << str

    }

}
