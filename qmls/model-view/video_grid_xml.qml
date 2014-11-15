import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0

Rectangle {
    width: 480;
    height: 400;
    
    Component {
        id: videoModel;
        XmlListModel {
           source: "videos.xml";
           id: xmlModel;
           query:"/videos/video";
           XmlRole{ name: "name"; query: "@name/string()"; }
           XmlRole{ name: "img"; query: "poster/@img/string()"; }   
           XmlRole{ name: "rating"; query: "attr[3]/number()"; }                                               
        }
    }
    
    Component {
        id: videoDelegate;
        Item {
            id: wrapper;
            width: videoView.cellWidth;
            height: videoView.cellHeight;

            MouseArea {
                anchors.fill: parent;
                onClicked: wrapper.GridView.view.currentIndex = index;
            }                 

            Image {
                id: poster;
                anchors.horizontalCenter: parent.horizontalCenter;
                anchors.top: parent.top;
                anchors.topMargin: 3;
                source: img;
                width: 100;
                height: 150;
                fillMode: Image.PreserveAspectFit;
            }
            Text { 
                anchors.top: poster.bottom;
                anchors.topMargin: 4;
                width: parent.width;
                
                text: name; 
                color: wrapper.GridView.isCurrentItem ? "blue" : "black";
                font.pixelSize: 18;
                horizontalAlignment: Text.AlignHCenter;
                elide: Text.ElideMiddle;
            }
        }
    }
    
    GridView {
        id: videoView;
        anchors.fill: parent;
        cellWidth: 120;
        cellHeight: 190;
        //keyNavigationWraps: true;

        delegate: videoDelegate;
        model: videoModel.createObject(videoView);
        focus: true;
        highlight: Rectangle{
            height: videoView.cellHeight - 8;
            color: "lightblue";
        }
    }
}
