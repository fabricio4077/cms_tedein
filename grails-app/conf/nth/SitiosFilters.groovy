package nth

class SitiosFilters {

    def filters = {
        all(controller:'pagina', action:'*') {
            before = {
                println "si entro afuera "+actionName+" "+controllerName
                if(actionName=="index"){
                    println "si entro "
                    
                }
            }
            after = {
                
            }
            afterView = {
                
            }
        }
    }
    
}
