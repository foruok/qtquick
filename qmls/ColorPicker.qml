import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    id: colorPicker;
    width: 50;
    height: 30;
    signal colorPicked(color clr);
    
    function configureBorder(){
        colorPicker.border.width = colorPicker.focus ? 2 : 0;  
        colorPicker.border.color = colorPicker.focus ? "#90D750" : "#808080"; 
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: {
            colorPicker.colorPicked(colorPicker.color);
            mouse.accepted = true;
            colorPicker.focus = true;
        }
    }
    Keys.onReturnPressed: {
        colorPicker.colorPicked(colorPicker.color);
        event.accepted = true;
    }
    Keys.onSpacePressed: {
        colorPicker.colorPicked(colorPicker.color);
        event.accepted = true;
    }
    
    onFocusChanged: {
        configureBorder();
    }
    
    Component.onCompleted: {
        configureBorder();
    }
}