import QtQuick 2.2

Rectangle {
    width: 320;
    height: 200;
    Text {
        id: normal;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        anchors.top: parent.top;
        anchors.topMargin: 20;
        font.pointSize: 24;
        text: "Normal Text";
    }
    Text {
        id: raised;
        anchors.left: normal.left;
        anchors.top: normal.bottom;
        anchors.topMargin: 4;
        font.pointSize: 24;
        text: "Raised Text";
        style: Text.Raised;
        styleColor: "#AAAAAA" ;
    }
    Text {
        id: outline;
        anchors.left: normal.left;
        anchors.top: raised.bottom;
        anchors.topMargin: 4;
        font.pointSize: 24;
        text: "Outline Text";
        style: Text.Outline;
        styleColor: "red";
    }
    Text {
        anchors.left: normal.left;
        anchors.top: outline.bottom;
        anchors.topMargin: 4;
        font.pointSize: 24;
        text: "Sunken Text";
        style: Text.Sunken;
        styleColor: "#A00000";
    }
}