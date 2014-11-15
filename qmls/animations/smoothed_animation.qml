import QtQuick 2.2

Rectangle {
    id: rootItem;
    width: 320; 
    height: 240;
    
    Rectangle {
        id: rect;
        width: 80;
        height: 60;
        x: 20;
        y: 20;
        color: "red";    
    }
    
    SmoothedAnimation {
        id: smoothX;
        target: rect;
        property: "x";
        duration: 1000;
        velocity: -1;
    }        
        
    SmoothedAnimation {
        id: smoothY;
        target: rect; 
        property: "y";   
        velocity: 100;
    }
    
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            smoothX.from = rect.x;
            smoothX.to = mouse.x + 4;
            smoothX.start();
            smoothY.from = rect.y;
            smoothY.to = mouse.y + 4;
            smoothY.start();
        }
    }        
}