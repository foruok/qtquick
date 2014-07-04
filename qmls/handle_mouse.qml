import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    
    MouseArea {
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton | Qt.RightButton;
        onClicked: {
            if(mouse.button == Qt.RightButton){
                Qt.quit();
            }
            else if(mouse.button == Qt.LeftButton){
                color = Qt.rgba((mouse.x % 255) / 255.0 , (mouse.y % 255) / 255.0, 0.6, 1.0);
            }
        }
        onDoubleClicked: {
            color = "gray";
        }
    }
}
