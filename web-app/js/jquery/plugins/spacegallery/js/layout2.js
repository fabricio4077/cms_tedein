(function($) {
    var initLayout = function() {
        $('#myGallery').spacegallery({
            loadingClass: 'loading',
            border: 2
        });
    };

    EYE.register(initLayout, 'init');
})(jQuery)