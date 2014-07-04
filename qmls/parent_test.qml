import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    
    Rectangle {
        width: 300;
        height: 100;
        color: "blue";
        Rectangle {
            width: 280;
            height: 200;
            color: "green";
            anchors.fill: parent;
            Rectangle {
                width: 50;
                height: 50;
                color: "red";
                anchors.centerIn: parent;
            }
        }
    }
}
