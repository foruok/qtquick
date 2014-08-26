import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1

Window {
    id: root;
    visible: true;
    width: 800;
    height: 480;
    minimumWidth: 800;
    minimumHeight: 480;
    objectName: "qmlWin";
    color: "black";
    title: qsTr("ImageViewer");

    property var localComp;
    property var localView;
    property var netComp;
    property var netView;

    function backKeyProcess(){
        if(root.localView != undefined){
            root.localView.destroy();
            root.localView = undefined;
        }else if(root.netView != undefined){
            root.netView.destroy();
            root.netView = undefined;
        }else{
            Qt.quit();
        }
    }

    Column {
        id: actionPanel;
        anchors.centerIn: parent;
        spacing: 4;

        FlatButton {
            id: find;
            iconSource: "icons/ic_find.png";
            text: qsTr("Search Internet");
            font.pointSize: 14;
            onClicked: {
                if(root.netComp == undefined){
                    root.netComp = Qt.createComponent("ImageDigger.qml", Component.PreferSynchronous);
                }
                if(root.netView == undefined){
                    root.netView = root.netComp.createObject(root, {"focus": true});
                    root.netView.back.connect(root.onNetViewBack);
                }
            }
        }
        FlatButton {
            id: local;
            iconSource: "icons/ic_archive.png";
            text: qsTr("Local Image");
            font.pointSize: 14;
            onClicked: {
                if(root.localComp == undefined){
                    root.localComp = Qt.createComponent("LocalViewer.qml", Component.PreferSynchronous);
                }
                if(root.localView == undefined){
                    root.localView = root.localComp.createObject(root, {"focus": true});
                    root.localView.initInteractive();
                    root.localView.back.connect(root.onLocalViewBack);
                }
            }
        }
    }

    function onLocalViewBack(){
        localView.destroy();
        localView = undefined;
    }

    function onNetViewBack(){
        netView.destroy();
        netView = undefined;
    }
}
