import QtQuick 2.0

/*
Canvas {
    width: 400;
    height: 240;

    onPaint: {
        var ctx = getContext("2d");
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        ctx.fillStyle = "blue";
        //ctx.fillRect(100, 80, 120, 80);
        ctx.beginPath();
        ctx.rect(100, 80, 120, 80);
        ctx.fill();
        ctx.stroke();
    }
}
*/
Canvas {
    width: 400;
    height: 240;
    contextType: "2d";

    onPaint: {
        context.lineWidth = 2;
        context.strokeStyle = "red";
        context.fillStyle = "blue";
        context.beginPath();
        context.rect(100, 80, 120, 80);
        context.fill();
        context.stroke();
    }
}