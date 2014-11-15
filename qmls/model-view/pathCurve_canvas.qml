import QtQuick 2.2

Canvas {
    width: 400;
    height: 200;
    contextType: "2d";

    Path {
        id: myPath;
        startX: 4; 
        startY: 100;

        PathCurve { x: 75; y: 75; }
        PathCurve { x: 200; y: 150; }
        PathCurve { x: 325; y: 25; }
        PathCurve { x: 394; y: 100; }
    }

    onPaint: {
        context.strokeStyle = Qt.rgba(.4,.6,.8);
        context.path = myPath;
        context.stroke();
        context.strokeStyle = "green";
        context.fillRect(2, 98, 4, 4);
        context.fillRect(73, 73, 4, 4);
        context.fillRect(198, 148, 4, 4);
        context.fillRect(323, 23, 4, 4);
        context.fillRect(392, 98, 4, 4);
    }
}