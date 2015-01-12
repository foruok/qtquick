import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

Window {
    visible: true;
    width: 360;
    height: 320;
    color: "black";

    AnimatedSprite {
        id: animated;
        width: 64;
        height: 64;
        anchors.centerIn: parent;
        source: "qrc:/numbers.png";
        frameWidth: 64;
        frameHeight: 64;
        frameDuration: 200;
        frameCount: 10;
        frameX: 0;
        frameY: 0;

        onCurrentFrameChanged: {
            info.text = "%1/%2".arg(animated.currentFrame).arg(animated.frameCount);
        }
    }

    Row{
        spacing: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        Text {
            id: info;
            width: 60;
            height: 24;
            color: "red";
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignRight;
        }

        Button {
            width: 60;
            height: 24;
            text: (animated.paused == true) ? "Play" : "Pause";
            onClicked: (animated.paused == true) ? animated.resume() : animated.pause();
        }

        Button {
            width: 70;
            height: 24;
            text: "Advance";
            onClicked: animated.advance();
        }

        Button {
            width: 70;
            height: 24;
            text: "Restart";
            onClicked: animated.restart();
        }


        Button {
            width: 60;
            height: 24;
            text: "Quit";
            onClicked: Qt.quit();
        }
    }
}
