$(function () {
    orderSpare();

    function orderSpare () {
        $('body').on('click', '.orderSpareSubmit' ,function () {
            var myErrors  = new errors({
                'form'	:	'.orderSpare',
            });
            myErrors.reset();
            var myLoader = (new loaderLight());

            $.ajax({
                url: '/order/orderSpare/',
                type: 'POST',
                data: (function () {
                    var object = $('.orderSpare');
                    var data = new FormData(object[0]);
                    object.find('*').each(function(i, el) {
                        if(el.hasAttribute('name') && $(el).prop("type") != "button" && $(el).prop("type") != "submit"){
                            if ( ( $(el).prop("type") == "checkbox" || $(el).prop("type") == "radio" ) )
                                el.checked   ?   data[$(el).attr('name')] = 1   :   '';
                            else
                                data[$(el).attr('name')] = $(el).val();
                        }
                    });
                    return data;
                })(),
                processData: false,
                contentType: false,
                dataType: 'json',
                beforeSend: function () {
                    myLoader.start();
                    $('.orderSpareOkMessage').addClass('hide');
                },
                success: function(data){
                    myLoader.stop();
                    if(data == 1){
                        $('.orderSpare').find('*').val('');
                        $('.orderSpareOkMessage').removeClass('hide');
                    }
                    else{
                        myErrors.show(data);
                    }
                }
            });
        });
    }
});