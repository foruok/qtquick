import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    QtObject{
        id: attrs;
        property int counter;
        Component.onCompleted:{
            attrs.counter = 10;
        }
    }
    
    Text {
        id: countShow;
        anchors.centerIn: parent;
        color: "blue";
        font.pixelSize: 40;
    }
    
    Timer {
        id: countDown;
        interval: 1000;
        repeat: true;
        triggeredOnStart: true;
        onTriggered:{
            countShow.text = attrs.counter;
            attrs.counter -= 1;
            if(attrs.counter < 0)
            {
                countDown.stop();
                countShow.text = "Clap Now!";
            }
        }
    }
    
    Button {
        id: startButton;
        anchors.top: countShow.bottom;
        anchors.topMargin: 20;
        anchors.horizontalCenter: countShow.horizontalCenter;
        text: "Start";
        onClicked: {   
            attrs.counter = 10;         
            countDown.start();
        }
    }
}
