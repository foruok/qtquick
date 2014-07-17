import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 320;
    height: 240;
    color: "gray";
    ExclusiveGroup {
        id: language;    
    }

    Column {
        anchors.centerIn: parent;
        CheckBox {
            text: "C++";
            exclusiveGroup: language;
        }
        CheckBox {
            text: "Java";
            exclusiveGroup: language;
        }        
        CheckBox {
            text: "Go";
            exclusiveGroup: language;
        } 
    }       
}
