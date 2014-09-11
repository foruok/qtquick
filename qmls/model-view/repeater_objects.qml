import QtQuick 2.2

Rectangle {
    width: 320;
    height: 200;
    color: "#EEEEEE";

    Column {
        anchors.fill: parent;
        anchors.margins: 4;
        spacing: 4;
        Repeater {
            model: [
                {"name":"Zhang San", "mobile":"13888888888"},
                {"name":"Wang Er", "mobile":"13999999999"},
                {"name":"Liu Wu", "mobile":"15866666666"},
            ]
            Row {
                height: 30;
                Text{
                    width: 100;
                    color: "blue";
                    font.pointSize: 13;
                    font.bold: true;
                    verticalAlignment: Text.AlignVCenter;
                    text: modelData.name;
                }
                Text{
                    width: 200;
                    font.pointSize: 13;
                    verticalAlignment: Text.AlignVCenter;
                    text: modelData.mobile;
                }
            }
        }
    }
}
