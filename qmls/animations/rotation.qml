import QtQuick 2.0

Rectangle {
    width: 320;
    height: 240;
    color: "#EEEEEE";
    
    Rectangle {
        id: rect;
        color: "red";
        width: 120;
        height: 60;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        anchors.verticalCenter: parent.verticalCenter;
        
        MouseArea {
            anchors.fill : parent;
            onClicked: RotationAnimation {
                target: rect;
                to: 90;
                duration: 1500;
                direction: RotationAnimation.Counterclockwise;
            }
        }
    }
    
    Rectangle {
        id: blueRect;
        color: "blue";
        width: 120;
        height: 60;
        anchors.right: parent.right;
        anchors.rightMargin: 40;
        anchors.verticalCenter: parent.verticalCenter;
        transformOrigin: Item.TopRight;
        
        MouseArea {
            anchors.fill : parent;
            onClicked: anim.start();
        }
        
        RotationAnimation {
            id: anim;
            target: blueRect;
            to: 60;
            duration: 1500;
        }
    }    
}
