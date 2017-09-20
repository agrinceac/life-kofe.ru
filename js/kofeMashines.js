$(function () {

    $(document).on('hidden.bs.modal', '.modal', function (event) {
        $('.hint').remove();
    });

    getKofeMashinesList();
    orderMashine();
    orderCofeMashineButtonClickInit();
    makeOrderButtonInit();
    kofeMashineNameSelectChangeInit();
    calculateKofeInit();
});

function getKofeMashinesList() {
    if($('.placeForKofeMashinesBlock').length)
        $.ajax({
            url: '/catalog/ajaxGetKofeMashinesListBlock/',
            type: 'POST',
            data: {page: $('.placeForKofeMashinesBlock').data('page')},
            dataType: 'json',
            success: function(data){
                $('.placeForKofeMashinesBlock').html(data);
            }
        });
}

function orderMashine() {
    $('body').on('click', '.orderMashineForm .submit' ,function () {
        var myErrors  = new errors({
            'form'	:	'.orderMashineForm',
        });
        myErrors.reset();
        var myLoader = (new loaderLight());

        $.ajax({
            url: '/order/orderMashine/',
            type: 'POST',
            data: new FormData($('.orderMashineForm')[0]),
            dataType: 'json',
            processData: false,
            contentType: false,
            beforeSend: function () {
                myLoader.start();
            },
            success: function(data){
                myLoader.stop();
                if(data == 1){
                    $('.orderMashineForm').find('* :not(select option)').val('');
                    $(".orderMashineForm select").val($(".orderMashineForm select option:first").val());
                    $('.orderMashineForm .OkMessage').removeClass('hide');
                    $('.orderMashineForm .submit').hide();
                }
                else{
                    myErrors.show(data);
                }
            }
        });
    });
}

function orderCofeMashineButtonClickInit() {
    $('body').on('click', '.orderCofeMashineButton', function () {
        if($('#how-much-coffee-do-you-need').length)
            goToHowMuchKofeBlock(this);
        else
            showOrderKofeMashineModal(this);
    });
}

function goToHowMuchKofeBlock(button) {
    $('#how-much-coffee-do-you-need').autoScroll({
        'duration'   : 1500,
        'paddingTop' : 40
    });
    $('.kofeMashineName').val( $(button).attr('data-goodId') ).change();
}

function makeOrderButtonInit() {
    $('body').on('click', '.makeOrderButton', function () {
        showOrderKofeMashineModal(this);
    });
}

function kofeMashineNameSelectChangeInit() {
    $('body').on('change', '.kofeMashineName', function () {
        $('.makeOrderButton').attr('data-goodId', $('.kofeMashineName option:selected').val())
            .attr('data-name', $('.kofeMashineName option:selected').text());
    });
}

function showOrderKofeMashineModal(button) {
    $('.orderType').html( $('h1').html().replace(/&lt;br&gt;/g," ").replace(/\<br\>/g," ").replace(/ +(?= )/g,'') );
    $('[name=orderType]').val( $('h1').html().replace(/&lt;br&gt;/g," ").replace(/\<br\>/g," ").replace(/ +(?= )/g,'') );
    $('.mashineName').html( $(button).attr('data-name') );
    $('[name=goodId]').val( $(button).attr('data-goodId') );

    if($('[name=employeesCount]').length)
        if($('[name=cupsCount]').length){
            var details = 'сотрудников: ' + $('[name=employeesCount]').val() +
                '; чашек на одного человека: ' + $('[name=cupsCount]:checked').val() +
                '; кофе в месяц: ' + $('[name=needCoffeeCountInMonth]').val() + 'кг';
            $('.mashineName').append('<br>(' + details + ')')
                            .append('<input type="hidden" name="details" value="' + details + '">');
            $('[name=qnt], [name=days]').remove();
        }

    $('.orderMashineForm .OkMessage').addClass('hide');
    $('.orderMashineForm .submit').show();

    $('#modalOrderMashine').modal('show');
}

function calculateKofeQnt() {
    var days = 21;
    var cupsInKg = 125;
    var needCoffeeCountInMonth = Math.round(
        $('[name=employeesCount]').val() * $('[name=cupsCount]:checked').val() * days / cupsInKg
    );
    return needCoffeeCountInMonth;
}

function calculateKofeInit() {
    $('body')
        .on('change', '[name=employeesCount]', function () {
            $('[name=needCoffeeCountInMonth]').val( calculateKofeQnt() );
        })
        .on('click', '[name=employeesCount]', function () {
            $('[name=needCoffeeCountInMonth]').val( calculateKofeQnt() );
        });
    $('body').on('click', '.radioCupsCount', function () {
        $('[name=needCoffeeCountInMonth]').val( calculateKofeQnt() );
    });
}