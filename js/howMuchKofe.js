$(function () {
    getHowMuchKofeBlock();
});

function getHowMuchKofeBlock() {
    if($('.placeForHowMuchKofeBlock').length)
        $.ajax({
            url: '/catalog/ajaxGetHowMuchKofeBlock/',
            type: 'POST',
            dataType: 'json',
            success: function(data){
                $('.placeForHowMuchKofeBlock').html(data);
            }
        });
}