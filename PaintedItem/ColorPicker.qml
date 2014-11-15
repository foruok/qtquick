import QtQuick 2.2
import QtQuick.Dialogs 1.0

Rectangle {
    id: colorPicker;
    width: 64;
    height: 60;
    color: "lightgray";
    border.width: 2;
    border.color: "darkgray";
    property alias text: label.text;
    property alias textColor: label.color;
    property alias font: label.font;
    property alias selectedColor: currentColor.color;
    property var colorDialog: null;

    signal colorPicked(color clr);

    Rectangle {
        id: currentColor;
        anchors.top: parent.top;
        anchors.topMargin: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        width: parent.width - 12;
        height: 30;
    }

    Text {
        id: label;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        font.pointSize: 14;
        color: "blue";
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: if(colorDialog == null){
            colorDialog = Qt.createQmlObject("import QtQuick 2.2;import QtQuick.Dialogs 1.0; ColorDialog{}",
                                             colorPicker, "dynamic_color_dialog");
            colorDialog.accepted.connect(colorPicker.onColorDialogAccepted);
            colorDialog.rejected.connect(colorPicker.onColorDialogRejected);
            colorDialog.open();
        }
    }
    function onColorDialogAccepted(){
        selectedColor = colorDialog.color;
        colorPicked(colorDialog.color);
        colorDialog.destroy();
        colorDialog = null;
    }

    function onColorDialogRejected(){
        colorPicked(color);
        colorDialog.destroy();
        colorDialog = null;
    }
}
