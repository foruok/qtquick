import QtQuick 2.0

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;

    Rectangle {
        id: rect;
        width: 40; 
        height: 40;
        color: "blue";
        x: 0;
        y: 0;
        
        MouseArea {
            anchors.fill: parent;
            id: mouseArea;
            onClicked: pathAnim.start();
        }
    
        PathAnimation {
            id: pathAnim; 
            target: rect;
            duration: 6000;
            orientationEntryDuration: 200;
            orientationExitDuration: 200;
            easing.type: Easing.InOutCubic;
            orientation: PathAnimation.BottomFirst;
            path: Path {
                startX: 0; 
                startY: 0;
                PathQuad { 
                    x: 320; 
                    y: 0; 
                    controlX: 160; 
                    controlY: 300;
                }
            }
        }
    }
}