//class UrlMappings {
//
//	static mappings = {
//        "/$controller/$action?/$id?(.$format)?"{
//            constraints {
//                // apply constraints here
//            }
//        }
//
//        "/"(view:"/index")
//        "500"(view:'/error')
//	}
//}

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:"paginaWeb", action:"show")
        "500"(view:'/error')
        "/pagina/$sitio?/$pagina?"{
            controller = "paginaWeb"
            action = "show"


        }

        //Controller: PaginaController.groovy
        "/pag1987/index"(controller:"pagina", action:"index")
        "/pag1987/list"(controller:"pagina", action:"list")
        "/pag1987/create"(controller:"pagina", action:"create")
        "/pag1987/save"(controller:"pagina", action:"save")
        "/pag1987/show"(controller:"pagina", action:"show")
        "/pag1987/edit"(controller:"pagina", action:"edit")
        "/pag1987/update"(controller:"pagina", action:"update")
        "/pag1987/delete"(controller:"pagina", action:"delete")
        "/pagina/index"(controller:"paginaWeb", action:"index")
        "/pagina/show"(controller:"paginaWeb", action:"show")
    }
}
