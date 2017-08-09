$(function () {
    $.ajax({
        url: '/catalog/ajaxGetFabricatorsBlock/',
        type: 'POST',
        data: {'pathMethod' : $('.placeForFabricatorsBlock').children('input').val()},
        dataType: 'json',
        success: function(data){
            $('.placeForFabricatorsBlock').html(data);
        }
    });
});