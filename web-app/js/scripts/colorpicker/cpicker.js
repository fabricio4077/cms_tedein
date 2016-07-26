$(function() {

    function change(elem, hex, rgb) {
        if((rgb.r*1 + rgb.g*1 + rgb.b*1) < 200) {
            $(elem).css('color', '#ffffff');
        } else {
            $(elem).css('color', '#000000');
        }
        $(elem).css('backgroundColor', '#' + hex);
        $(elem).val(hex);
    }

    $('#colorpickerField1').ColorPicker({
        onSubmit: function(hsb, hex, rgb, el) {
            $(el).val(hex);
            $(el).ColorPickerHide();
        },
        onBeforeShow: function () {
            $(this).ColorPickerSetColor(this.value);
        },
        onChange: function (hsb, hex, rgb) {
            change('#colorpickerField1', hex, rgb);
        }

    })
    .bind('keyup', function(){
        $(this).ColorPickerSetColor(this.value);
    });

    $('#colorpickerField2').ColorPicker({
        onSubmit: function(hsb, hex, rgb, el) {
            $(el).val(hex);
            $(el).ColorPickerHide();
        },
        onBeforeShow: function () {
            $(this).ColorPickerSetColor(this.value);
        },
        onChange: function (hsb, hex, rgb) {
            change('#colorpickerField2', hex, rgb);
        }

    })
    .bind('keyup', function(){
        $(this).ColorPickerSetColor(this.value);
    });

    $('#colorpickerField3').ColorPicker({
        onSubmit: function(hsb, hex, rgb, el) {
            $(el).val(hex);
            $(el).ColorPickerHide();
        },
        onBeforeShow: function () {
            $(this).ColorPickerSetColor(this.value);
        },
        onChange: function (hsb, hex, rgb) {
            change('#colorpickerField3', hex, rgb);
        }

    })
    .bind('keyup', function(){
        $(this).ColorPickerSetColor(this.value);
    });

});