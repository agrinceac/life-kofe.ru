$(function () {
    $.ajax({
        url: '/catalog/ajaxGetFabricatorsBlock/',
        type: 'POST',
        dataType: 'json',
        success: function(data){
            $('.placeForFabricatorsBlock').html(data);
        }
    });
});