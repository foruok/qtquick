import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1 

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Text {
        id: centerText;
        text: "A Single Text.";
        anchors.centerIn: parent;
        font.pixelSize: 24;
        font.bold: true;
    }
    
    function setTextColor(clr){
        centerText.color = clr;
    }
    
    RowLayout {
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        anchors.right: parent.right;
        anchors.rightMargin: 4;
        spacing: 4;
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);     
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);     
            Layout.fillWidth: true;
        }
    }
}
