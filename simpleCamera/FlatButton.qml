import QtQuick 2.2

Rectangle {
    id: bkgnd;
    implicitWidth: 60;
    implicitHeight: 88;
    color: "transparent";
    property alias iconSource: icon.source;
    property alias iconWidth: icon.width;
    property alias iconHeight: icon.height;
    property alias textColor: btnText.color;
    property alias font: btnText.font;
    property alias text: btnText.text;
    radius: 6;
    property bool hovered: false;
    border.color: "#949494";
    border.width: hovered ? 2 : 0;
    signal clicked;

    Image {
        id: icon;
        anchors.top: parent.top;
        anchors.margins: 2;
        anchors.horizontalCenter: parent.horizontalCenter;
    }
    Text {
        id: btnText;
        anchors.top: icon.bottom;
        anchors.horizontalCenter: icon.horizontalCenter;
        anchors.margins: 2;
        color: ma.pressed ? "blue" : (parent.hovered ? "#0000a0" : "white");
    }
    MouseArea {
        id: ma;
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: {
            bkgnd.hovered = true;
        }
        onExited: {
            bkgnd.hovered = false;
        }
        onClicked: {
            if(Qt.platform.os == "android"){
                bkgnd.hovered = false;
            }
            bkgnd.clicked();
        }
    }
}

