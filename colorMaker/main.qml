import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 360;
    height: 360;
    Text {
        id: timeLabel;
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.top: parent.top;
        anchors.topMargin: 4;
        font.pixelSize: 26;
    }

    Rectangle {
        id: colorRect;
        anchors.centerIn: parent;
        width: 200;
        height: 200;
        color: "blue";
    }

    Button {
        id: start;
        text: "start";
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        onClicked: {
            colorMaker.start();
        }
    }
    Button {
        id: stop;
        text: "stop";
        anchors.left: start.right;
        anchors.leftMargin: 4;
        anchors.bottom: start.bottom;
        onClicked: {
            colorMaker.stop();
        }
    }
    Button {
        id: colorAlgorithm;
        text: "RandomRGB";
        anchors.left: stop.right;
        anchors.leftMargin: 4;
        anchors.bottom: start.bottom;
        onClicked: {
            var algorithm = (colorMaker.algorithm() + 1) % 5;
            switch(algorithm)
            {
            case 0:
                text = "RandomRGB";
                break;
            case 1:
                text = "RandomRed";
                break;
            case 2:
                text = "RandomGreen";
                break;
            case 3:
                text = "RandomBlue";
                break;
            case 4:
                text = "LinearIncrease";
                break;
            }
            colorMaker.setAlgorithm(algorithm);
        }
    }

    Button {
        id: quit;
        text: "quit";
        anchors.left: colorAlgorithm.right;
        anchors.leftMargin: 4;
        anchors.bottom: start.bottom;
        onClicked: {
            Qt.quit();
        }
    }
    Component.onCompleted: {
        colorMaker.color = Qt.rgba(0,180,120, 255);
        colorMaker.setAlgorithm(2);
    }

    Connections {
        target: colorMaker;
        onCurrentTime:{
            timeLabel.text = strTime;
            timeLabel.color = colorMaker.timeColor;
        }
    }

    Connections {
        target: colorMaker;
        onColorChanged:{
            colorRect.color = color;
        }
    }
}
