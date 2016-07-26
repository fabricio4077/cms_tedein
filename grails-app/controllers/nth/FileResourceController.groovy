package nth

import nth.seguridad.Shield

//http://fbflex.wordpress.com/2008/11/26/a-simple-grails-controller-for-file-management/
class FileResourceController extends Shield{

    def index = {
        redirect(action: list, params: params)
    }

    def list = {
        def fileResourceInstanceList = []
        def f = new File(grailsApplication.config.images.location.toString())
        if (f.exists()) {
            f.eachFile() { file ->
                if (!file.isDirectory())
                fileResourceInstanceList.add(file.name)
            }
        }
        [fileResourceInstanceList: fileResourceInstanceList]
    }

    def delete = {
        def filename = params.id.replace('###', '.')
        def file = new File(grailsApplication.config.images.location.toString() + File.separatorChar + filename)
        file.delete()
        flash.message = "file ${filename} removed"
        redirect(action: list)
    }

    def upload = {
        def dir = params.dir
        def filename = params.filename
        def f = request.getFile('fileUpload')
        if (!f.empty) {
            flash.message = 'Your file has been uploaded'
            new File(grailsApplication.config.images.location.toString()).mkdirs()
            f.transferTo(new File(grailsApplication.config.images.location.toString() + File.separatorChar + f.getOriginalFilename()))
        }
        else {
            flash.message = 'file cannot be empty'
        }
        redirect(action: list)
    }
}
