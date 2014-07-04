import QtQuick 2.0
import QtQuick.Controls 1.1

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
    
    //color pickers look at parent's top
    ColorPicker {
        id: topColor1;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.top: parent.top;
        anchors.topMargin: 4;
        onColorPicked: setTextColor(clr);
    }
    
    ColorPicker {
        id: topColor2;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.left: topColor1.right;
        anchors.leftMargin: 4;
        anchors.top: topColor1.top;       
        onColorPicked: setTextColor(clr);
    }
    
    ColorPicker {
        id: topColor3;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.right: parent.right;
        anchors.rightMargin: 4;
        anchors.top: parent.top;
        anchors.topMargin: 4;
        onColorPicked: setTextColor(clr);
    }
    
    ColorPicker {
        id: topColor4;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.right: topColor3.left;
        anchors.rightMargin: 4;
        anchors.top: topColor3.top;  
        onColorPicked: setTextColor(clr);     
    }
    
    //color pickers sit on parent's bottom    
    ColorPicker {
        id: bottomColor1;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        onColorPicked: setTextColor(clr);
    }
    
    ColorPicker {
        id: bottomColor2;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.left: bottomColor1.right;
        anchors.leftMargin: 4;
        anchors.bottom: bottomColor1.bottom;   
        onColorPicked: setTextColor(clr);    
    }
    
    ColorPicker {
        id: bottomColor3;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.right: parent.right;
        anchors.rightMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        onColorPicked: setTextColor(clr);
    }
    
    ColorPicker {
        id: bottomColor4;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.right: bottomColor3.left;
        anchors.rightMargin: 4;
        anchors.bottom: bottomColor3.bottom;  
        onColorPicked: setTextColor(clr);     
    }    
    
    //align to parent's left && vertical center
    ColorPicker {
        id: leftVCenterColor;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.verticalCenter: parent.verticalCenter;
        onColorPicked: setTextColor(clr);     
    }  
          
    //align to parent's right && vertical center
    ColorPicker {
        id: rightVCenterColor;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.right: parent.right;
        anchors.rightMargin: 4;
        anchors.verticalCenter: parent.verticalCenter;
        onColorPicked: setTextColor(clr);     
    }      
    
    //align to parent's top && horizontal center
    ColorPicker {
        id: topHCenterColor;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.top: parent.top;
        anchors.topMargin: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        onColorPicked: setTextColor(clr);     
    }  

    //align to parent's bottom && horizontal center
    ColorPicker {
        id: bottomHCenterColor;
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        onColorPicked: setTextColor(clr);     
    }    
}
