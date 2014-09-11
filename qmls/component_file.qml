import QtQuick 2.2

Rectangle {
    width: 320;
    height: 240;
    color: "#EEEEEE";
    
    Text {
        id: coloredText;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        anchors.topMargin: 4;
        text: "Hello World!";
        font.pixelSize: 32;
    }
    
    function setTextColor(clr){
        coloredText.color = clr;
    }
    
    ColorPicker {
        id: redColor;
        color: "red";
        focus: true;
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;

        KeyNavigation.right: blueColor;
        KeyNavigation.tab: blueColor;  
        onColorPicked:{
            coloredText.color = clr;
        }      
    }
    
    ColorPicker {
        id: blueColor;
        color: "blue";
        anchors.left: redColor.right;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;

        KeyNavigation.left: redColor;
        KeyNavigation.right: pinkColor;
        KeyNavigation.tab: pinkColor;   
    }
    
    ColorPicker {
        id: pinkColor;
        color: "pink";
        anchors.left: blueColor.right;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;

        KeyNavigation.left: blueColor;
        KeyNavigation.tab: redColor;   
    }
    
    Component.onCompleted:{
        blueColor.colorPicked.connect(setTextColor);
        pinkColor.colorPicked.connect(setTextColor);
    }
}
