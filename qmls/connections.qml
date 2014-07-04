import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    
    Text {
        id: text1;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        anchors.topMargin: 20;
        text: "Text One";
        color: "blue";
        font.pixelSize: 28;
    }
    
    Text {
        id: text2;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: text1.bottom;
        anchors.topMargin: 8;
        text: "Text Two";
        color: "blue";
        font.pixelSize: 28;
    }
    
    Button {
        id: changeButton;
        anchors.top: text2.bottom;
        anchors.topMargin: 8;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: "Change";
    }
    
    Connections {
        target: changeButton;
        onClicked: {
            text1.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
            text2.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
        }
    }
}
