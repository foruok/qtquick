import QtQuick 2.2
import QtQuick.Layouts 1.1

Rectangle {
    width: 400;
    height: 200;
    color: "#EEEEEE";

    RowLayout {
        anchors.fill: parent;
        spacing: 4;
        Repeater {
            model: 8;
            Rectangle {
                width: 46;
                height: 30;
                color: "steelblue";
                Text {
                    anchors.fill: parent;
                    color: "black";
                    font.pointSize: 14;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter;
                    text: index;
                }
            }
        }
    }
}
