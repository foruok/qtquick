import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    width: 320;
    height: 240;
    color: "lightgray";
    Row {
        anchors.fill: parent;
        spacing: 20;
        Column{
            width: 200;
            spacing: 16;
            Text {
                id: sliderStat;
                color: "blue";
                text: "current - 0.1";
            }
            Slider {
                width: 200;
                height: 30;
                stepSize: 0.01;
                value: 0.1;
                onValueChanged: {
                    sliderStat.text = "current - " + value;
                }
                Component.onCompleted: console.log(activeFocusOnPress);
            }

            Slider {
                width: 200;
                height: 30;
                minimumValue: 0;
                maximumValue: 100;
                stepSize: 1;
                value: 50;
                tickmarksEnabled: true;
            }
            Slider {
                id: customGrooveAndHandle;
                width: 200;
                height: 30;
                stepSize: 0.1;
                value: 0;
                tickmarksEnabled: true;
                style: SliderStyle {
                    groove: Rectangle {
                        implicitWidth: 200;
                        implicitHeight: 8;
                        color: "gray";
                        radius: 8;
                    }
                    handle: Rectangle {
                        anchors.centerIn: parent;
                        color: control.pressed ? "white" : "lightgray";
                        border.color: "gray";
                        border.width: 2;
                        width: 34;
                        height: 34;
                        radius: 12;
                    }
                }
            }
            Slider {
                id: customPanel;
                width: 200;
                height: 36;
                stepSize: 0.1;
                value: 0;
                tickmarksEnabled: true;
                style: SliderStyle {
                    groove: Rectangle {
                        implicitWidth: 200;
                        implicitHeight: 8;
                        color: "gray";
                        radius: 8;
                    }
                    handle: Rectangle {
                        anchors.centerIn: parent;
                        color: control.pressed ? "white" : "lightgray";
                        border.color: "gray";
                        border.width: 2;
                        width: 34;
                        height: 34;
                        radius: 12;
                        Text {
                            anchors.centerIn: parent;
                            text: control.value;
                            color: "red";
                        }
                    }
                    panel: Rectangle {
                        anchors.fill: parent;
                        radius: 4;
                        color: "lightsteelblue";
                        Loader {
                            id: grooveLoader;
                            anchors.centerIn: parent;
                            sourceComponent: groove;
                        }
                        Loader {
                            id: handleLoader;
                            anchors.verticalCenter: grooveLoader.verticalCenter;
                            x: Math.min(grooveLoader.x + (control.value * grooveLoader.width) / (control.maximumValue - control.minimumValue), grooveLoader.width - item.width);
                            sourceComponent: handle;
                        }
                    }
                }
            }
        }
        Slider {
            width: 30;
            height: 200;
            orientation: Qt.Vertical;
            stepSize: 0.1;
            value: 0.2;
            tickmarksEnabled: true;
        }
    }
}
