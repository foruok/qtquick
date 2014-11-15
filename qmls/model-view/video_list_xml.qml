import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0

Rectangle {
    width: 360;
    height: 400;
    color: "#EEEEEE";
    
    Component {
        id: videoModel;
        XmlListModel {
           source: "videos.xml";
           id: xmlModel;
           query:"/videos/video";
           XmlRole{ name: "name"; query: "@name/string()"; }
           XmlRole{ name: "date"; query: "@date/string()"; }   
           XmlRole{ name: "img"; query: "poster/@img/string()"; }   
           XmlRole{ name: "director_tag"; query: "attr[1]/@tag/string()"; } 
           XmlRole{ name: "director"; query: "attr[1]/string()"; }  
           XmlRole{ name: "actor_tag"; query: "attr[2]/@tag/string()"; }     
           XmlRole{ name: "actor"; query: "attr[2]/string()"; }    
           XmlRole{ name: "rating"; query: "attr[3]/number()"; }     
           XmlRole{ name: "desc"; query: "attr[4]/string()"; }  
           XmlRole{ name: "playtimes"; query: "playtimes/number()"; }                                             
        }
    }
    
    Component {
        id: videoDelegate;
        Item {
            id: wrapper;
            width: parent.width;
            height: 120;

            MouseArea {
                anchors.fill: parent;
                onClicked: wrapper.ListView.view.currentIndex = index;
            }                 

            Image {
                id: poster;
                anchors.left: parent.left;
                anchors.top: parent.top;
                source: img;
                width: 80;
                height: 120;
                fillMode: Image.PreserveAspectFit;
            }
            ColumnLayout {
                anchors.left: poster.right;
                anchors.leftMargin: 4;
                anchors.right: wrapper.right;
                anchors.top: poster.top;
                height:parent.height;
                spacing: 2;
                Text { 
                    Layout.fillWidth: true;
                    text: "<b>" + name + "</b>(" + rating + "," + playtimes + ")"; 
                    color: wrapper.ListView.isCurrentItem ? "blue" : "black";
                    font.pixelSize: 18;
                    elide: Text.ElideRight;
                }
                Text { 
                    text: date; 
                    Layout.fillWidth: true;
                    color: wrapper.ListView.isCurrentItem ? "blue" : "black";
                    font.pixelSize: 18;
                    elide: Text.ElideRight;
                }   
                Text { 
                    text: director_tag + ": <font color=\"#0000aa\">" + director + "</font>"; 
                    Layout.fillWidth: true;
                    color: wrapper.ListView.isCurrentItem ? "blue" : "black";
                    font.pixelSize: 18;
                    elide: Text.ElideRight;
                }  
                Text { 
                    text: actor_tag + ": <font color=\"#0000aa\">" + actor + "</font>"; 
                    Layout.fillWidth: true;
                    color: wrapper.ListView.isCurrentItem ? "blue" : "black";
                    font.pixelSize: 18;
                    elide: Text.ElideRight;
                }                                  
                Text { 
                    text: desc; 
                    Layout.fillHeight: true;
                    Layout.fillWidth: true;
                    color: wrapper.ListView.isCurrentItem ? "blue" : "black";
                    font.pixelSize: 16;
                    wrapMode: Text.Wrap;
                    maximumLineCount: 2;
                    elide: Text.ElideRight;
                }                               
            }
        }
    }
    
    ListView {
        id: listView;
        anchors.fill: parent;
        spacing: 4;

        delegate: videoDelegate;
        model: videoModel.createObject(listView);
        focus: true;
        highlight: Rectangle{
            width: parent.width;
            color: "lightblue";
        }
    }
}
