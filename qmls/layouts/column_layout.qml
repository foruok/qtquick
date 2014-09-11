import QtQuick 2.2
import QtQuick.Layouts 1.1  //[1]

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
    
    ColumnLayout { //[2]
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        height: 180; //[3]
        spacing: 4;
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random());
            onColorPicked: setTextColor(clr);
            Layout.fillHeight: true; //[4]
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random());     
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random());
            onColorPicked: setTextColor(clr);
        }
        
        ColorPicker {
            color: Qt.rgba(Math.random(), Math.random(), Math.random());
            onColorPicked: setTextColor(clr);     
        }
    }
}
