import QtQuick 2.2
import QtQuick.Window 2.1
Window {
    id: root;
    visible: true;
    width: 300;
    height: 200;
    Loader {
        anchors.fill: parent;
        source: "http://127.0.0.1:8081/text.qml";
    }
}
