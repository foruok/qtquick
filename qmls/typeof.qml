import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    
    property var btn: Button {
        text: "Quit";
        anchors.centerIn: parent;
        onClicked: {
            Qt.quit();
        }
    }
    
    Component.onCompleted: {
        console.log(typeof btn);
        //console.log( btn.constructor );
        console.log(getType(btn)); //.prototype.toString.call(object).match(/^\[object\s(.*)\]$/)[1]);
        
    }
}
