import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.XmlListModel 2.0
import QtQuick.Layouts 1.1

Rectangle {
    width: 600;
    height: 400;
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
           XmlRole{ name: "rating_tag"; query: "attr[3]/@tag/string()"; }
           XmlRole{ name: "rating"; query: "attr[3]/number()"; }   
           XmlRole{ name: "desc_tag"; query: "attr[4]/@tag/string()"; }  
           XmlRole{ name: "desc"; query: "attr[4]/string()"; }  
           XmlRole{ name: "playtimes_tag"; query: "playtimes/@tag/string()"; }   
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

        path:Path {
            startX: 50; 
            startY: 0;
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemScale"; value: 0.3 }
            PathAttribute { name: "itemAlpha"; value: 0.4 }
            PathLine {
                x: root.width /2;
                y: root.height - 250;
            }         
            PathAttribute { name: "zOrder"; value: 100 }
            PathAttribute { name: "itemScale"; value: 1.0 }        
            PathAttribute { name: "itemAlpha"; value: 1.0 }        
            PathLine {
                x: root.width - 50;
                y: 0;
            }
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemScale"; value: 0.3 }
            PathAttribute { name: "itemAlpha"; value: 0.4 }
        }

        focus: true;
        Keys.onLeftPressed: decrementCurrentIndex();
        Keys.onRightPressed: incrementCurrentIndex();
        Keys.onReturnPressed: {
            console.log("onReturnPressed, ", currentIndex);
            detail.setDetail(model.get(currentIndex));
            detail.visible = true;
            detail.focus = true;
            visible = false;
        }
    }
    

    Rectangle {
        id: detail;
        visible: false;
        anchors.fill: parent;
        color: "black";
        Text {
            id: vName;
            x: 10;
            y: 10;
            height: 32;
            width: parent.width - 20;
            font.bold: true;
            font.pixelSize: 28;
            color: "white";
        }
        Image {
            id: vPoster;
            anchors.left: vName.left;
            anchors.top: vName.bottom;
            anchors.topMargin: 4;
            width: 160;
            height: 240;
            fillMode: Image.PreserveAspectFit;
        }
        
        ColumnLayout {
            anchors.left: vPoster.right;
            anchors.leftMargin: 4;
            anchors.right: vName.right;
            anchors.top: vPoster.top;
            height: vPoster.height;
            spacing: 2;
            Text { 
                id: date
                Layout.fillWidth: true;
                font.pixelSize: 18;
                elide: Text.ElideRight;
                color: "white";
            }              
            Text { 
                id: actor;
                Layout.fillWidth: true;
                font.pixelSize: 18;
                elide: Text.ElideRight;
                color: "white";
            }
            Text { 
                id: director;
                Layout.fillWidth: true;
                font.pixelSize: 18;
                elide: Text.ElideRight;
                color: "white";
            }   
            Text { 
                id: rating;
                Layout.fillWidth: true;
                font.pixelSize: 18;
                elide: Text.ElideRight;
                color: "white";
            }                                 
            Text { 
                id: playtimes;
                Layout.fillWidth: true;
                Layout.fillHeight: true;
                font.pixelSize: 18;
                elide: Text.ElideRight;
                color: "white";
            }                       
        }        
        
        ColumnLayout {
            anchors.left: vPoster.left;
            anchors.right: vName.right;
            anchors.top: vPoster.bottom;
            anchors.topMargin: 10;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 4;
            spacing: 2;
            Text { 
                id: descTitle;
                Layout.fillWidth: true;
                font.pixelSize: 18;
                font.bold: true;
                color: "white";
            }
            Text { 
                id: description;
                Layout.fillHeight: true;
                Layout.fillWidth: true;
                font.pixelSize: 16;
                wrapMode: Text.Wrap;
                maximumLineCount: 3;
                elide: Text.ElideRight;
                color: "white";
            }           
        }
        
        function setDetail(obj) {
            vName.text = obj.name;
            vPoster.source = obj.img;
            date.text = obj.date;
            actor.text = obj.actor_tag + ": " + obj.actor;
            director.text = obj.director_tag + ": " + obj.director;
            descTitle.text = obj.desc_tag + ":";
            description.text = obj.desc;
            rating.text = obj.rating_tag + ": " + obj.rating;
            playtimes.text = obj.playtimes_tag + ":" + obj.playtimes;
        }
        Keys.onPressed: {
            switch(event.key){
            case Qt.Key_Back:
            case Qt.Key_Escape:
            case Qt.Key_Home:
                event.accepted = true;
                visible = false;
                videoView.visible = true;
                videoView.focus = true;
                break;
            }
        }
    }    
}
