import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    
    Text {
        id: text1;
        anchors.centerIn: parent;
        text: "Hello World!";
        color: "blue";
        font.pixelSize: 32;
    }
    
    Button {
        id: button1;
        text: "A Button";
        anchors.top: text1.bottom;
        anchors.topMargin: 4;
    }
    
    Image {
        id: image1;
    }
    
    Component.onCompleted: {
        console.log("QML Text\'s C++ type - ", text1);
        console.log("QML Button\'s C++ type - ", button1);
        console.log("QML Image\'s C++ type - ", image1);
    }
}
