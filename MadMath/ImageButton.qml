import QtQuick 2.0

Rectangle {
    id: btn;
    property alias normalImage: normal.source;
    property alias pressedImage: pressed.source;
    signal clicked();

    Image {
        id: normal;
        anchors.fill: parent;
    }

    Image {
        id: pressed;
        anchors.fill: parent;
        visible: false;
    }

    implicitWidth: 64;
    implicitHeight: 48;

    MouseArea {
        anchors.fill: parent;
        onPressed: {
            pressed.visible = true;
            normal.visible = false;
        }

        onReleased: {
            pressed.visible = false;
            normal.visible = true;
            btn.clicked();
        }
    }
}
