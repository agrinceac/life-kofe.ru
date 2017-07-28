$(function () {
    contactsQuestion();

    function contactsQuestion () {
        $('body').on('click', '.contactsQuestion' ,function () {
            var myErrors  = new errors({
                'form'	:	'.contactsQuestion',
            });
            myErrors.reset();
            var myLoader = (new loaderLight());

            $.ajax({
                url: '/order/contactsQuestion/',
                type: 'POST',
                data: (function () {
                    var data = {};
                    $('.contactsQuestion').find('*').each(function(i, el) {
                        if(el.hasAttribute('name') && $(el).prop("type") != "button" && $(el).prop("type") != "submit"){
                            if ( ( $(el).prop("type") == "checkbox" || $(el).prop("type") == "radio" ) )
                                el.checked   ?   data[$(el).attr('name')] = 1   :   '';
                            else
                                data[$(el).attr('name')] = $(el).val();
                        }
                    });
                    return data;
                })(),
                dataType: 'json',
                beforeSend: function () {
                    myLoader.start();
                    $('.contactsQuestionOkMessage').addClass('hide');
                },
                success: function(data){
                    myLoader.stop();
                    if(data == 1){
                        $('.contactsQuestion').find('*').val('');
                        $('.contactsQuestionOkMessage').removeClass('hide');
                    }
                    else{
                        myErrors.show(data);
                    }
                }
            });
        });
    }
});