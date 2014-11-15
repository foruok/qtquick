import QtQuick 2.2

Rectangle {
    id: rootItem;
    width: 320; 
    height: 240;
    
    Rectangle {
        id: rect;
        width: 160;
        height: 100;
        color: "red";
        anchors.centerIn: parent;
        property var lastHeight: 100;
        
        Behavior on width {
            ParallelAnimation {
                NumberAnimation { 
                    duration: 1000; 
                }
                NumberAnimation { 
                    target: rect;
                    property: "height";
                    from: rect.lastHeight;
                    to: rect.height;
                    duration: 800; 
                }
            }
        }
        /*
        Behavior on height {
            NumberAnimation { duration: 1000; easing.type: Easing.InCubic; }
        }        
        */
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                rect.width = Math.random() * rootItem.width;
                rect.lastHeight = rect.height;
                rect.height = Math.min( Math.random() * rootItem.height, rect.height*1.5 );
            }
        }
    }
}