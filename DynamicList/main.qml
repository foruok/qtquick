import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2

Window {
    width: 320;
    height: 480;
    minimumWidth: 300;
    minimumHeight: 480;
    visible: true;
    id: root;

    Component {
        id: listDelegate;
        Text {
            id: wrapper;
            width: parent.width;
            height: 32;
            font.pointSize: 15;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
            text: content;
            color: ListView.view.currentIndex == index ? "red" : "blue";
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(wrapper.ListView.view.currentIndex != index){
                        wrapper.ListView.view.currentIndex = index;
                    }
                }
            }
        }
    }

    ListView {
        id: dynamicList;
        z: 1;
        anchors.fill: parent;
        anchors.margins: 10;

        delegate: listDelegate;
        model: dynamicModel;

        focus: true;
        activeFocusOnTab: true;
        highlight: Rectangle {
            color: "steelblue";
        }

        property real contentYOnFlickStarted: 0;
        onFlickStarted: {
            //console.log("start,origY - ", originY, " contentY - ", contentY);
            contentYOnFlickStarted = contentY;
        }

        onFlickEnded: {
            console.log("end,origY - ", originY, " contentY - ", contentY);
            dynamicModel.loadMore(contentY < contentYOnFlickStarted);
        }

        onMovementEnded: console.log("movement ended");
    }
}
