import QtQuick 2.0

Canvas {
    width: 480;
    height: 640;
    contextType: "2d";
    property var comicRole: "http://img.hb.aicdn.com/92e44572506e7e8d269700194b473c66a06086a01b32c-UobFXg_fw658";

    onPaint: {
        context.lineWidth = 2;
        context.strokeStyle = "blue";
        context.fillStyle = Qt.rgba(0.3, 0.5, 0.7, 0.5);
        
        context.save();
        context.translate(width/2, height/2);
        context.drawImage(comicRole, -68, -100, 137, 200);  
        context.restore();
        
        context.save();
        context.translate(width/2, 0);
        context.shear(0.6, 0);
        context.drawImage(comicRole, 0, 0, 137, 200);
        context.restore();
        
        context.save();
        context.translate(width/2, 0);    
        context.shear(-0.6, 0);    
        context.drawImage(comicRole, -137, 0, 137, 200);
        context.restore();
        
        context.save();
        context.translate(0, height/2);
        context.shear(0.3, 0);
        context.rotate(Math.PI / 3);
        context.drawImage(comicRole, 0, -100, 137, 200);
        context.restore();     
                
        context.save();
        context.translate(width/2, height/2);
        context.rotate(Math.PI / 2);
        context.drawImage(comicRole, 120, -40, 137, 200);
        context.restore();   
        
        context.save();
        context.setTransform(1.2, 0.5, 0, 0.7, width - 100, height - 120);
        context.drawImage(comicRole, 0, 0, 68, 100);
        context.restore();
    }
    
    Component.onCompleted:loadImage(comicRole);
    onImageLoaded: requestPaint();
}