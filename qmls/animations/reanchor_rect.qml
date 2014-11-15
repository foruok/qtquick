import QtQuick 2.2

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Rectangle {
        id: blueRect;
        width: 200;
        height: 180;
        color: "blue";
        x: 8;
        y: 8;
    }
    
    Rectangle {
        id: redRect;
        color: "red";
        width: 100;
        height: 100;
        anchors.left: blueRect.right;
        anchors.leftMargin: 10;
        anchors.top: blueRect.top;
        
        MouseArea {
            id: mouseArea;
            anchors.fill : parent;
            onClicked: {
                if( redRect.state == "" || redRect.state == "default" ) {
                    redRect.state = "reanchor";
                }else {
                    redRect.state = "default";
                }
            }
        }        
        
        states: [
            State {
                name: "reanchor";                
                changes:[
                    AnchorChanges { 
                        target: redRect;                     
                        anchors.top: blueRect.bottom;
                        anchors.left: rootItem.left;
                    },
                    PropertyChanges {
                        target: redRect;
                        height: 40;
                        anchors.topMargin: 4;
                    }
                ]
            },
            State {
                name: "default";             
                AnchorChanges { 
                    target: redRect;                     
                    anchors.left: blueRect.right;
                    anchors.top: blueRect.top;
                }
            }
        ]
    }
}
