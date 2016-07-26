package nth

import org.xhtmlrenderer.util.ImageUtil

import javax.swing.*

class Foto {

    Galeria galeria
    String tags
    byte[] thumbnail
    String caption
    byte[] data
    Integer width
    Integer height
    Integer widthOriginal
    Integer heightOriginal
    Integer dataWidth
    Integer dataHeight

    static hasMany = [frases: Frase]

    static constraints = {
        thumbnail(nullable: true)
        caption(nullable: true)
        data(validator: {
            return it?.size() > 0
        })
        width(nullable: true)
        height(nullable: true)
        widthOriginal(nullable: true, blank: true)
        heightOriginal(nullable: true, blank: true)
        dataWidth(nullable: true, blank: true)
        dataHeight(nullable: true, blank: true)
        galeria(blank: true, nullable: true)
        tags(blank: true, nullable: true, size: 1..200)
    }

    static mapping = {
        cache usage:'read-write', include:'non-lazy'
        id generator:'identity'
        
        table 'foto'
        id column: 'foto__id'
        galeria column: 'glra__id'
        tags column: 'fototags'
        thumbnail column: 'fotothmb'
        caption column: 'fotocptn'
        data column: 'fotodata'
        width column: 'fotowdth'
        height column: 'fotohght'
        widthOriginal column: 'fotowdor'
        heightOriginal column: 'fotohgor'
        dataWidth column: 'fotodawd'
        dataHeight column: 'fotodahg'
    }

    String toString() {
        return "Foto: " + this.tags
    }


    def beforeInsert = {
        java.awt.Image img = new ImageIcon(this?.data).getImage();
        this?.heightOriginal = img.getHeight(null);
        this?.widthOriginal = img.getWidth(null);

        def ar = true, dar = true
        def w, h, dw, dh

        if (this.width && this.height) {
            ar = false;
        }
        if (this.dataWidth && this.dataHeight) {
            dar = false;
        }
        if (this.width) {
            w = this.width
        } else {
            w = 0
        }
        if (this.height) {
            h = this.height
        } else {
            h = 0
        }
        if (this.dataWidth) {
            dw = this.dataWidth
        } else {
            dw = 0
        }
        if (this.dataHeight) {
            dh = this.dataHeight
        } else {
            dh = 0
        }

        resize(w, h, true, ar)
        resize(dw, dh, false, dar)

//        img = new ImageIcon(this?.data).getImage();
        //        println "DATA"
        //        println(img.getHeight(null));
        //        println(img.getWidth(null));

        //        img = new ImageIcon(this?.thumbnail).getImage();

        //        println "THMB"
        //        println(img.getHeight(null));
        //        println(img.getWidth(null))
    }
    def beforeUpdate = {
        java.awt.Image img = new ImageIcon(this?.data).getImage();
        this?.heightOriginal = img.getHeight(null);
        this?.widthOriginal = img.getWidth(null);

        def ar = true, dar = true
        def w, h, dw, dh

        if (this.width && this.height) {
            ar = false;
        }
        if (this.dataWidth && this.dataHeight) {
            dar = false;
        }
        if (this.width) {
            w = this.width
        } else {
            w = 0
        }
        if (this.height) {
            h = this.height
        } else {
            h = 0
        }
        if (this.dataWidth) {
            dw = this.dataWidth
        } else {
            dw = 0
        }
        if (this.dataHeight) {
            dh = this.dataHeight
        } else {
            dh = 0
        }

        resize(w, h, true, ar)
        resize(dw, dh, false, dar)
    }

    def afterInsert = {
        def seccion = Seccion.findByFoto(this)
        if (seccion) {
            seccion.width = this.width
            seccion.height = this.height
            seccion.save()
        }

    }

    def afterUpdate = {
        def seccion = Seccion.findByFoto(this)
        if (seccion) {
            seccion.width = this.width
            seccion.height = this.height
            seccion.save()
        }

    }

    /**
     * Creates the thumbnail. Takes maxWidth and maxHeight from config.groovy if provided
     *  otherwise cosiders the default max width & height as 170 & 120 respectively.
     */
    public void loadThumbnail() {
        if (this.data) {
            def imageUtil = new ImageUtil()
            imageUtil.load(data)
            float maxWidth = this.width ?: 170
            println "heg dom  " + Math.floor(this.width.toDouble() * (this.heightOriginal / this.widthOriginal))
            float maxHeight = Math.floor(this.width.toDouble() * (this.heightOriginal / this.widthOriginal)) ?: 120
            imageUtil.resize(maxWidth, maxHeight, true, 1, 1)
            this.thumbnail = imageUtil.getBytes("JPEG")
            java.awt.Image img = new ImageIcon(this?.thumbnail).getImage();
            this?.height = img.getHeight(null);
            this?.width = img.getWidth(null);
        }
    }

    /**
     *
     * @param w el nuevo ancho
     * @param h el nuevo alto
     * @param thumb true si se quiere crear el thumbnail , false para redimensionar el original
     * @param aspectRatio true para que se mantenga el aspecto, false para que quede w x h
     */
    public void resize(int w, int h, boolean thumb, boolean aspectRatio) {

        //println "Resize image: w=" + w + "  h=" + h + "  thumb=" + thumb + "  aspectRatio=" + aspectRatio

        if (w == 0 && h == 0) {
            if (thumb) {
                w = 100
            } else {
                w = 1024
            }
        }
        if (this.data) {
            def imageUtil = new ImageUtil()
            java.awt.Image img

            imageUtil.load(data)

            int ow = this.widthOriginal
            int oh = this.heightOriginal

            int nw, nh

            if (!aspectRatio) {
                //si no se conserva la relacion del aspecto: nuevo ancho=ancho, nuevo alto=alto
                nw = w
                nh = h
            } else {
                def r
                if (w > 0 && h > 0) {
                    //si recibo las 2 dimensiones, tomo la mayor de las 2 dimensiones originales para ver la relacion de tamanio redimensionado
                    if (ow > oh) {
                        //ancho > alto
                        r = ow / w
                    } else {
                        //alto > ancho
                        r = oh / h
                    }
                } else {
                    //si no recibo las 2 dimensiones, la relacion es con la dimesion recibida
                    if (w > 0) {
                        r = ow / w
                    } else if (h > 0) {
                        r = oh / h
                    }
                }
                //println "tams " + ow + " " + oh + " " + r + " " + w + " " + h
                nw = ow / r
                nh = oh / r
            }

            //println "new width=" + nw + "   new height=" + nh
            imageUtil.resize(nw, nh, true, 1, 1)

            if (thumb) {
                this.thumbnail = imageUtil.getBytes("PNG")
                img = new ImageIcon(this?.thumbnail).getImage();
                this?.height = img.getHeight(null);
                this?.width = img.getWidth(null);
            } else {
                this.data = imageUtil.getBytes("PNG")
                img = new ImageIcon(this?.data).getImage();
                this?.dataHeight = img.getHeight(null);
                this?.dataWidth = img.getWidth(null);
            }
        }
    }

}
