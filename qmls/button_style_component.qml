import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    width: 300;
    height: 200;

    Component{
        id: btnStyle;
        ButtonStyle {
            background: Rectangle {
                implicitWidth: 70;
                implicitHeight: 25;
                color: "#DDDDDD";
                border.width: control.pressed ? 2 : 1;
                border.color: (control.hovered || control.pressed) ? "green" : "#888888";
            }
        }
    }

    Button {
        id: openButton;
        text: "Open";
        anchors.left: parent.left;
        anchors.leftMargin: 10;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 10;
        style: btnStyle;
    }

    Button {
        text: "Quit";
        anchors.left: openButton.right;
        anchors.leftMargin: 6;
        anchors.bottom: openButton.bottom;
        style: btnStyle;
    }
}