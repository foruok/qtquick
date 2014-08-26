import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1

Rectangle {
    id: scene;
    anchors.fill: parent;
    color: "black";
    signal back();

    MouseArea {
        anchors.fill: parent;
        acceptedButtons: Qt.RightButton;
        onClicked: scene.back();
    }

    Path {
        id: curvePath
        startX: 4;
        startY: scene.height/2 - 60;

        PathCurve { x: scene.width/8; y: scene.height/2 - 10; }
        PathCurve { x: scene.width/4; y: scene.height/2 - 110; }
        PathCurve { x: scene.width/2; y: scene.height/2 + 10;}
        PathAttribute { name: "zOrder"; value: 100; }
        PathCurve { x: scene.width*3/4; y: scene.height/2 - 110; }
        PathCurve { x: scene.width*7/8; y: scene.height/2 - 10; }
        PathCurve { x: scene.width; y: scene.height/2 - 60; }
    }

    Component {
        id: imageDelegate;
        Rectangle {
            id: wrapper;
            z: PathView.zOrder;
            color: (PathView.view.currentIndex == index) ? "black" : "transparent";
            implicitWidth: (scene.width -60) / imageView.pathItemCount;
            implicitHeight: ((scene.width -60)*3) / (2*imageView.pathItemCount);
            border.width: (PathView.view.currentIndex == index) ? 2 : 0;
            border.color: PathView.view.focus ? "#a00000" : "lightgray";
            scale: (PathView.view.currentIndex == index) ? 2 : 1;
            Image {
                anchors.margins: 2;
                anchors.fill: parent;
                id: poster;
                source: imageUrl;
                fillMode: Image.PreserveAspectFit;
                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        if(wrapper.PathView.view.focus == false){
                            wrapper.PathView.view.focus = true;
                            searchEdit.focus = false;
                        }
                        if(wrapper.PathView.view.currentIndex === index){
                            wrapper.PathView.view.showDetail();
                        }else{
                            wrapper.PathView.view.currentIndex = index;
                        }
                    }
                }
                onStatusChanged: {
                    if(status == Image.Error){
                        stateLabel.visible = true;
                    }
                }
                Text {
                    id: stateLabel;
                    font.pointSize: 14;
                    text: qsTr("Sorry...");
                    anchors.centerIn: parent;
                    visible: false;
                    color: "gray";
                }
            }
        }
    }

    PathView {
        id: imageView;
        z: 1;
        anchors.fill: parent;
        pathItemCount: calcItemCount();
        // keep highlight sit on the middle of Path
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        highlightRangeMode: PathView.StrictlyEnforceRange;

        delegate: imageDelegate;
        model: imageModel;
        path: curvePath;

        //focus: true;
        activeFocusOnTab: true;
        KeyNavigation.down: searchEdit;
        Keys.onLeftPressed: decrementCurrentIndex();
        Keys.onRightPressed: incrementCurrentIndex();
        Keys.onEnterPressed: showDetail();
        Keys.onReturnPressed: showDetail();
        function showDetail(){
            /*
              TODO: ? show big image...
            */
        }

        function calcItemCount(){
            var w = scene.width;
            if(w < 470) return 3;
            if(w < 790) return 5;
            else if( w < 959) return 7;
            else if( w < 1279 ) return 9;
            else return 11;
        }
    }
/*
    Canvas {
        anchors.fill: parent;
        onPaint: {
            var ctx = getContext("2d");
            ctx.strokeStyle = "red";
            ctx.path = curvePath;
            ctx.stroke();
        }
    }
*/
    Text {
        id: searchClue;
        text: qsTr("image keyword");
        font.pointSize: 12;
        verticalAlignment: Text.AlignVCenter;
        height: 30;
        anchors.right: searchBox.left;
        anchors.rightMargin: 4;
        anchors.verticalCenter: searchBox.verticalCenter;
        color: "lightgray";
    }

    Rectangle {
        id: searchBox;
        z: 2;
        border.width: 1;
        border.color: "gray";
        color: "black";
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 8;
        anchors.horizontalCenter: parent.horizontalCenter;
        width: 280;
        height: 52;

        TextInput {
            id: searchEdit;
            anchors.margins: 2;
            anchors.left: parent.left;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: searchButton.left;
            font.pointSize: 18;
            verticalAlignment: TextInput.AlignVCenter;
            color: "white";
            KeyNavigation.up: imageView;
            KeyNavigation.right: searchButton;
            activeFocusOnTab: true;
            onAccepted: {
                imageModel.keyword = encodeURIComponent(text);
            }
        }

        FlatButton {
            id: searchButton;
            anchors.verticalCenter: searchEdit.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 2;
            width: 50;
            height: 50;
            iconSource: "icons/ic_search.png";
            onClicked: imageModel.keyword = encodeURIComponent(searchEdit.text);
        }
    }
}
