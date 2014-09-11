import QtQuick 2.2

Canvas {
    width: 400;
    height: 240;

    onPaint: {
        var ctx = getContext("2d");
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        var gradient = ctx.createLinearGradient(60, 50, 180, 130);
        gradient.addColorStop(0.0, Qt.rgba(1, 0, 0, 1.0));
        gradient.addColorStop(1.0, Qt.rgba(0, 0, 1, 1.0));
        ctx.fillStyle = gradient;
        ctx.beginPath();
        ctx.rect(60, 50, 120, 80);
        ctx.fill();
        ctx.stroke();
        
        gradient = ctx.createRadialGradient(230, 160, 30, 260, 200, 20);
        gradient.addColorStop(0.0, Qt.rgba(1, 0, 0, 1.0));
        gradient.addColorStop(1.0, Qt.rgba(0, 0, 1, 1.0));        
        ctx.fillStyle = gradient;
        ctx.beginPath();
        ctx.rect(200, 140, 80, 80);
        ctx.fill();
        ctx.stroke();        
    }
}