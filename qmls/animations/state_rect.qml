import QtQuick 2.2

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Rectangle {
        id: rect;
        color: "blue";
        width: 200;
        height: 200;
        anchors.centerIn: parent;
        
        MouseArea {
            id: mouseArea;
            anchors.fill : parent;
        }        
        
        states: [
            State {
                name: "resetwidth";
                when: mouseArea.pressed;
                PropertyChanges{ 
                    target: rect; 
                    restoreEntryValues: false; 
                    color: "red"; 
                    width: parent.width; 
                }
            }
        ]
    }
}
