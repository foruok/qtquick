import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.XmlListModel 2.0

Rectangle {
    width: 480;
    height: 360;
    color: "black";
    id: root;
    
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
            width: 100;
            z: PathView.zOrder;
            scale: PathView.isCurrentItem ? 1.2 : PathView.itemScale;
            opacity: PathView.itemAlpha;
            
            MouseArea {
                anchors.fill: parent;
                onClicked: wrapper.PathView.currentIndex = index;
            }          
            
            Image {
                anchors.top: parent.top;
                anchors.topMargin: 10;
                anchors.horizontalCenter: parent.horizontalCenter;
                id: poster;
                source: img;
                width: 100;
                height: 150;
                fillMode: Image.PreserveAspectFit;
            }   
            /*
            Canvas {
                visible: wrapper.PathView.isCurrentItem;
                width: 112;
                height: 162;
                anchors.horizontalCenter: poster.horizontalCenter;
                anchors.verticalCenter: poster.verticalCenter;
                z: poster.z - 0.1;
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.lineWidth = 6;
                    ctx.strokeStyle = "red";
                    ctx.beginPath();
                    ctx.moveTo(3, 3);
                    ctx.lineTo(109, 3);
                    ctx.lineTo(109, 158);
                    ctx.lineTo(3, 158);
                    ctx.lineTo(3, 3);
                    ctx.stroke();
                }
            } 
            */
                  
            Text { 
                id: videoName;
                anchors.top: poster.bottom;
                anchors.topMargin: 8;
                anchors.horizontalCenter: poster.horizontalCenter;
                visible: wrapper.PathView.isCurrentItem;
                text: name;
                color: wrapper.PathView.isCurrentItem ? "blue" : "black";
                font.pixelSize: 20;
            }
            Text { 
                anchors.top: videoName.bottom;
                anchors.horizontalCenter: videoName.horizontalCenter;                
                visible: wrapper.PathView.isCurrentItem;
                text: date; 
                color: wrapper.PathView.isCurrentItem ? "blue" : "black";
                font.pixelSize: 16;
                elide: Text.ElideRight;
            }                             
        }
    }
    
    PathView {
        id: videoView;
        anchors.fill: parent;
        pathItemCount: 9;
        // keep highlight sit on the middle of Path
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        highlightRangeMode: PathView.StrictlyEnforceRange;

        delegate: videoDelegate;
        model: videoModel.createObject(videoView);

        property var yBase: root.width - 
        path:Path {
            startX: 50; 
            startY: root.height / 2;
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemScale"; value: 0.2 }
            PathAttribute { name: "itemAlpha"; value: 0.2 }
            PathLine {
                x: root.width / 2;
                y: root.height / 2;
            }         
            PathAttribute { name: "zOrder"; value: 100 }
            PathAttribute { name: "itemScale"; value: 1.0 }        
            PathAttribute { name: "itemAlpha"; value: 1.0 }        
            PathLine {
                x: root.width - 50;
                y: root.height / 2;
            }
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemScale"; value: 0.2 }
            PathAttribute { name: "itemAlpha"; value: 0.2 }
        }
        
        
        highlight: Canvas {
            //visible: false;
            width: 112;
            height: 162;
            onPaint: {
                //console.log("x=", x, " y=", y, " w=", width, " h=", height);
                var ctx = getContext("2d");
                ctx.lineWidth = 6;
                ctx.strokeStyle = "white";
                ctx.beginPath();
                ctx.moveTo(3, 3);
                ctx.lineTo(109, 3);
                ctx.lineTo(109, 158);
                ctx.lineTo(3, 158);
                ctx.lineTo(3, 3);
                ctx.stroke();
            }
            z: 200;
        }
        
        
        focus: true;
        Keys.onLeftPressed: if(videoView.currentIndex > 0) videoView.currentIndex -= 1;
        Keys.onRightPressed: if(videoView.currentIndex < videoView.count - 1) videoView.currentIndex += 1;
    }
}
