import QtQuick 2.2

Canvas {
    width: 300;
    height: 300;
    antialiasing: true;
    contextType: "2d";

    onPaint: {
        context.lineWidth = 2;
        context.strokeStyle = "blue";
        context.fillStyle = "red";
        context.save();
        context.translate(width/2, height/2);
        context.beginPath();
        context.arc(0, 0, 30, 0,  Math.PI*2);
        context.arc(0, 0, 50, 0,  Math.PI*2);
        context.arc(0, 0, 70, 0,  Math.PI*2);
        context.arc(0, 0, 90, 0,  Math.PI*2);
        context.stroke();
        //context.restore(); //[1]
        
        //context.save(); //[1]
        context.translate(0, -height/2 + 30); //[2]
        context.font = "26px serif";
        context.textAlign = "center";
        context.fillText("concentric circles", 0, 0);
        context.restore();
    }
}