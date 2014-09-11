import QtQuick 2.2

Rectangle {
    width: 360;
    height: 240;
    color: "#EEEEEE";
    id: rootItem;
    
    Text {
        id: centerText;
        text: "A Single Text.";
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        font.pixelSize: 24;
        font.bold: true;
    }
    
    function setTextColor(clr){
        centerText.color = clr;
    }
    
    Flow {
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        width: 280;
        height: 130;
        spacing: 4;
        
        ColorPicker {
            width: 80;
            height: 20;
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            width: 100;
            height: 40;
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);     
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            width: 80;
            height: 25;        
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);     
        }
        
        ColorPicker {
            width: 35;
            height: 35;        
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);     
        }
        
        ColorPicker {
            width: 20;
            height: 80;        
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);     
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            onColorPicked: setTextColor(clr);     
        }        
    }
}
