import QtQuick 2.0

Canvas {
    width: 500;
    height: 480;
    onPaint: {
        var ctx = getContext("2d");
        ctx.font = "20px sans-serif";
        ctx.globalCompositionMode = "source-over";
        ctx.fillStyle = "blue";
        ctx.fillRect(0, 0, 80, 80);
        ctx.fillStyle = "red";
        ctx.fillRect(40, 40, 80, 80);
        ctx.fillText("source-over", 0, 140);
        
        ctx.globalCompositionMode = "xor";
        ctx.globalAlpha = 0.75;
        ctx.fillStyle = "blue";
        ctx.fillRect(126, 0, 80, 80);
        ctx.fillStyle = "red";
        ctx.fillRect(166, 40, 80, 80);
        ctx.fillText("source-in", 126, 140);        
    }
}