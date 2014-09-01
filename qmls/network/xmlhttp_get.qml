import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle {
    id: root;
    width: 480;
    height: 300;
    color: "black";
    property var xmlhttp: null;
    function onResultReady(){
        if(xmlhttp.readyState == 4){
            result.append("Status Code: %1\n\nResponse Headers:".arg(xmlhttp.status));
            result.append("  Content-Type: %1".arg(xmlhttp.getResponseHeader("Content-Type")));
            result.append("  Content-Length: %1".arg(xmlhttp.getResponseHeader("Content-Length")));
            result.append("  Content-Encoding: %1".arg(xmlhttp.getResponseHeader("Content-Encoding")));
            result.append("  Transfer-Encoding: %1".arg(xmlhttp.getResponseHeader("Transfer-Encoding")));
            result.append("  Server: %1\n".arg(xmlhttp.getResponseHeader("Server")));
            if(xmlhttp.responseXML != null){
                result.append("XML Contents:");
                var doc = xmlhttp.responseXML.documentElement;
                result.append("  root element name: %1".arg(doc.nodeName));
            }
            xmlhttp.abort();
        }
    }
    function get(url){
        if(xmlhttp == null){
            xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = onResultReady;
        }
        if(xmlhttp.readyState == 0){
            result.remove(0, result.length);
            xmlhttp.open("GET", url, true);
            xmlhttp.setRequestHeader("Accept-Encoding", "gzip,deflate,sdch");
            xmlhttp.setRequestHeader("User-Agent", "QML");
            xmlhttp.send(null);
        }
    }
    
    TextEdit {
        id: result;
        anchors.margins: 4;
        anchors.bottom: searchBox.top;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.right: parent.right;
        readOnly: true;
        color: "steelblue";
    }
    
    Text {
        id: searchClue;
        text: "URL:";
        font.pointSize: 11;
        verticalAlignment: Text.AlignVCenter;
        height: 30;
        anchors.left: parent.left;
        anchors.leftMargin: 4;
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
        anchors.left: searchClue.right;
        anchors.right: parent.right;
        anchors.margins: 4;
        height: 40;

        TextInput {
            id: searchEdit;
            anchors.margins: 2;
            anchors.fill: parent;
            font.pointSize: 13;
            verticalAlignment: TextInput.AlignVCenter;
            color: "white";
            activeFocusOnTab: true;
            onAccepted: root.get(text);
        }
    }
}
