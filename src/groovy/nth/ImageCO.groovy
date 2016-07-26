package nth

/**
 * ImageCO is a command object. 
 */
class ImageCO {
    org.springframework.web.multipart.commons.CommonsMultipartFile data
    String caption
     

    static constraints = {
        caption(nullable: true)
        data(validator: {
            return it?.size > 0
        })
    }

    nth.Foto getImage() {
        nth.Foto image = new nth.Foto()
        image?.data = this?.data?.bytes
        image?.caption = this?.caption
        return image
    }
}
