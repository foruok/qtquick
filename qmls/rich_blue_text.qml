import QtQuick 2.2

Rectangle {
    width: 320;
    height: 200;
    Text {
        width: 150;
        height: 100;
        wrapMode: Text.WordWrap;
        font.bold: true;
        font.pixelSize: 24;
        font.underline: true;
        text: "Hello Blue <font color=\"blue\">Text</font>";
        anchors.centerIn: parent;
    }
}