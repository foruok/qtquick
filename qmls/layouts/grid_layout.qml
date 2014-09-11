import QtQuick 2.2
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
    
    GridLayout {
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        width: 300;
        rows: 3;
        columns: 3;
        rowSpacing: 4;
        columnSpacing: 4;
        flow: GridLayout.TopToBottom;
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);
            Layout.columnSpan: 3;
            Layout.rowSpan: 3;
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);     
            onColorPicked: setTextColor(clr);
            Layout.fillWidth: true;
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
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);     
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);     
        }        
    }
}
