import QtQuick 2.0

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
        property var animation;
    
        PropertyAnimation { 
            id: toSquare; 
            target: rect; 
            property: "width"; to: 150; duration: 1000;
            onStarted: {
                rect.animation = toSquare;
                rect.color = "red";
            }
            onStopped: {
                rect.color = "blue";
            }
        }
        
        PropertyAnimation { 
            id: toRect; 
            target: rect; 
            property: "width"; to: 50; duration: 1000;
            onStarted: {
                rect.animation = toRect;
                rect.color = "red";
            }
            onStopped: {
                rect.color = "blue";
            }            
        }        
    
        MouseArea { 
            anchors.fill: parent; 
            onClicked: {
                if(rect.animation == toRect || rect.animation == undefined){
                    toSquare.start(); 
                }else{
                    toRect.start();
                }
            }
        }
    }
}