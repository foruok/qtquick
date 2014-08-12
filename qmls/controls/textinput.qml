import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    color: "lightgray";

    TextInput {
        width: 240;
        height: 30;
        font.pixelSize: 20;
        anchors.centerIn: parent;
        selectByMouse: true;
        /*
        validator: RegExpValidator{ 
            regExp: new RegExp("(2[0-5]{2}|2[0-4][0-9]|1?[0-9]{1,2})\\.(2[0-5]{2}|2[0-4][0-9]|1?[0-9]{1,2})\\.(2[0-5]{2}|2[0-4][0-9]|1?[0-9]{1,2})\\.(2[0-5]{2}|2[0-4][0-9]|1?[0-9]{1,2})");
        }
        */
        //inputMask: "000.000.000.000;_";
        focus: true;
        selectedTextColor: "red";
        selectionColor: "blue";
    }    
}
