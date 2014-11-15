import QtQuick 2.2

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Rectangle {
        id: rect;
        width: 50; 
        height: 150;
        anchors.centerIn: parent;
        color: "blue";
    
        PropertyAnimation { 
            id: animation; 
            target: rect; 
            property: "width"; 
            to: 150; 
            duration: 1000;
        }
    
        MouseArea { 
            anchors.fill: parent; 
            onClicked: animation.start(); //animation.running = true;
        }
    }
}