import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import QtMultimedia 5.0

Window {
    width: 800;
    height: 480;
    minimumWidth: 800;
    minimumHeight: 480;
    visible: true;
    color: "black";
    id: root;

    Component {
        id: videoDelegate;
        Item {
            id: wrapper;
            width: 160;
            z: PathView.zOrder;
            scale: PathView.isCurrentItem ? 1.2 : PathView.itemScale;
            opacity: PathView.itemAlpha;

            Image {
                anchors.top: parent.top;
                anchors.topMargin: 10;
                anchors.horizontalCenter: parent.horizontalCenter;
                id: poster;
                source: img;
                width: 160;
                height: 240;
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
            }

            Canvas {
                visible: wrapper.PathView.isCurrentItem;
                width: 172;
                height: 252;
                anchors.horizontalCenter: poster.horizontalCenter;
                anchors.verticalCenter: poster.verticalCenter;
                z: poster.z - 0.1;
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.lineWidth = 6;
                    ctx.strokeStyle = "red";
                    ctx.beginPath();
                    ctx.moveTo(3, 3);
                    ctx.lineTo(width - 3, 3);
                    ctx.lineTo(width - 3, height - 3);
                    ctx.lineTo(3, height - 3);
                    ctx.lineTo(3, 3);
                    ctx.stroke();
                }
            }

            Text {
                id: videoName;
                anchors.top: poster.bottom;
                anchors.topMargin: 8;
                anchors.horizontalCenter: poster.horizontalCenter;
                visible: wrapper.PathView.isCurrentItem;
                text: name;
                color: wrapper.PathView.isCurrentItem ? "blue" : "black";
                font.pointSize: 16;
            }
            Text {
                anchors.top: videoName.bottom;
                anchors.horizontalCenter: videoName.horizontalCenter;
                visible: wrapper.PathView.isCurrentItem;
                text: date;
                color: wrapper.PathView.isCurrentItem ? "blue" : "black";
                font.pointSize: 12;
                elide: Text.ElideRight;
            }
        }
    }
    Path {
        id: linePath;
        startX: 0;
        startY: 0;
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemScale"; value: 0.3 }
        PathAttribute { name: "itemAlpha"; value: 0.4 }
        PathLine {
            x: videoView.width /2;
            y: 0;
        }
        PathAttribute { name: "zOrder"; value: 100 }
        PathAttribute { name: "itemScale"; value: 1.0 }
        PathAttribute { name: "itemAlpha"; value: 1.0 }
        PathLine {
            x: videoView.width;
            y: 0;
        }
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemScale"; value: 0.3 }
        PathAttribute { name: "itemAlpha"; value: 0.4 }
    }
/*
    Path {
        id: arcPath;
        startX: root.width/2;
        startY: 20;
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemScale"; value: 0.3 }
        PathAttribute { name: "itemAlpha"; value: 0.4 }
        PathArc {
            x: root.width/2;
            y: 140;
            radiusX: 220;
            radiusY: 60;
        }
        PathAttribute { name: "zOrder"; value: 100 }
        PathAttribute { name: "itemScale"; value: 1.0 }
        PathAttribute { name: "itemAlpha"; value: 1.0 }
        PathArc {
            x: root.width/2;
            y: 20;
            radiusX: 220;
            radiusY: 60;
        }
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemScale"; value: 0.3 }
        PathAttribute { name: "itemAlpha"; value: 0.4 }
    }

    Path {
        id: cubicPath;
        startX: 20;
        startY: 20;
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemScale"; value: 0.6 }
        PathAttribute { name: "itemAlpha"; value: 0.4 }
        PathCubic {
            x: root.width / 2;
            y: root.height - 260;
            control1X: 40;
            control1Y: root.height - 260;
            control2X: root.width /2;
            control2Y: root.height - 260;
        }
        PathAttribute { name: "zOrder"; value: 100 }
        PathAttribute { name: "itemScale"; value: 1.0 }
        PathAttribute { name: "itemAlpha"; value: 1.0 }
        PathCubic {
            x: root.width -20;
            y: 20;
            control2X: root.width - 40;
            control2Y: root.height - 260;
            control1X: root.width /2;
            control1Y: root.height - 260;
        }
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemScale"; value: 0.6 }
        PathAttribute { name: "itemAlpha"; value: 0.4 }
    }
*/
    PathView {
        id: videoView;
        z: 1;
        anchors.left: parent.left;
        anchors.leftMargin: 100;
        anchors.right: parent.right;
        anchors.rightMargin: 100;
        anchors.bottom: parent.bottom;
        height: 370;
        pathItemCount: 13;
        // keep highlight sit on the middle of Path
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        highlightRangeMode: PathView.StrictlyEnforceRange;
        //snapMode: PathView.SnapToItem;

        delegate: videoDelegate;
        model: vmodel;
        path: linePath;

        states:[
            State {
                name: "hide";
                PropertyChanges{
                    target: videoView;
                    restoreEntryValues: false;
                    opacity: 0;
                }
            },
            State {
                name: "show";
                PropertyChanges{
                    target: videoView;
                    restoreEntryValues: false;
                    opacity: 1;
                    visible: true;
                    focus: true;
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

                PropertyAction {
                    targets: [searchBox, searchClue];
                    property: "visible";
                    value: true;
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
                        targets: [videoView, searchBox, searchClue];
                        property: "visible";
                        value: false;
                    }
                }
            }
        ]

        focus: true;
        activeFocusOnTab: true;
        KeyNavigation.up: searchEdit;
        Keys.onLeftPressed: decrementCurrentIndex();
        Keys.onRightPressed: incrementCurrentIndex();
        Keys.onEnterPressed: showDetail();
        Keys.onReturnPressed: showDetail();
        function showDetail(){
            vmodel.updateCurrentVideo(currentIndex);
            detail.updateDetail();
            detail.state = "show";
            state = "hide";
        }
    }

    Text {
        id: searchClue;
        text: "请输入影片的首字母：";
        height: 30;
        anchors.left: searchBox.left;
        anchors.bottom: searchBox.top;
        color: "lightgray";
    }
    Rectangle {
        id: searchBox;
        border.width: 1;
        border.color: "gray";
        color: "black";
        anchors.bottom: videoView.top;
        anchors.bottomMargin: 4;
        anchors.horizontalCenter: parent.horizontalCenter;
        width: 320;
        height: 48;

        TextInput {
            id: searchEdit;
            anchors.margins: 2;
            anchors.left: parent.left;
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            width: 246;
            font.pointSize: 20;
            verticalAlignment: TextInput.AlignVCenter;
            color: "white";
            KeyNavigation.down: videoView;
            activeFocusOnTab: true;
            onAccepted: {
                //TODO: search, the model will be updated when search finished
                vmodel.search(text);
            }
        }
        Image {
            anchors.verticalCenter: searchEdit.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 2;
            source: "res/ic_search.png";
        }
    }

    BusyIndicator {
        id: loading;
        anchors.centerIn: parent;
        running: false;
        z: 10;
    }

    Rectangle {
        id: detail;
        visible: false;
        anchors.fill: parent;
        anchors.margins: 50;
        color: "black";
        z: 2;

        property var pageUrl;
        states:[
            State {
                name: "hide";
                PropertyChanges{
                    target: detail;
                    restoreEntryValues: false;
                    opacity: 0;
                }
            },
            State {
                name: "show";
                PropertyChanges{
                    target: detail;
                    restoreEntryValues: false;
                    opacity: 1;
                    visible: true;
                    focus: true;
                }
            }
        ]
        state: "hide";
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

        Text {
            id: vName;
            x: 0;
            y: 0;
            height: 32;
            width: parent.width - 20;
            font.bold: true;
            font.pointSize: 22;
            color: "blue";
        }
        Image {
            id: vPoster;
            anchors.left: vName.left;
            anchors.top: vName.bottom;
            anchors.topMargin: 4;
            width: 200;
            height: 300;
            fillMode: Image.PreserveAspectFit;
        }

        ColumnLayout {
            anchors.left: vPoster.right;
            anchors.leftMargin: 4;
            anchors.right: vName.right;
            anchors.top: vPoster.top;
            height: vPoster.height;
            spacing: 2;
            Text {
                id: date
                Layout.fillWidth: true;
                font.pointSize: 14;
                elide: Text.ElideRight;
                color: "blue";
            }
            Text {
                id: actor;
                Layout.fillWidth: true;
                font.pointSize: 14;
                elide: Text.ElideRight;
                color: "white";
            }
            Text {
                id: director;
                Layout.fillWidth: true;
                font.pointSize: 14;
                elide: Text.ElideRight;
                color: "white";
            }
            Text {
                id: rating;
                Layout.fillWidth: true;
                font.pointSize: 14;
                elide: Text.ElideRight;
                color: "white";
            }
            Text {
                id: playtimes;
                Layout.fillWidth: true;
                Layout.fillHeight: true;
                font.pointSize: 14;
                elide: Text.ElideRight;
                color: "white";
            }

            Image {
                width: 48;
                height: 48;
                source: "res/ic_media_play_focus.png";
            }
        }

        ColumnLayout {
            anchors.left: vPoster.left;
            anchors.right: vName.right;
            anchors.top: vPoster.bottom;
            anchors.topMargin: 10;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 4;
            spacing: 2;
            Text {
                id: descTitle;
                Layout.fillWidth: true;
                font.pointSize: 16;
                font.bold: true;
                color: "white";
            }
            Text {
                id: description;
                Layout.fillHeight: true;
                Layout.fillWidth: true;
                font.pointSize: 13;
                wrapMode: Text.Wrap;
                maximumLineCount: 3;
                elide: Text.ElideRight;
                color: "white";
            }
        }

        function updateDetail() {
            vName.text = currentVideo.name();
            vPoster.source = currentVideo.img();
            date.text = currentVideo.date();
            actor.text = currentVideo.actorTag() + ": " + currentVideo.actor();
            director.text = currentVideo.directorTag() + ": " + currentVideo.director();
            descTitle.text = currentVideo.descTag() + ":";
            description.text = currentVideo.desc();
            rating.text = currentVideo.ratingTag() + ": " + currentVideo.rating();
            playtimes.text = currentVideo.playtimesTag() + ":" + currentVideo.playtimes();
        }
        Keys.onPressed: {
            switch(event.key){
            case Qt.Key_Back:
            case Qt.Key_Escape:
            case Qt.Key_Home:
                event.accepted = true;
                state = "hide";
                videoView.state = "show";
                loading.running = false;
                break;

            case Qt.Key_Return:
            case Qt.Key_Enter:
                //console.log("enter pressed - ", pageUrl);
                loading.running = true;
                event.accepted = true;
                vprobe.startProbe(currentVideo.pageUrl());
                break;

            }
        }

        Connections {
            target: vprobe;
            onProbeFinished:{
                console.log("onProbeFinished - ", bSuccess);
                if(bSuccess){
                    detail.state = "hide";
                    var urls = vprobe.fileUrls();
                    console.log(urls);

                    player.source = urls[0];
                    player.play();
                    playerLayer.visible = true;
                    playerLayer.focus = true;
                }else{
                    loading.running = false;
                }
            }
        }

    }


    Item {
        id: playerLayer;
        z: 3;
        visible: false;
        anchors.fill: parent;
        MediaPlayer {
            id: player;
            onPlaybackStateChanged: {
                switch(playbackState){
                case MediaPlayer.PlayingState:
                    if(loading.running == true) {
                        //console.log("Video Resolution:" , player.metaData.resolution);
                        loading.running = false;
                    }
                    break;
                case MediaPlayer.PausedState:
                    break;
                case MediaPlayer.StoppedState:
                    break;
                }
            }
            onError: {
                playerLayer.visible = false;
                detail.state = "show";
            }
        }

        VideoOutput {
            z: 4;
            anchors.fill: parent;
            source: player;
        }

        Keys.onPressed: {
            switch(event.key){
            case Qt.Key_Back:
            case Qt.Key_Escape:
            case Qt.Key_Home:
                event.accepted = true;
                visible = false;
                player.stop();
                detail.state = "show";
                loading.running = false;
                break;
            case Qt.Key_Enter:
            case Qt.Key_Return:
                if(player.playbackState == MediaPlayer.PlayingState){
                    player.pause();
                }else{
                    player.play();
                }

                break;
            }
        }
    }
}
