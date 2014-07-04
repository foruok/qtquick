import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    width: 360;
    height: 420;
    //color: "#324030";
    color: "#E0E0E0";
    id: root;
    focus: true;
    
    // 9 bubbles
    Row {
        id: bubbles;
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter;
        spacing: 2;
        property var diedCount: 0;
        
        Component.onCompleted: {
            var i = 0;
            var qmlStringBegin = "import QtQuick 2.0; Image{width: 30; height:30; property var died: false; source: \"res/bubble_";
            
            for(; i < 8; i++){
                var qmlString = qmlStringBegin + (i+1) + ".png\";}";
                bubbles.children[i] = Qt.createQmlObject(qmlString, bubbles, "DynamicImage");
            }
        }
        /*
        function allDie(){
            return diedCount == children.length;
        }
        
        function reset(){
            diedCount = 0;
            var i = 0;
            var bubble;
            for(; i < bubbles.children.length; i++){
                bubble = bubbles.children[i];
                bubble.died = false;
                bubble.source = "res/bubble_" + (i+1) + ".png";
                bubble.opacity = 1.0;
            }
        }
        
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_1.png";
            property var died: false;
        }
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_2.png";
            property var died: false;
        }
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_3.png";
            property var died: false;
        }
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_4.png";
            property var died: false;
        }
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_5.png";
            property var died: false;
        }     
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_6.png";
            property var died: false;
        }
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_7.png";
            property var died: false;
        }
        Image{
            width: 30;
            height: 30;
            source: "res/bubble_8.png";
            property var died: false;
        }          
        */                                             
    }
}
