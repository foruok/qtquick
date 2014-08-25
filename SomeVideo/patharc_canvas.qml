import QtQuick 2.0

Canvas {
    width: 600; height: 400
    contextType: "2d"
    id: root;
    
    Path {
        id: videoPath;
        startX: 20;
        startY: 20;
        PathCubic {
            x: root.width / 2;
            y: root.height - 220;
            control1X: 40;
            control1Y: root.height - 220;
            control2X: root.width /2;
            control2Y: root.height - 220;
        }
        PathCubic {
            x: root.width -20;
            y: 20;
            control2X: root.width - 40;
            control2Y: root.height - 220;
            control1X: root.width /2;
            control1Y: root.height - 220;
        }        
    }
    
    Path {
        id: path2;
        startX: root.width/4;
        startY: root.height/4;
        PathLine{
            x: root.width/4;
            y: root.height*3/4;
        }
        PathLine{
            x: root.width*3/4;
            y: root.height*3/4;
        }
        PathLine{
            x: root.width*3/4;
            y: root.height/4;
        }
    }

    onPaint: {
        context.strokeStyle = Qt.rgba(.4,.6,.8);
        context.path = path2;
        context.stroke();
    }
}