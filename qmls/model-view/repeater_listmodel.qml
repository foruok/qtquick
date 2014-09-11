import QtQuick 2.2

Rectangle {
    width: 300;
    height: 200;
    color: "#EEEEEE";

    Column {
        anchors.fill: parent;
        anchors.margins: 4;
        spacing: 4;
        Repeater {
            model: ListModel {
                ListElement{
                    name: "MI4";
                    cost: "1999";
                    manufacturer: "Xiaomi";
                }
                ListElement{
                    name: "MX4";
                    cost: "1999";
                    manufacturer: "Meizu";
                }
                ListElement{
                    name: "iPhone6";
                    cost: "5500";
                    manufacturer: "Apple";
                }
                ListElement{
                    name: "C199";
                    cost: "1599";
                    manufacturer: "Huawei";
                }
            }
            Row {
                height: 30;
                Text{
                    width: 120;
                    color: "blue";
                    font.pointSize: 14;
                    font.bold: true;
                    verticalAlignment: Text.AlignVCenter;
                    text: name;
                }
                Text{
                    width: 100;
                    font.pointSize: 14;
                    verticalAlignment: Text.AlignVCenter;
                    text: cost;
                }
                Text{
                    width: 100;
                    font.pointSize: 12;
                    verticalAlignment: Text.AlignVCenter;
                    text: manufacturer;
                }
            }
        }
    }
}
