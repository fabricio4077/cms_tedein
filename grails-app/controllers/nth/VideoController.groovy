package nth

import com.google.gdata.client.http.AuthSubUtil;
import com.google.gdata.client.youtube.YouTubeService;

import javax.mail.MessagingException
import com.google.gdata.data.youtube.VideoEntry
import com.google.gdata.data.youtube.YtPublicationState
import com.google.gdata.data.youtube.YouTubeMediaGroup
import com.google.gdata.data.media.mediarss.MediaPlayer
import com.google.gdata.data.media.mediarss.MediaKeywords
import com.google.gdata.data.geo.impl.GeoRssWhere
import com.google.gdata.data.extensions.Rating
import com.google.gdata.data.youtube.YtStatistics
import com.google.gdata.data.media.mediarss.MediaThumbnail
import com.google.gdata.data.youtube.YouTubeMediaContent
import com.google.gdata.data.youtube.YouTubeMediaRating
import com.google.gdata.data.youtube.VideoFeed
import com.google.gdata.data.media.mediarss.MediaTitle
import com.google.gdata.data.media.mediarss.MediaCategory
import com.google.gdata.data.media.mediarss.MediaDescription
import com.google.gdata.data.youtube.YouTubeNamespace
import com.google.gdata.data.youtube.FormUploadToken
import nth.seguridad.Shield;

class VideoController extends Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    Map getVideoEntry(VideoEntry videoEntry, boolean detailed) {
        def video = [:]
        video.id = ""
        video.title = videoEntry.getTitle().getPlainText()
        video.description = ""
        video.url = ""
        video.live = true
        video.processing = false
        video.rejected = [:]
        video.rejected.state = false
        video.rejected.reason = ""
        video.rejected.help = ""
        video.failed = [:]
        video.failed.state = false
        video.failed.reason = ""
        video.failed.help = ""
        video.editable = false
        video.uploaded = ""
        video.keywords = ""
        video.coords = [:]
        video.rating = 0
        video.views = 0
        video.thumbnails = []
        video.media = []
        video.restricted = ""

        if (videoEntry.isDraft()) {
            video.live = false
            YtPublicationState pubState = videoEntry.getPublicationState();
            if (pubState?.getState() == YtPublicationState.State.PROCESSING) {
                video.processing = true
            }
            else if (pubState?.getState() == YtPublicationState.State.REJECTED) {
                video.rejected.state = true
                video.rejected.reason = pubState.getDescription()
                video.rejected.help = pubState.getHelpUrl()
            }
            else if (pubState?.getState() == YtPublicationState.State.FAILED) {
                video.failed.state = true
                video.failed.reason = pubState.getDescription()
                video.failed.help = pubState.getHelpUrl()
            }
        }

        if (videoEntry.getEditLink() != null) {
            video.editable = true
        }

        if (detailed) {
            YouTubeMediaGroup mediaGroup = videoEntry.getMediaGroup();
            video.uploaded = mediaGroup.getUploader()
            video.id = mediaGroup.getVideoId()
            video.description = mediaGroup.getDescription().getPlainTextContent()

            MediaPlayer mediaPlayer = mediaGroup.getPlayer();
            video.url = mediaPlayer.getUrl()
            MediaKeywords keywords = mediaGroup.getKeywords();
            for (String keyword: keywords.getKeywords()) {
                video.keywords += (keyword + ",");
            }

            GeoRssWhere location = videoEntry.getGeoCoordinates();
            if (location != null) {
                video.coords.latitude = location.getLatitude()
                video.coords.longitude = location.getLongitude()
            }

            Rating rating = videoEntry.getRating();
            if (rating != null) {
                video.rating = rating.getAverage()
            }

            YtStatistics stats = videoEntry.getStatistics();
            if (stats != null) {
                video.views = stats.getViewCount()
            }

            for (MediaThumbnail mediaThumbnail: mediaGroup.getThumbnails()) {
                def m = [:]
                m.url = mediaThumbnail.getUrl()
                m.timeIndex = mediaThumbnail.getTime()
                video.thumbnails.add(m)
            }

            for (YouTubeMediaContent mediaContent: mediaGroup.getYouTubeContents()) {
                def m = [:]
                m.location = mediaContent.getUrl()
                m.type = mediaContent.getType()
                m.duration = mediaContent.getDuration()
                video.media.add(m)
            }

            for (YouTubeMediaRating mediaRating: mediaGroup.getYouTubeRatings()) {
                //restricted countries
                video.restricted = mediaRating.getCountries().toString()
            }
        }
        return video
    }

    List getVideoFeed(VideoFeed videoFeed, boolean detailed) {
        def videos = []
        for (VideoEntry videoEntry: videoFeed.getEntries()) {
            videos.add(getVideoEntry(videoEntry, detailed))
        }
        return videos
    }

    def login = {
        session.size = [:]
        session.size.w = params.w
        session.size.h = params.h
        session.seccion = params.id

        if (session.youTubeService != null) {
            redirect(action: "opcionesVideo")
        }

        javax.servlet.http.HttpServletRequest.metaClass.getSiteUrl = {
            return (delegate.scheme + "://" + delegate.serverName + ":" + delegate.serverPort /*+ delegate.getContextPath()*/)
        }

        def appUrl = request.getSiteUrl()
        session.appUrl = appUrl

        String next = appUrl + createLink(action: 'verVideos')
        String scope = "http://gdata.youtube.com";
//        String scope = "https://www.google.com/m8/feeds/contacts/default/full"
        boolean secure = false;
        boolean session = true;
        String authSubLogin = AuthSubUtil.getRequestUrl(next, scope, secure, session);

        return [auth: authSubLogin]
    }

    def verVideos = {
        String developer_key = "AI39si6xpNFB0Rmym2pkDZx5V4A3oblqw7AorupFI60M6Loezw937MX8NMegUIssMMvczhq_4Lg9WgqSJb5qKvmh51JDXioELw"

        try {
            String singleUseToken = params.token.decodeURL()
            String sessionToken = AuthSubUtil.exchangeForSessionToken(singleUseToken, null);

            def youTubeService = new YouTubeService("neltharion", developer_key);
            youTubeService.setAuthSubToken(sessionToken, null);

            session.youTubeService = youTubeService

            redirect(action: "opcionesVideo")
        } catch (e) {
            println "ERROR " + e
            redirect(action: "login")
        }
    }

    def opcionesVideo = {

    }

    def datosVideo = {
        if (session.youTubeService == null) {
            redirect(action: "login")
        }
    }

    def subirVideo = {
        if (session.youTubeService == null) {
            redirect(action: "login")
        }

        VideoEntry newEntry = new VideoEntry();

        YouTubeMediaGroup mg = newEntry.getOrCreateMediaGroup();
        mg.setTitle(new MediaTitle());
        mg.getTitle().setPlainTextContent(params.title);
        mg.addCategory(new MediaCategory(YouTubeNamespace.CATEGORY_SCHEME, params.category));
        mg.setKeywords(new MediaKeywords());
        (params.keywords.split(" ")).each {
            mg.getKeywords().addKeyword(it);
        }
        mg.setDescription(new MediaDescription());
        mg.getDescription().setPlainTextContent(params.description);
        mg.setPrivate(false);
        mg.addCategory(new MediaCategory(YouTubeNamespace.DEVELOPER_TAG_SCHEME, "mydevtag"));
        mg.addCategory(new MediaCategory(YouTubeNamespace.DEVELOPER_TAG_SCHEME, "anotherdevtag"));

        newEntry.setGeoCoordinates(new GeoRssWhere(-0.1665113012564374, -78.4866714477539));
//        newEntry.setLocation("Quito, Ecuador");
        // alternatively, one could specify just a descriptive string
        // newEntry.setLocation("Mountain View, CA");

        URL uploadUrl = new URL("http://gdata.youtube.com/action/GetUploadToken");
        FormUploadToken token = session.youTubeService.getFormUploadToken(uploadUrl, newEntry);

        def post_url = token.getUrl()
        def token_value = token.getToken()

        return [post_url: post_url, token_value: token_value, appUrl: session.appUrl]
    }

    def guardarVideo = {
        String videoEntryUrl = "http://gdata.youtube.com/feeds/api/videos/" + params.id;
        VideoEntry videoEntry = session.youTubeService.getEntry(new URL(videoEntryUrl), VideoEntry.class);
        def videoYT = getVideoEntry(videoEntry, true);

        def video = new Video()
        video.titulo = videoYT.title
        video.descripcion = videoYT.description
        video.codigo = videoYT.id
        video.tags = videoYT.keywords
        video.thumbnail = videoYT.thumbnails[0].url
        video.save(flush: true)

        def seccion = Seccion.get(session.seccion)
        seccion.video = video
        seccion.save(flush: true)

        redirect(action: "verVideo", params: params)
    }

    def verVideo = {
        return [params: params, size: session.size]
    }

    def listaVideos = {
        if (session.youTubeService == null) {
            redirect(action: "index")
        }

        String feedUrl = "http://gdata.youtube.com/feeds/api/users/default/uploads"

        VideoFeed videoFeed = session.youTubeService.getFeed(new URL(feedUrl), VideoFeed.class);
        def videos = getVideoFeed(videoFeed, true)

        def act = videos[0].id
        if (params.video) {
            act = params.video
        }

        return [videos: videos, act: act]
    }

    def selectVideo = {
        params.status = 600
        params.id = params.video
        def video = Video.findByCodigo(params.video)
        println "VIDEO"
        println video
        if (video && video != null) {
            def seccion = Seccion.get(session.seccion)
            seccion.video = video
            seccion.save(flush: true)
        } else {
            if (session.youTubeService == null) {
                redirect(action: "index")
            }

            String videoEntryUrl = "http://gdata.youtube.com/feeds/api/videos/" + params.video;
            VideoEntry videoEntry = session.youTubeService.getEntry(new URL(videoEntryUrl), VideoEntry.class);
            def videoYT = getVideoEntry(videoEntry, true);

            def vid = new Video()
            vid.titulo = videoYT.title
            vid.descripcion = videoYT.description
            vid.codigo = videoYT.id
            vid.tags = videoYT.keywords
            vid.thumbnail = videoYT.thumbnails[0].url
            vid.save(flush: true)

            def seccion = Seccion.get(session.seccion)
            seccion.video = video
            seccion.save(flush: true)

            println "CREATE VIDEO!!!"
        }
        redirect(action: "verVideo", params: params)
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [videoInstanceList: Video.list(params), videoInstanceTotal: Video.count()]
    }

    def create = {
        def videoInstance = new Video()
        videoInstance.properties = params
        return [videoInstance: videoInstance]
    }

    def save = {
        def videoInstance = new Video(params)
        if (videoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'video.label', default: 'Video'), videoInstance.id])}"
            redirect(action: "show", id: videoInstance.id)
        }
        else {
            render(view: "create", model: [videoInstance: videoInstance])
        }
    }

    def show = {
        def videoInstance = Video.get(params.id)
        if (!videoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'video.label', default: 'Video'), params.id])}"
            redirect(action: "list")
        }
        else {
            [videoInstance: videoInstance]
        }
    }

    def edit = {
        def videoInstance = Video.get(params.id)
        if (!videoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'video.label', default: 'Video'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [videoInstance: videoInstance]
        }
    }

    def update = {
        def videoInstance = Video.get(params.id)
        if (videoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (videoInstance.version > version) {

                    videoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'video.label', default: 'Video')] as Object[], "Another user has updated this Video while you were editing")
                    render(view: "edit", model: [videoInstance: videoInstance])
                    return
                }
            }
            videoInstance.properties = params
            if (!videoInstance.hasErrors() && videoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'video.label', default: 'Video'), videoInstance.id])}"
                redirect(action: "show", id: videoInstance.id)
            }
            else {
                render(view: "edit", model: [videoInstance: videoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'video.label', default: 'Video'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def videoInstance = Video.get(params.id)
        if (videoInstance) {
            try {
                videoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'video.label', default: 'Video'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'video.label', default: 'Video'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'video.label', default: 'Video'), params.id])}"
            redirect(action: "list")
        }
    }
}
