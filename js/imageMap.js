$(document).ready(function() {
    var resizeMyUsemapFlag = 0;
    $( window ).resize(function() {
        if(resizeMyUsemapFlag < 1){
            resizeMyUsemapFlag++;
            $('img[usemap]').rwdImageMaps();
        }
    });
});

$('img').mapster({
    fillOpacity: 0.2,
    isSelectable: false,
    onClick: function() {
        $(this).mapster('tooltip');
        $('.mapster_tooltip').css('width', 'auto');
        var topAreaRelative = parseInt($(this).attr('coords').split(',')[1]);
        var topImg = parseInt($('#imgRepair').offset().top);
        var topTarget = topImg + topAreaRelative - $('.mapster_tooltip').height() - 30;
        var leftTarget = parseInt($(this).attr('coords').split(',')[0]);
        var leftImg = parseInt($('#imgRepair').offset().left);
        var leftTarget = leftTarget + leftImg;
        $('.mapster_tooltip').css( { left:leftTarget, top:topTarget} );
    },
    toolTipClose: ["tooltip-click"],
    mapKey: "group",
    areas: [
        {
            key: 'noSwitch',
            toolTip: $('#noSwitch').html()
        },
        {
            key: 'noHeatWater',
            toolTip: $('#noHeatWater').html()
        },
        {
            key: 'proceedsWater',
            toolTip: $('#proceedsWater').html()
        },
        {
            key: 'indicatorsLightNoKofe',
            toolTip: $('#indicatorsLightNoKofe').html()
        },
        {
            key: 'noVapour',
            toolTip: $('#noVapour').html()
        },
        {
            key: 'noKofePour',
            toolTip: $('#noKofePour').html()
        }
    ]
});