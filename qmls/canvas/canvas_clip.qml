import QtQuick 2.2

Canvas {
    width: 480;
    height: 400;
    contextType: "2d";
    property var comicRole: "http://img.hb.aicdn.com/1561949785d9db35653b33bff99dc57b508f6cd2c7b0-GtelQQ_fw658";

    onPaint: {
        context.lineWidth = 2;
        context.strokeStyle = "blue";
        context.fillStyle = Qt.rgba(0.3, 0.5, 0.7, 0.3);
        
        context.save();
        context.beginPath();
        context.arc(180, 150, 80, 0, Math.PI *2, true);
        context.moveTo(180, 230);
        context.lineTo(420, 280);
        context.lineTo(160, 320);
        context.closePath();
        context.clip();
        context.drawImage(comicRole, 0, 0, 600, 600, 0, 0, 400, 400);  
        context.stroke();
        context.fill();        
        
        context.rotate(Math.PI / 5);
        context.font = "italic bold 32px serif" ;
        context.fillStyle = "red";
        context.fillText("the text will be clipped!", 100, 70);        
        context.restore();  
    }
    
    Component.onCompleted:loadImage(comicRole);
    onImageLoaded: requestPaint();
}