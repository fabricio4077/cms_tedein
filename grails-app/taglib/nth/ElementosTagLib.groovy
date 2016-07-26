package nth

class ElementosTagLib {
    static namespace = "elm"

    def barrita = { params, body ->
        def btns = params.botones

        def bordes = params.bordes
        if (bordes.toString() == "null") {
            bordes = ""
        }

        def str = '<h3 class="ui-widget-header ' + bordes + ' barrita" id="barra_' + params.id + '" ' + params.param + ' style="padding-top:2px;">'

        str += '<span style="font-family:arial; font-size:14px; font-variant:normal; font-style:normal;" class="barrita_titulo">' + params.title + '</span>'

        btns.eachWithIndex { b, i ->
            def c
            switch (b) {
                case "eliminar":
                    c = "closethick delete "
                    break;
                case "propiedades":
                    c = "pencil propiedades ";
                    break;
                case "editar":
                    c = "document contenido "
                    break;
                default:
                    c = ""
                    break;
            }
            if (i == 0) {
                if (params.float == "right") {
                    c += "rightmost"
                } else if (params.float == "left") {
                    c += "leftmost"
                }
            }
            str += "<div class='ui-icon ui-icon-" + c + " botoncito " + params.float + "' title='" + b.capitalize() + "' ></div>"
        }

        str += '</h3>'

        out << str
    }

    def colorPicker = { params ->

        def name = params.name
        def id = params.id

        params["class"] += " colP ui-corner-all"
        params.value = params.valor


        def field = g.textField(params)

        def js = ""
        js += '<script type="text/javascript">' + "\n"
        js += '$(function() {' + "\n"

        js += 'function colorFondo(hex, item) {' + "\n"
        js += 'var r=hex.substring(1,3);' + "\n"
        js += 'var g=hex.substring(3,5);' + "\n"
        js += 'var b=hex.substring(5,7);' + "\n"
        js += 'r = parseInt(r,16);'
        js += 'g = parseInt(g,16);'
        js += 'b = parseInt(b,16);'
        js += 'var color = r+g+b;'
        js += 'if(color>382) {'
        js += 'item.css("color","black");'
        js += '} else {'
        js += 'item.css("color","white");'
        js += '}'
        js += 'item.css("background",hex);'
        js += '}' + "\n"

        js += 'var col = $("#' + id + '").val();' + "\n"
        js += 'colorFondo(col,$("#' + id + '"));' + "\n"

        js += '$("#' + id + '").ColorPicker({' + "\n"
        js += 'onSubmit: function(hsb, hex, rgb, el) {' + "\n"
        js += '$(el).val("#"+hex);' + "\n"
        js += 'colorFondo("#"+hex,$(el));'
        js += '$(el).ColorPickerHide();' + "\n"
        js += '},' + "\n"
        js += 'onChange: function(hsb, hex, rgb, el) {' + "\n"
        js += '$(el).val("#"+hex);' + "\n"
        js += 'colorFondo("#"+hex,$(el));'
        js += '$(el).ColorPickerHide();' + "\n"
        js += '},' + "\n"
        js += 'onBeforeShow: function () {' + "\n"
        js += '$(this).ColorPickerSetColor(this.value);' + "\n"
        js += '}' + "\n"
        js += '})' + "\n"
        js += '.bind("keyup", function(){' + "\n"
        js += '$(this).ColorPickerSetColor(this.value);' + "\n"
        js += '});' + "\n"
        js += '});' + "\n"
        js += '</script>' + "\n"

        // out << imports
        //out << css
        out << js
        out << field
    }

    def item = { params ->

        def valor = params.remove("value")
        def prop = params.remove("propiedad")
        def cont = prop.contenido

        if (valor && params.sufijo != null) {
            valor = valor.replaceAll(params.sufijo, "")
        }

        def parts = cont?.split(" ")

        if (!parts || parts.size() < 1) {
            parts = []
            parts[0] = ""
        }

        def pid = params.remove("id")
        def id = (pid.is(null)) ? prop.nombre : pid
        def pname = params.remove("name")
        def name = (pname.is(null)) ? prop.nombre : pname

        def attrs = params
        attrs.name = name
        attrs.id = id

        if (!attrs["class"]) {
            attrs["class"] = ""
        }

        switch (parts[0]) {
            case "number":
//                println "\n\n"
//                println parts
//                println "\n\n"
                def tmp = parts[1]
                def min = tmp.substring(4)
                tmp = parts[2]
                def max = tmp.substring(4)
                tmp = parts[3]
                def stp = tmp.substring(5)
                tmp = parts[4]
                def dfl = tmp.substring(4)

                def list = [:]

                def i

                list[-1] = "--Seleccione--"
                for (i = min.toInteger(); i <= max.toInteger(); i += stp.toInteger()) {
                    list[i] = i
                }
                if (valor.is(null)) {
                    valor = dfl
                }

                attrs.value = valor
                attrs.from = list
                attrs.optionValue = "value"
                attrs.optionKey = "key"
                attrs["class"] += " ui-corner-all"

                out << g.select(attrs)

                break;
            case 'bool':
                if (valor.is(null)) {
                    valor = true
                }

                attrs.checked = valor
                attrs.value = true

                out << g.checkBox(attrs)
                break;
            case "map":
                if (valor.is(null)) {
                    valor = "-1"
                }
                def m = cont.substring(3)
                def p = m.split(",")

                m = [:]
                m[-1] = "--Seleccione--"
                p.each {
                    def pp = it.split(":")
                    m[(pp[0]).trim()] = (pp[1]).trim()
                }

                attrs.from = m
                attrs.optionValue = "value"
                attrs.optionKey = "key"
                attrs["class"] += " ui-corner-all"
                attrs.value = valor

                out << g.select(attrs)
                break;
            case "color":
                attrs.prop = prop
                attrs.valor = valor
                out << elm.colorPicker(attrs)
                break;
            case "file":
                def html = '<input type="file" id="' + id + '" name="' + name + '"'
                html += outputAttributes(attrs)
                html += '/>'
                out << html
                break;
            default:
                attrs.value = valor
                attrs["class"] += " ui-corner-all"
                out << g.textField(attrs)
        }
    }

    def dialogPropiedades = { params ->

        def id = params.id
        def title = params.title
        def from = params.from
        def gal = params.galeria

        def propiedades = [:]
        if (gal) {
            def prop = gal.propiedades
            def props = prop?.split(",")

            if (props?.size() > 0) {
                props.each {
                    def p = it.split(":")
                    if (p.size() == 2) {
                        propiedades[p[0]] = p[1]
                    }
                }
            }
        }

        def html = ""
        def bl = "\n"

        def grp = ""

        html += '<div id="' + id + '" title="' + title + '">'
        html += '<form id="frm_' + id + '">'
        html += '<table style="width:250px; font-size:12px;">'
        html += '<thead>'
        html += '<th style="border:1px black solid;" class="ui-state-active">Propiedad</th>'
        html += '<th style="border:1px black solid" class="ui-state-active">Valor</th>'
        html += '</thead>'
        html += '<tbody>'
        from.each { pr ->
            if (pr.grupo != grp) {
                grp = pr.grupo
                html += '<tr class=" ui-widget-header ui-corner-all ui-helper-clearfix">'
                html += '<td hover=".gv-panel_wrap">' + grp + '</td>'
                html += '</tr>'
            }
            html += '<tr title="' + pr.explicacion + '">'
            html += '<td style="border:1px black solid;padding-left:5px;" class="ui-state-active">'
            html += pr.mostrar
            html += '</td>'
            html += '<td style="border:1px black solid;">'
            html += elm.item(propiedad: pr, value: propiedades[pr.nombre], sufijo: (pr.sufijo) ? pr.sufijo : "")
            html += '</td>'
            html += '</tr>'
        }
        html += '</tbody>'
        html += '</table>'
        html += '</form>'
        html += '</div>'

        out << html
    }

    /** *********** FUNCIONES                               *******************/
    /**
     * Dump out attributes in HTML compliant fashion
     */
    String outputAttributes(attrs) {
        def str = ""
        attrs.remove('tagName') // Just in case one is left
        attrs.each {k, v ->
            str += "$k=\"${v.encodeAsHTML()}\" "
        }
        return str
    }

}
