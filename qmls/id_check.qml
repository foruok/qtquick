import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    id: rootItem;
    
    Text {
        anchors.centerIn: parent;
        text: "Hello World!";
        color: "blue";
        font.pixelSize: 32;
    }
    
    Component.onCompleted:{
        console.log("id value = ", rootItem);
        //console.log("typeof(id)=", typeof(rootItem));
    }
}
