import QtQuick 2.0
import QtQuick.Controls 1.1

/*
Rectangle {
    width: 360
    height: 360
    Text {
        text: qsTr("Hello Qt Quick App")
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
}
*/
Rectangle {
    width: 480;
    height: 320;
    color: "#121212";

    BusyIndicator {
        id: busy;
        running: true;
        anchors.centerIn: parent;
        z: 2;
    }

    Label {
        id: stateLabel;
        visible: false;
        anchors.centerIn: parent;
        z: 3;
    }

    Image {
        id: imageViewer;
        asynchronous: true;
        cache: false;
        anchors.fill: parent;
        fillMode: Image.PreserveAspectFit;
        onStatusChanged: {
            if (imageViewer.status === Image.Loading) {
                busy.running = true;
                stateLabel.visible = false;
            }
            else if(imageViewer.status === Image.Ready){
                busy.running = false;
            }
            else if(imageViewer.status === Image.Error){
                busy.running = false;
                stateLabel.visible = true;
                stateLabel.text = "ERROR";
            }
        }
    }

    Component.onCompleted: {
        imageViewer.source = "http://image.cuncunle.com/Images/EditorImages/2013/01/01/19/20130001194920468.JPG";
    }
}

