import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1

Rectangle {
    id: root;
    anchors.fill: parent;
    color: "black";
    property bool canNavigation: false;
    signal back();

    function prev(){
        if(canNavigation){
            imageViewer.scale = 1;
            imageViewer.rotation = 0;
            imageViewer.source = dirTraverse.prev();
        }
    }

    function next(){
        if(canNavigation){
            imageViewer.scale = 1;
            imageViewer.rotation = 0;
            imageViewer.source = dirTraverse.next();
        }
    }

    Keys.onPressed: {
        switch(event.key){
        case Qt.Key_Home:
        case Qt.Key_Back:
            event.accepted = true;
            back();
            break;
        case Qt.Key_Left:
        case Qt.Key_PageUp:
            event.accepted = true;
            prev();
            break;
        case Qt.Key_Right:
        case Qt.Key_PageDown:
            event.accepted = true;
            next();
            break;
        }
    }

    BusyIndicator {
        id: busy;
        running: false;
        anchors.centerIn: parent;
        z: 2;
    }

    Text {
        id: stateLabel;
        color: "white";
        visible: false;
        anchors.centerIn: parent;
        z: 3;
        font.pointSize: 16;
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
                stateLabel.text = qsTr("Unknow error when loading");
            }
        }
    }

    Rectangle {
        id: actionPanel;
        color: "#727272";
        radius: 8;
        width: 440;
        height: 100;
        z: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 8;
        Rectangle {
            id: title;
            color: "#404040";
            x: 0;
            y: 0;
            width: parent.width;
            height: 40;
            radius: 8;
            Text {
                id: imagePath;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.margins: 8;
                anchors.verticalCenter: parent.verticalCenter;
                font.pointSize: 10;
                color: "white";
                elide: Text.ElideLeft;
            }
        }
        Row {
            anchors.margins: 4;
            anchors.top: title.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            spacing: 4;
            FlatButton {
                iconSource: "icons/ic_archive.png";
                width: 50;
                height: 50;
                onClicked: fileDialog.open();
            }
            FlatButton {
                iconSource: "icons/ic_back.png";
                width: 50;
                height: 50;
                onClicked: root.back();
            }
            FlatButton {
                iconSource: "icons/ic_zoomin.png";
                width: 50;
                height: 50;
                onClicked: {
                    var factor = imageViewer.scale;
                    if(factor < 1){
                        imageViewer.scale = factor + 0.25;
                    }else if(factor < 16){
                        imageViewer.scale = factor + 1;
                    }
                }
            }
            FlatButton {
                iconSource: "icons/ic_zoomout.png";
                width: 50;
                height: 50;
                onClicked: {
                    var factor = imageViewer.scale;
                    if(factor > 1){
                        imageViewer.scale = factor - 1;
                    }else if(factor > 0.25){
                        imageViewer.scale = factor - 0.25;
                    }
                }
            }
            FlatButton {
                iconSource: "icons/ic_backward.png";
                width: 50;
                height: 50;
                onClicked: root.prev();
            }
            FlatButton {
                iconSource: "icons/ic_forward.png";
                width: 50;
                height: 50;
                onClicked: root.next();
            }
            FlatButton {
                iconSource: "icons/ic_rotate_left.png";
                width: 50;
                height: 50;
                onClicked: imageViewer.rotation -= 90;
            }
            FlatButton {
                iconSource: "icons/ic_rotate_right.png";
                width: 50;
                height: 50;
                onClicked: imageViewer.rotation += 90;
            }
        }

        states:[
            State {
                name: "hide";
                PropertyChanges{
                    target: actionPanel;
                    restoreEntryValues: false;
                    opacity: 0;
                }
            },
            State {
                name: "show";
                PropertyChanges{
                    target: actionPanel;
                    restoreEntryValues: false;
                    opacity: 1;
                    visible: true;
                }
            }
        ]
        state: "show";
        transitions: [
            Transition {
                from: "hide";
                to: "show";
                NumberAnimation {
                    properties: "opacity";
                    duration: 800;
                }
            },
            Transition {
                from: "show";
                to: "hide";
                SequentialAnimation {
                    NumberAnimation {
                        properties: "opacity";
                        duration: 800;
                    }
                    PropertyAction {
                        property: "visible";
                        value: false;
                    }
                }
            }
        ]
    }

    FileDialog {
        id: fileDialog;
        title: qsTr("Please choose an image file");
        nameFilters: ["Image Files (*.jpg *.png *.gif)",
            "Bitmap File (*.bmp)", "* (*.*)"];
        selectedNameFilter: "Image Files (*.jpg *.png *.gif)";
        onAccepted: {
            root.canNavigation = false;
            dirTraverse.folder = folder;
            imageViewer.scale = 1;
            imageViewer.rotation = 0;
            imageViewer.source = fileUrl;
            var imageFile = new String(fileUrl);
            //remove file:///
            if(Qt.platform.os == "windows"){
                imagePath.text = imageFile.slice(8);
            }else{
                imagePath.text = imageFile.slice(7);
            }
        }
    }

    function onDirTraverseUpdated(){
        dirTraverse.current = imagePath.text;
        canNavigation = (dirTraverse.currentIndex >= 0 && dirTraverse.count() > 1);
        //console.log("onDirTraverseUpdated, ", dirTraverse.currentIndex);
    }

    Component.onCompleted: {
        dirTraverse.updated.connect(onDirTraverseUpdated);
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            if( actionPanel.state == "show"){
                actionPanel.state = "hide";
            }else{
                actionPanel.state = "show";
            }

            mouse.accepted = true;
        }
    }
}
