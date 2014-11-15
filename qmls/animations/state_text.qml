import QtQuick 2.2

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Text {
        id: centerText;
        text: "A Single Text.";
        anchors.centerIn: parent;
        font.pixelSize: 24;
        
        MouseArea {
            id: mouseArea;
            anchors.fill : parent;
            onReleased: {
                centerText.state = "redText";
            }
        }        
        
        states: [     
            State { 
                name: "redText"; 
                changes:[
                    PropertyChanges{ target: centerText; color: "red"; }
                ]
            },
            State {
                name: "blueText";
                when: mouseArea.pressed;
                PropertyChanges{ target: centerText; color: "blue"; font.bold: true; font.pixelSize: 32; }
            }
        ]
        
        state: "redText";
        
        Component.onCompleted: {
            console.log("states - ", centerText.states.length);
            console.log("State - ", centerText.states[0]);
            console.log("changes - ", centerText.states[0].changes.length);
            console.log("Change - ", centerText.states[0].changes[0]);
        }
        
    }
}
