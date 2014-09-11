import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle {
    width: 360;
    height: 240;
    color: "lightgray";
    
    Component {
        id: tabContent;
        Rectangle {
            implicitWidth: 100;
            implicitHeight: 100;
            anchors.fill: parent;
            color: Qt.rgba(Math.random(), Math.random(), Math.random());
        }
    }

    Button {
        id: addTab;
        x: 8;
        y: 8;
        width: 60;
        height: 25;
        text: "AddTab";
        onClicked: {
            tabView.addTab("tab-" + tabView.count, tabContent);
        }
    }
    
    TabView {
        id: tabView;
        anchors.top: addTab.bottom;
        anchors.margins: 8;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
    }    
}
