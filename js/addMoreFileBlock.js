function addMoreFileBlockInit(objectSelectors) {
    $('body').on('click', objectSelectors + ' .addMoreFileBlock' ,function () {
        var i = $('.fileformDotted').length;
        var that = $(this);
        var filesQuantity = 5;
        if(i < filesQuantity){
            var elem = $('#fileform').clone();
            $(elem).removeAttr('id');
            $(elem).find('.upload').attr('name','upload['+(++i)+']');
            $(elem).find('p').text('Загрузить файл');
            $($(that).parent('.fileform')).before(elem);
        }
        if(i === filesQuantity)
            $(that).parent().remove();
    });

    $('body').on('change', objectSelectors + ' input:file' ,function () {
        if (this.value.lastIndexOf('\\')){
            var j = this.value.lastIndexOf('\\')+1;
        }
        else{
            var j = this.value.lastIndexOf('/')+1;
        }
        var filename = this.value.slice(j);
        var uploaded = $(this).siblings('.selectbutton').children('p').text(filename);
    });
}