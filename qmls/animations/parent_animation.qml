import QtQuick 2.0

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Rectangle {
        id: blueRect;
        width: 200;
        height: 200;
        color: "blue";
        x: 8;
        y: 8;
    }
    
    Rectangle {
        id: redRect;
        color: "red";
        width: 100;
        height: 100;
        x: blueRect.x + blueRect.width + 8;
        y: blueRect.y;
         
        states: State {
            name: "reparented"
            ParentChange { target: redRect; parent: blueRect; x: 10; y: 10 }
        }

        transitions: Transition {
            ParentAnimation {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }
        }

        MouseArea { anchors.fill: parent; onClicked: redRect.state = "reparented" }
    }
}
