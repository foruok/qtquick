import QtQuick 2.2

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
    
    Grid {
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        rows: 3;
        columns: 3;
        rowSpacing: 4;
        columnSpacing: 4;
        flow: Grid.TopToBottom;
        
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
