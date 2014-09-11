import QtQuick 2.2

Canvas {
    width: 400;
    height: 300;
    id: root;
    Image {
        id: poster;
        source: "http://g2.ykimg.com/0516000053548ED267379F510C0061FA";
        visible: false;
        onStatusChanged: {
            if (status == Image.Ready){
                console.log("source width - " , sourceSize.width, " height - ", sourceSize.height);
                root.requestPaint();
            }
        }
    }

    onPaint: {
        var ctx = getContext("2d");
        ctx.drawImage(poster, 50, 0);
    }
}