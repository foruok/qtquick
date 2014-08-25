import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1

Rectangle {
    width: 480;
    height: 320;
    color: "black";
    
    onWidthChanged: mask.recalc();       
    onHeightChanged: mask.recalc();
    
    Image {
        id: source;
        anchors.fill: parent;
        //source: "comic_role.png";
        fillMode: Image.PreserveAspectFit;
        visible: false;
        asynchronous: true;
        onStatusChanged: {
            if(status === Image.Ready){
                mask.recalc();
            }
        }
    }
    
    FileDialog {
        id: fileDialog;
        title: "Please choose an Image File";
        nameFilters: ["Image Files (*.jpg *.png *.gif)"];
        onAccepted: {
            source.source = fileDialog.fileUrl;
        }
    }
    
    
    Canvas {
        id: forSaveCanvas;
        width: 128;
        height: 128;
        contextType: "2d";
        visible: false;
        z: 2;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 4;
        
        property var imageData: null;
        onPaint: {
            if(imageData != null){
                context.drawImage(imageData, 0, 0);
            }
        }
        
        function setImageData(data){
            imageData = data;
            requestPaint();
        }
    }
    
    Canvas {
        id: mask;
        anchors.fill: parent;
        z: 1;
        property var w: width;
        property var h: height;
        property var dx: 0;
        property var dy: 0;
        property var dw: 0;
        property var dh: 0;
        property var frameX: 66;
        property var frameY: 66;
        
        function calc(){
            var sw = source.sourceSize.width;
            var sh = source.sourceSize.height;
            if(sw > 0 && sh > 0){
                if(sw <= w && sh <=h){
                    dw = sw;
                    dh = sh;
                }else{
                    var sRatio = sw / sh;
                    dw = sRatio * h;
                    if(dw > w){
                        dh = w / sRation;
                        dw = w;
                    }else{
                        dh = h;
                    }
                }
                dx = (w - dw)/2;
                dy = (h - dh)/2;
            }
        }
        
        function recalc(){
            calc();
            requestPaint();        
        }
        
        function getImageData(){
            return context.getImageData(frameX - 64, frameY - 64, 128, 128);
        }
        
        onPaint: {
            var ctx = getContext("2d");
            if(dw == 0 || dh == 0) {
                ctx.fillStyle = "#0000a0";
                ctx.font = "20pt sans-serif";
                ctx.textAlign = "center";
                ctx.fillText("Please Choose An Image File", width/2, height/2);
                return;
            }            
            ctx.clearRect(0, 0, width, height);
            ctx.drawImage(source, dx, dy, dw, dh);
            var xStart = frameX - 66;
            var yStart = frameY - 66;
            ctx.save();
            ctx.fillStyle = "#a0000000";
            ctx.fillRect(0, 0, w, yStart);
            var yOffset = yStart + 132;
            ctx.fillRect(0, yOffset, w, h - yOffset);
            ctx.fillRect(0, yStart, xStart, 132);
            var xOffset = xStart + 132;
            ctx.fillRect(xOffset, yStart, w - xOffset, 132);
            
            //see through area
            ctx.strokeStyle = "red";
            ctx.fillStyle = "#00000000";
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.rect(xStart, yStart, 132, 132);
            ctx.fill();
            ctx.stroke();
            ctx.closePath();
            ctx.restore();
        }
    }
    
    MultiPointTouchArea {
        anchors.fill: parent;
        minimumTouchPoints: 1;
        maximumTouchPoints: 1;
        touchPoints:[
            TouchPoint{
                id: point1;
            }
        ]
        
        onUpdated: {
            mask.frameX = point1.x;
            mask.frameY = point1.y;
            mask.requestPaint();
        }
        onReleased: {
            forSaveCanvas.setImageData(mask.getImageData());
            actionPanel.visible = true;
        }
        onPressed: {
            actionPanel.visible = false;
        }
    }
    
    Component {
        id: flatButton;
        ButtonStyle {
            background: Rectangle{
                implicitWidth: 70;
                implicitHeight: 30;            
                border.width: control.hovered ? 2: 1;
                border.color: control.hovered ? "#c0c0c0" : "#909090";
                color: control.pressed ? "#a0a0a0" : "#707070";
            }
            label: Text {
                anchors.fill: parent;
                font.pointSize: 12;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                text: control.text;
                color: (control.hovered && !control.pressed) ? "blue": "white";
            }
        }
    }
    
    Row {
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 20;
        id: actionPanel;
        z: 5;
        //visible: false;
        spacing: 8;
        Button {
            style: flatButton;
            text: "Open";
            onClicked: fileDialog.open();
        }        
        Button {
            style: flatButton;
            text: "Save";
            onClicked: {
                forSaveCanvas.save("selected.png");
                actionPanel.visible = false;
            }
        }
        Button {
            style: flatButton;
            text: "Cancel";
            onClicked: actionPanel.visible = false;
        }
    }
}
