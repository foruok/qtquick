import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import QtMultimedia 5.0

ApplicationWindow {
    visible: true
    width: 480
    height: 360;
    color: "black";
    title: "文件查看器";
    id: root;
    property var aboutDlg: null;
    property var colorDlg: null;
    property color textColor: "green";
    property color textBackgroundColor: "black";

    menuBar: MenuBar{
        Menu {
            title: "文件";
            MenuItem{
                iconSource: "res/txtFile.png";
                action: Action{
                    id: textAction;
                    iconSource: "res/txtFile.png";
                    text: "文本文件";
                    onTriggered: {
                        fileDialog.selectedNameFilter = fileDialog.nameFilters[0];
                        fileDialog.open();
                    }
                    tooltip: "打开txt等文本文件";
                }
            }
            MenuItem{
                action: Action {
                    id: imageAction;
                    text: "图片";
                    iconSource: "res/imageFile.png";
                    onTriggered: {
                        fileDialog.selectedNameFilter = fileDialog.nameFilters[1];
                        fileDialog.open();
                    }
                    tooltip: "打开jpg等格式的图片";
                }
            }
            MenuItem{
                action: Action {
                    id: videoAction;
                    iconSource: "res/videoFile.png";
                    text: "视频";
                    onTriggered: {
                        fileDialog.selectedNameFilter = fileDialog.nameFilters[2];
                        fileDialog.open();
                    }
                    tooltip: "打开TS、MKV、MP4等格式的文件";
                }
            }
            MenuItem{
                action: Action {
                    id: audioAction;
                    iconSource: "res/audioFile.png";
                    text: "音乐";
                    onTriggered: {
                        fileDialog.selectedNameFilter = fileDialog.nameFilters[3];
                        fileDialog.open();
                    }
                    tooltip: "打开mp3、wma等格式的文件";
                }
            }
            MenuItem{
                text: "退出";
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: "设置";
            MenuItem {
                action: Action {
                    id: textColorAction;
                    iconSource: "res/ic_textcolor.png";
                    text: "文字颜色";
                    onTriggered: root.selectColor(root.onTextColorSelected);
                }
            }
            MenuItem {
                action: Action{
                    id: backgroundColorAction;
                    iconSource: "res/ic_bkgndcolor.png";
                    text: "文字背景色";
                    onTriggered: root.selectColor(root.onTextBackgroundColorSelected);
                }
            }
            MenuItem {
                action: Action{
                    id: fontSizeAddAction;
                    iconSource: "res/ic_fontsize2.png";
                    text: "增大字体";
                    onTriggered: textView.font.pointSize += 1;
                }
            }
            MenuItem {
                action: Action{
                    id: fontSizeMinusAction;
                    iconSource: "res/ic_fontsize1.png";
                    text: "减小字体";
                    onTriggered: textView.font.pointSize -= 1;
                }
            }
        }
        Menu {
            title: "帮助";
            MenuItem{
                text: "关于";
                onTriggered: root.showAbout();
            }
            MenuItem{
                text: "访问作者博客";
                onTriggered: Qt.openUrlExternally("http://blog.csdn.net/foruok");
            }
        }
    }

    toolBar: ToolBar{
        RowLayout {
            ToolButton{
                action: textAction;
            }
            ToolButton{
                action: imageAction;
            }
            ToolButton{
                action: videoAction;
            }
            ToolButton{
                action: audioAction;
            }
            ToolButton{
                action: textColorAction;
            }
            ToolButton {
                action: backgroundColorAction;
            }
            ToolButton {
                action: fontSizeAddAction;
            }
            ToolButton {
                action: fontSizeMinusAction;
            }
        }
    }

    statusBar: Rectangle {
        color: "lightgray";
        implicitHeight: 30;
        width: parent.width;
        property alias text: status.text;
        Text {
            id: status;
            anchors.fill: parent;
            anchors.margins: 4;
            font.pointSize: 12;
        }
    }

    Item {
        id: centralView;
        anchors.fill: parent;
        visible: true;
        property var current: null;
        BusyIndicator {
            id: busy;
            anchors.centerIn: parent;
            running: false;
            z: 3;
        }
        Image {
            id: imageViewer;
            anchors.fill: parent;
            visible: false;
            asynchronous: true;
            fillMode: Image.PreserveAspectFit;
            onStatusChanged: {
                if (status === Image.Loading) {
                    centralView.busy.running = true;
                }
                else if(status === Image.Ready){
                    centralView.busy.running = false;
                }
                else if(status === Image.Error){
                    centralView.busy.running = false;
                    centralView.statusBar.text = "图片无法显示";
                }
            }
        }

        TextArea {
            id: textView;
            anchors.fill: parent;
            readOnly: true;
            visible: false;
            wrapMode: TextEdit.WordWrap;
            font.pointSize: 12;
            style: TextAreaStyle{
                backgroundColor: root.textBackgroundColor;
                textColor: root.textColor;
                selectionColor: "steelblue";
                selectedTextColor: "#a00000";
            }

            property var xmlhttp: null;
            function onReadyStateChanged(){
                if(xmlhttp.readyState == 4){
                    text = xmlhttp.responseText;
                    xmlhttp.abort();
                }
            }

            function loadText(fileUrl){
                if(xmlhttp == null){
                    xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = onReadyStateChanged;
                }
                if(xmlhttp.readyState == 0){
                    xmlhttp.open("GET", fileUrl);
                    xmlhttp.send(null);
                }
            }
        }

        VideoOutput {
            id: videoOutput;
            anchors.fill: parent;
            visible: false;
            source: player;
            onVisibleChanged: {
                playerState.visible = visible;
                if(visible == false){
                    player.stop();
                }
            }
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    switch(player.playbackState){
                    case MediaPlayer.PausedState:
                    case MediaPlayer.StoppedState:
                        player.play();
                        break;
                    case MediaPlayer.PlayingState:
                        player.pause();
                        break;
                    }
                }
            }
        }

        Rectangle {
            id: playerState;
            color: "gray";
            radius: 16;
            opacity: 0.8;
            visible: false;
            z: 2;
            implicitHeight: 80;
            implicitWidth: 200;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 16;
            Column {
                anchors.fill: parent;
                anchors.leftMargin: 12;
                anchors.rightMargin: 12;
                anchors.topMargin: 6;
                anchors.bottomMargin: 6;
                spacing: 4;
                Text {
                    id: state;
                    font.pointSize: 14;
                    color: "blue";
                }
                Text {
                    id: progress;
                    font.pointSize: 12;
                    color: "white";
                }
            }
        }

        MediaPlayer {
            id: player;

            property var utilDate: new Date();
            function msecs2String(msecs){
                utilDate.setTime(msecs);
                return Qt.formatTime(utilDate, "mm:ss");
            }
            property var sDuration;

            onPositionChanged: {
                progress.text = msecs2String(position) + sDuration;
            }
            onDurationChanged: {
                sDuration = " / " + msecs2String(duration);
            }
            onPlaybackStateChanged: {
                switch(playbackState){
                case MediaPlayer.PlayingState:
                    state.text = "播放中";
                    break;
                case MediaPlayer.PausedState:
                    state.text = "已暂停";
                    break;
                case MediaPlayer.StoppedState:
                    state.text = "停止";
                    break;
                }
            }
            onStatusChanged: {
                switch(status){
                case MediaPlayer.Loading:
                case MediaPlayer.Buffering:
                    busy.running = true;
                    break;
                case MediaPlayer.InvalidMedia:
                    root.statusBar.text = "无法播放";
                case MediaPlayer.Buffered:
                case MediaPlayer.Loaded:
                    busy.running = false;
                    break;
                }
            }
        }
    }


    function processFile(fileUrl, ext){
        var i = 0;
        for(; i < fileDialog.nameFilters.length; i++){
            if(fileDialog.nameFilters[i].search(ext) != -1) break;
        }
        switch(i){
        case 0:
            //text file
            if(centralView.current != textView){
                if(centralView.current != null){
                    centralView.current.visible = false;
                }
                textView.visible = true;
                centralView.current = textView;
            }
            textView.loadText(fileUrl);
            break;
        case 1:
            if(centralView.current != imageViewer){
                if(centralView.current != null){
                    centralView.current.visible = false;
                }
                imageViewer.visible = true;
                centralView.current = imageViewer;
            }
            imageViewer.source = fileUrl;
            break;
        case 2:
        case 3:
            if(centralView.current != videoOutput){
                if(centralView.current != null){
                    centralView.current.visible = false;
                }
                videoOutput.visible = true;
                centralView.current = videoOutput;
            }
            player.source = fileUrl;
            player.play();
            break;
        default:
            statusBar.text = "抱歉，处理不了";
            break;
        }
    }

    function showAbout(){
        if(aboutDlg == null){
            aboutDlg = Qt.createQmlObject(
                        'import QtQuick 2.2;import QtQuick.Dialogs 1.1;MessageDialog{icon: StandardIcon.Information;title: "关于";\ntext: "仅仅是个示例撒";\nstandardButtons:StandardButton.Ok;}'
                        , root, "aboutDlg");
            aboutDlg.accepted.connect(onAboutDlgClosed);
            aboutDlg.rejected.connect(onAboutDlgClosed);
            aboutDlg.visible = true;
        }

    }

    function selectColor(func){
        if(colorDlg == null){
            colorDlg = Qt.createQmlObject(
                        'import QtQuick 2.2;import QtQuick.Dialogs 1.1;ColorDialog{}',
                        root, "colorDlg");
            colorDlg.accepted.connect(func);
            colorDlg.accepted.connect(onColorDlgClosed);
            colorDlg.rejected.connect(onColorDlgClosed);
            colorDlg.visible = true;
        }
    }

    function onAboutDlgClosed(){
        aboutDlg.destroy();
        aboutDlg = null;
    }

    function onColorDlgClosed(){
        colorDlg.destroy();
        colorDlg = null;
    }

    function onTextColorSelected(){
        root.textColor = colorDlg.color;
    }

    function onTextBackgroundColorSelected(){
        root.textBackgroundColor = colorDlg.color;
    }

    FileDialog {
        id: fileDialog;
        title: qsTr("Please choose an image file");
        nameFilters: [
            "Text Files (*.txt *.ini *.log *.c *.h *.java *.cpp *.html *.xml)",
            "Image Files (*.jpg *.png *.gif *.bmp *.ico)",
            "Video Files (*.ts *.mp4 *.avi *.flv *.mkv *.3gp)",
            "Audio Files (*.mp3 *.ogg *.wav *.wma *.ape *.ra)",
            "*.*"
        ];
        onAccepted: {
            var filepath = new String(fileUrl);
            //remove file:///
            if(Qt.platform.os == "windows"){
                root.statusBar.text = filepath.slice(8);
            }else{
                root.statusBar.text = filepath.slice(7);
            }
            var dot = filepath.lastIndexOf(".");
            var sep = filepath.lastIndexOf("/");
            if(dot > sep){
                var ext = filepath.substring(dot);
                root.processFile(fileUrl, ext.toLowerCase());
            }else{
                root.statusBar.text = "Not Supported!";
            }
        }
    }
}
