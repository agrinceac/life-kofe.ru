function Coordinates(element$) {
    this.getTop = function () {
        return parseInt(element$.offset().top);
    };

    this.getBottom = function () {
        return parseInt(this.getTop() + element$.outerHeight(true));
    };

    this.getLeft = function () {
        return parseInt(element$.offset().left);
    };

    this.getRight = function () {
        return parseInt(this.getLeft() + element$.outerWidth(true));
    };

    this.moveLeftTop = function (left, top) {
        element$.css( { left:left, top:top} );
    };
}