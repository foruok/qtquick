import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    
    Text {
        id: hello;
        anchors.centerIn: parent;
        text: "Hello World!";
        color: "blue";
        font.pixelSize: 32;
        onTextChanged: {
            console.log(text);
        }
    }
    
    Button {
        anchors.top: hello.bottom;
        anchors.topMargin: 8;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: "Change";
        onClicked: {
            hello.text = "Hello Qt Quick";
        }
    }
}
