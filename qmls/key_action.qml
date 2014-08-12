import QtQuick 2.2

Rectangle {
    width: 300;
    height: 200;
    color: "#c0c0c0";
    focus: true;
    Keys.enabled: true;
    Keys.onEscapePressed: Qt.quit();
    Keys.onBackPressed: Qt.quit();
    Keys.onPressed: {
        switch(event.key){
        case Qt.Key_0:
        case Qt.Key_1:
        case Qt.Key_2:
        case Qt.Key_3:
        case Qt.Key_4:
        case Qt.Key_5:
        case Qt.Key_6:
        case Qt.Key_7:
        case Qt.Key_8:
        case Qt.Key_9:
            keyView.text = event.key - Qt.Key_0;
            break;
        }
    }

    Text {
        id: keyView;
        font.bold: true;
        font.pixelSize: 24;
        text: qsTr("text");
        anchors.centerIn: parent;
    }
}