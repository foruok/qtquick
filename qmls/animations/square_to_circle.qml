import QtQuick 2.2

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Rectangle {
        id: rect;
        color: "blue";
        width: 50;
        height: 50;
        x: 0;
        y: 95;
        
        MouseArea {
            id: mouseArea;
            anchors.fill : parent;
            onClicked: {
                animationX.start();
                animationRotation.running = true;
                animationRadius.start();
            }
        }        

        NumberAnimation { 
            id: animationX;
            target: rect; 
            property: "x"; 
            to: 310; 
            duration: 3000; 
            easing.type: Easing.OutCubic;
        }
        
        NumberAnimation { 
            id: animationRotation;
            target: rect; 
            property: "rotation";
            to: 1080; 
            duration: 3000; 
            running: false;
            easing.type: Easing.OutInQuad;
        }
        
        NumberAnimation on radius { 
            id: animationRadius;
            to: 25; 
            duration: 3000; 
            running: false;
        }
    }
}
