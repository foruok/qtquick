import QtQuick 2.2
import QtQuick.Window 2.1
import an.qml.Controls 1.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2

Window {
    visible: true;
    minimumWidth: 600;
    minimumHeight: 480;

    Rectangle {
        id: options;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.top: parent.top;
        implicitHeight: 70;
        color: "lightgray";
        Component{
            id: btnStyle;
            ButtonStyle {
                background: Rectangle {
                    implicitWidth: 70;
                    implicitHeight: 28;
                    border.width: control.hovered ? 2 : 1;
                    border.color: "#888";
                    radius: 4;
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }

                label: Text {
                    text: control.text;
                    font.pointSize: 12;
                    color: "blue";
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment: Text.AlignVCenter;
                }
            }
        }
        ColorPicker {
            id: background;
            anchors.left: parent.left;
            anchors.leftMargin: 4;
            anchors.verticalCenter: parent.verticalCenter;
            text: "背景";
            selectedColor: "white";
            onColorPicked: painter.fillColor = clr;
        }
        ColorPicker {
            id: foreground;
            anchors.left: background.right;
            anchors.top: background.top;
            anchors.leftMargin: 4;
            text: "前景";
            selectedColor: "black";
            onColorPicked: painter.penColor = clr;
        }
        Rectangle {
            id: splitter;
            border.width: 1;
            border.color: "gray";
            anchors.left: foreground.right;
            anchors.leftMargin: 4;
            anchors.top: foreground.top;
            width: 3;
            height: foreground.height;
        }
        Slider {
            id: thickness;
            anchors.left: splitter.right;
            anchors.leftMargin: 4;
            anchors.bottom: splitter.bottom;
            minimumValue: 1;
            maximumValue: 100;
            stepSize: 1.0;
            value: 1;
            width: 280;
            height: 24;
            onValueChanged: if(painter != null)painter.penWidth = value;
        }

        Text {
            id: penThickLabel;
            anchors.horizontalCenter: thickness.horizontalCenter;
            anchors.bottom: thickness.top;
            anchors.bottomMargin: 4;
            text: "画笔:%1px".arg(thickness.value);
            font.pointSize: 16;
            color: "steelblue";
        }

        Text {
            id: minLabel;
            anchors.left: thickness.left;
            anchors.bottom: thickness.top;
            anchors.bottomMargin: 2;
            text: thickness.minimumValue;
            font.pointSize: 12;
        }

        Text {
            id: maxLabel;
            anchors.right: thickness.right;
            anchors.bottom: thickness.top;
            anchors.bottomMargin: 2;
            text: thickness.maximumValue;
            font.pointSize: 12;
        }
        Rectangle {
            id: splitter2;
            border.width: 1;
            border.color: "gray";
            anchors.left: thickness.right;
            anchors.leftMargin: 4;
            anchors.top: foreground.top;
            width: 3;
            height: foreground.height;
        }

        Button {
            id: clear;
            anchors.left: splitter2.right;
            anchors.leftMargin: 4;
            anchors.verticalCenter: splitter2.verticalCenter;
            width: 70;
            height: 28;
            text: "清除";
            style: btnStyle;
            onClicked: painter.clear();
        }

        Button {
            id: undo;
            anchors.left: clear.right;
            anchors.leftMargin: 4;
            anchors.top: clear.top;
            width: 70;
            height: 28;
            text: "撤销";
            style: btnStyle;
            onClicked: painter.undo();
        }

        Rectangle {
            border.width: 1;
            border.color: "gray";
            width: parent.width;
            height: 2;
            anchors.bottom: parent.bottom;
        }
    }

    APaintedItem {
        id: painter;
        anchors.top: options.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
    }
}
