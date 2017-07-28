$(function (){
    $('body').on('click', '.close, #myModal' ,function () {
        $('.hint').remove();
    });

    $('#myModal').on('hidden', function () {
        $('.hint').remove();
    })

    $('body').on('click', '.showModalSendOrderByOneClick' ,function () {
        $('.modal-body').removeClass('hide');
        $('.sendOrderByOneClickOkMessage').addClass('hide');
        $('.sendOrderByOneClick [name=phoneNumber]').val('');
    });

    $('body').on('click', '.sendOrderByOneClickSubmit' ,function () {
        var sendOrderByOneClickErrors  = new errors({
            'form'	:	'.sendOrderByOneClick',
        });
        sendOrderByOneClickErrors.reset();
        var sendOrderByOneClickLoader = (new loaderLight());

        $.ajax({
            url: '/order/sendOrderByOneClick/',
            type: 'POST',
            data: {
                'goodId' : $('.sendOrderByOneClick [name=goodId]').val(),
                'phoneNumber' : $('.sendOrderByOneClick [name=phoneNumber]').val()
            },
            dataType: 'json',
            beforeSend: function () {
                sendOrderByOneClickLoader.start();
            },
            success: function(data){
                sendOrderByOneClickLoader.stop();
                if(data == 1){
                    $('.modal-body').addClass('hide');
                    $('.sendOrderByOneClickOkMessage').removeClass('hide');
                }
                else{
                    sendOrderByOneClickErrors.show(data);
                }
            }
        });
    });

    // $("input[name=phoneNumber]").inputmask("mask", {"mask": "+7(999) 999-99-99"}); //specifying fn & options
});