$(function () {
    repairsQuestion();

    function repairsQuestion () {
        $('body').on('click', '.repairsQuestion' ,function () {
            var myErrors  = new errors({
                'form'	:	'.repairsQuestion',
            });
            myErrors.reset();
            var myLoader = (new loaderLight());

            $.ajax({
                url: '/order/repairsQuestion/',
                type: 'POST',
                data: (function () {
                    var data = {};
                    $('.repairsQuestion').find('*').each(function(i, el) {
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
                    $('.repairsQuestionOkMessage').addClass('hide');
                },
                success: function(data){
                    myLoader.stop();
                    if(data == 1){
                        $('.repairsQuestion').find('*').val('');
                        $('.repairsQuestionOkMessage').removeClass('hide');
                    }
                    else{
                        myErrors.show(data);
                    }
                }
            });
        });
    }
});