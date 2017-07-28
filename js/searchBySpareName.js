$(function () {
    $('body').on('click', '#searchBySpareNameSubmit', function () {
        if($('#spareName').val().trim())
            window.location.replace("/search/?spareName=" + $('#spareName').val());
    });
});