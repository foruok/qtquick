import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2

Window {
    id: root;
    visible: true;
    width: 400;
    height: 360;
    color: "lightgray";
    title: qsTr("MadMath");
    property bool playing: false;
    property int bestRecord: 0;
    property int currentRecord: 0;
    property real dpiFactor: sizeUtil.dpiFactor();

    Text {
        id: countDown;
        property int seconds: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: problem.top;
        anchors.bottomMargin: 20;
        horizontalAlignment: Text.AlignHCenter;
        color: "brown";
        font.bold: true;

        signal timeout();

        Timer {
            id: countTimer;
            interval: 1000;
            repeat: true;
            onTriggered: countDown.oneSecondGone();
        }

        function oneSecondGone(){
            if(seconds == 0){
                countTimer.stop();
                timeout();
            }else{
                seconds -= 1;
                text = seconds;
            }
        }

        function restart() {
            seconds = 3;
            text = seconds;
            countTimer.restart();
        }

        function stop(){
            seconds = 4;
            text = seconds;
            countTimer.stop();
        }
    }

    Text {
        id: problem;
        anchors.centerIn: parent;
        color: "blue";
        font.pointSize: 28;
        font.bold: true;
        horizontalAlignment: Text.horizontalCenter;
    }

    ImageButton {
        id: wrong;
        anchors.right: parent.horizontalCenter;
        anchors.rightMargin: 12;
        anchors.top: problem.bottom;
        anchors.topMargin: 20;
        normalImage: Qt.resolvedUrl("res/wrong_normal.png");
        pressedImage: Qt.resolvedUrl("res/wrong_selected.png");
        width: root.dpiFactor * 64;
        height: root.dpiFactor * 48;
        onClicked: root.check(false);
    }

    ImageButton {
        id: right;
        anchors.left: parent.horizontalCenter;
        anchors.leftMargin: 12;
        anchors.top: problem.bottom;
        anchors.topMargin: 20;
        normalImage: Qt.resolvedUrl("res/right_normal.png");
        pressedImage: Qt.resolvedUrl("res/right_selected.png");
        width: root.dpiFactor * 64;
        height: root.dpiFactor * 48;
        onClicked: root.check(true);
    }

    Rectangle {
        id: gameOverUI;
        border.width: 2;
        border.color: "white";
        color: "lightsteelblue";
        width: root.width * 0.75;
        height: root.height * 0.75;
        x: root.width * 0.125;
        y: -height-1;
        visible: false;

        Text {
            id: overTitle;
            anchors.top: parent.top;
            anchors.topMargin: sizeUtil.defaultFontHeight();
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pointSize: 30;
            text: qsTr("Game Over");
            color: "red";
        }

        Text {
            anchors.bottom: parent.verticalCenter;
            anchors.bottomMargin: 10;
            anchors.right: parent.horizontalCenter;
            anchors.rightMargin: 8;
            text: qsTr("New:");
            horizontalAlignment: Text.AlignRight;
            color: "black";
        }

        Text {
            id: current;
            anchors.bottom: parent.verticalCenter;
            anchors.bottomMargin: 10;
            anchors.left: parent.horizontalCenter;
            anchors.leftMargin: 8;
            horizontalAlignment: Text.AlignLeft;
            color: "blue";
            font.bold: true;
        }

        Text {
            anchors.top: current.bottom;
            anchors.topMargin: 20;
            anchors.right: parent.horizontalCenter;
            anchors.rightMargin: 8;
            text: qsTr("Best:");
            horizontalAlignment: Text.AlignRight;
            color: "black";
        }
        Text {
            id: best;
            anchors.top: current.bottom;
            anchors.topMargin: 20;
            anchors.left: parent.horizontalCenter;
            anchors.leftMargin: 8;
            horizontalAlignment: Text.AlignLeft;
            color: "blue";
            font.bold: true;
        }

        Button {
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 40;
            anchors.right: parent.horizontalCenter;
            anchors.rightMargin: 16;
            text: qsTr("Restart");
            onClicked: {
                gameOverUI.dismiss();
                root.start();
            }
        }

        Button {
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 40;
            anchors.left: parent.horizontalCenter;
            anchors.leftMargin: 16;
            text: qsTr("Quit");
            onClicked: Qt.quit();
        }

        SpringAnimation {
            id: overAnimation;
            target: gameOverUI;
            from: -height - 1;
            to: root.height * 0.125;
            spring: 2;
            damping: 0.2;
            duration: 1000;
            property: "y";

            onStarted: {
                gameOverUI.visible = true;
            }
        }

        function dismiss() {
            y = -height - 1;
            visible = false;
        }
        function fire(currentRecord, bestRecord) {
            current.text = currentRecord;
            best.text = bestRecord;
            overAnimation.start();
        }
    }

    function check(right){
        start();
        if( problems.test(right) ){
            currentRecord += 1;
            next();
        }else{
            gameOver();
        }
    }

    function gameOver() {
        if(bestRecord < currentRecord){
            bestRecord = currentRecord;
        }
        gameOverUI.fire(currentRecord, bestRecord);
        stop();
    }

    function next() {
        countDown.restart();
        problem.text = problems.next();
    }

    function start(){
        if(!playing){
            playing = true;
            next();
        }
    }

    function stop(){
        if(playing){
            playing = false;
            currentRecord = 0;
            countDown.stop();
            problems.reset();
        }
    }

    Connections {
        target: countDown;
        onTimeout: root.gameOver();
    }

    Component.onCompleted: {
        start();
        countDown.seconds = 4;
    }
}
