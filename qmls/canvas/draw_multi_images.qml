import QtQuick 2.2

Canvas {
    width: 400;
    height: 300;
    id: root;
    property var dartlikeWeapon: "dartlike_weapon.png";
    property var poster: "http://g2.ykimg.com/0516000053548ED267379F510C0061FA";

    onPaint: {
        var ctx = getContext("2d");
        ctx.drawImage(poster, 120, 0);
        ctx.drawImage(dartlikeWeapon, 0, 0);
    }
    Component.onCompleted:{
        loadImage(dartlikeWeapon);
        loadImage(poster);
    }
    onImageLoaded: requestPaint();
}