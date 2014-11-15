import QtQuick 2.2

Canvas {
    width: 320;
    height: 240;

    onPaint: {
        var ctx = getContext("2d");
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.quadraticCurveTo(0, height - 1, width - 1, height - 1);
        ctx.stroke();
    }
    
    Text {
        anchors.centerIn: parent;
        font.pixelSize: 20;
        text: "quadratic Bezier curve";
    }
}
