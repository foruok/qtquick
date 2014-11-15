import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle {
    width: 360;
    height: 420;
    color: "#E0E0E0";
    id: root;
    focus: true;
    
    Row {
        id: bubbles;
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter;
        spacing: 2;
        property var diedCount: 0;
        
        Component.onCompleted: {
            var i = 0;
            var qmlStringBegin = "import QtQuick 2.2; Image{width: 30; height:30; property var died: false; source: \"res/bubble_";
            
            for(; i < 8; i++){
                var qmlString = qmlStringBegin + (i+1) + ".png\";}";
                bubbles.children[i] = Qt.createQmlObject(qmlString, bubbles, "DynamicImage");
            }
        }        
        
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
    }
    
    Text {
        id: scoreInfo;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: bubbles.bottom;
        anchors.topMargin: 4;
        font.pixelSize: 26;
        font.bold: true;
        color: "blue";
    }
    
    Image {
        id: turret;
        width: 50;
        height: 80;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        source: "res/turret.png";
        transformOrigin: Item.Bottom;
    }
    
    Image {
        id: bullet;
        width: 40;
        height: 40;
        source: "res/knife.png";
        z: 2;
        visible: false;
    }

    NumberAnimation {
        property var rotateAngle: 0;
        
        function rotate(angle){
            rotateAngle += angle;
            if(running == false){
                rotateTurret();
            } 
        }
        
        function rotateTurret(){
            if(rotateAngle != 0){
                from = turret.rotation;
                to = turret.rotation + rotateAngle;
                if(to > 80 ) to = 80;
                else if(to < -80) to = -80;
                var distance = to - from;
                duration = Math.min( 100 * Math.abs(distance / 3), 800);
                start();
                rotateAngle = 0;
            }
        }
        
        id: animateTurret;
        target: turret;
        property: "rotation";
        onStopped: {
            rotateTurret();
        }
    }
    
    NumberAnimation {
        id: aboutDie;
        property: "opacity";
        duration: 400;
        from: 1.0;
        to: 0;
        onStopped:{
            showDie.start();
        }
    }
    
    NumberAnimation {
        id: showDie;
        property: "opacity";
        duration: 400;
        from: 0;
        to: 0.6;
        property var diedImage;
        onStarted: {
            target.source = diedImage;
        }
        onStopped:{
            root.resetBullet();
            bubbles.diedCount++;
            if(bubbles.allDie() == true){
                passed.showPass(true);
                deadline.stop();
                root.showScore();
            }
        }            
    }
    
    ParallelAnimation {
        id: animateBullet;
        property var fire: 0; // 0 - init; 1 - shotting; 2 - resetting
        property var diedBubble: -1;
        
        function caculateDiedBubble(){
            var crossX = turret.rotation == 0 ? (root.width/2 - bullet.width/2) : (root.width/2 - bullet.width/2) + (15 - (root.height - bullet.height/2))/Math.tan((90 + turret.rotation)*0.017453293);
            var i = 0;
            var bubble;
            for(diedBubble = -1; i < bubbles.children.length; i++){
                bubble = bubbles.children[i];
                if(crossX > bubbles.x + bubble.x && crossX < bubbles.x + bubble.x + bubble.width){
                    if(bubble.died == false) diedBubble = i;
                    break;
                }
            }
        }
        
        NumberAnimation {
            id: animateBulletX;
            target: bullet;
            property: "x";
            duration: 1200;
            easing.type: Easing.OutCubic;
            
        }
        NumberAnimation {
            id: animateBulletY;
            target: bullet;
            property: "y";
            duration: 1200;
            easing.type: Easing.OutCubic;
        }
        onStopped: {
            if(fire == 1){
                if(diedBubble >=0 ){
                    var bubble = bubbles.children[diedBubble];
                    bubble.died = true;
                    showDie.diedImage = "res/frozen_" + (diedBubble+1) + ".png";
                    aboutDie.target = bubble;
                    showDie.target = bubble;
                    aboutDie.start();
                }else{
                    root.resetBullet();
                }
            }else{
                fire = 0;
                bullet.visible = false;
                if( root.requestReset == true ){
                    root.requestReset = false;
                    playGame.enabled = true;
                }
            }
        }
    }
    
    /*
    * y - y1 = tan(90+rotation)*(x - x1)
    */
    function fire(){
        if(playGame.enabled || animateBullet.fire != 0) return;
        bullet.visible = true;
        animateBullet.caculateDiedBubble();
        animateBulletX.duration = 1200;
        animateBulletX.from = bullet.x;
        if(turret.rotation == 0) animateBulletX.to = bullet.x;
        else animateBulletX.to = (root.width/2 - bullet.width/2) - (root.height - bullet.height/2)/Math.tan((90 + turret.rotation)*0.017453293);
        animateBulletY.duration = 1200;
        animateBulletY.from = bullet.y;
        animateBulletY.to = 5;
        animateBullet.start();
        animateBullet.fire = 1;
    }
    
    function resetBullet(){
        if(animateBullet.fire == 1){
            animateBullet.fire = 2;
            animateBulletX.from = bullet.x;
            animateBulletX.to = root.width/2 - bullet.width/2;
            animateBulletX.duration = 500;
            animateBulletY.from = bullet.y;
            animateBulletY.to = root.height - bullet.height/2;
            animateBulletY.duration = 500;
            animateBullet.start();
        }
    }
    
    Text {
        id: leftSeconds;
        anchors.centerIn: parent;
        color: "red";
        font.pixelSize: 20;
    }
    
    Timer {
        id: deadline;
        interval: 1000;
        repeat: true;
        onTriggered: {
            var curDate = new Date();
            var milliSeconds = maxGameTime - (curDate.getTime() - startDate.getTime());
            if(milliSeconds <= 0){
                failed.showFailed(true);
                deadline.stop();
            }else{
                var seconds = Math.round(milliSeconds / 1000);
                if(seconds == 0) seconds = 1;
                leftSeconds.text = "Left Time: " + seconds;
            }
        }
    }
    
    function showScore(){
        var curDate = new Date();
        var seconds = Math.round((curDate.getTime() - startDate.getTime())/1000);
        if(seconds <= 27){
            scoreInfo.text = +seconds + "S! Excellent!";
        }else if(seconds <= 32){
            scoreInfo.text = +seconds + "S! Good!";
        }else if(seconds <= 42){
            scoreInfo.text = + seconds + "S! Yep, pass.";
        }else{
            scoreInfo.text = + seconds + "S! Try again.";
        }
    }
    
    property var startDate;
    property var requestReset: false;
    readonly property var maxGameTime: 70000;
    
    Button {
        id: resetGame;
        text: "Reset";
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;        
        onClicked: {
            root.requestReset = true;
            bubbles.reset();
            deadline.stop();
            turret.rotation = 0;
            if( animateBullet.fire == 1 ){
                root.resetBullet();
            }else if( animateBullet.fire == 0 ){
                playGame.enabled = true;
                root.requestReset = false;
            }
            failed.showFailed(false);
            passed.showPass(false);
            leftSeconds.text = "";
            scoreInfo.text = "";
        }
    }
    
    Button {
        id: playGame;
        text: "Play";
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom: resetGame.top;
        anchors.bottomMargin: 4;
        
        onClicked: {
            root.startDate = new Date();
            deadline.restart();
            playGame.enabled = false;
            root.requestReset = false;
            root.resetBulletPos();
        }
    }
    
    Image {
        id: passed;
        visible: false;
        width: 200;
        height: 51;
        x: root.width / 2 - 100;
        source: "res/passed.png";    
        z: 3;
        
        SpringAnimation {
            id: springY;
            target: passed;
            property: "y";
            spring: 3;
            damping: 0.1;
            epsilon: 0.25;
        }                          
        
        function showPass(bShow){
            visible = bShow;
            if(bShow == true){
                springY.from = y;
                springY.to = root.height / 2 - height / 2;
                springY.start();
            }else{
                y = 0;
            }
        }
    }
    
    Image {
        id: failed;
        visible: false;
        width: 180;
        height: 37;
        source: "res/failed.png";
        z: 3;
        
        states: [
            State {
                name: "show";
                AnchorChanges {
                    target: failed;
                    anchors.horizontalCenter: root.horizontalCenter;
                    anchors.verticalCenter: root.verticalCenter;
                }
            },
            State {
                name: "hide";
                AnchorChanges {
                    target: failed;
                    anchors.left: root.left;
                    anchors.top: root.top;
                }
            }
        ]
       
        state: "hide";
       
        transitions: Transition{
            AnchorAnimation{
                duration: 1000;
                easing.type: Easing.OutInCubic;
            }
        }
        
        function showFailed(bShow){
            visible = bShow;   
            state = bShow ? "show" : "hide"; 
        }
    }
    
    Keys.onReturnPressed: fire();
    Keys.onSpacePressed: fire();
    
    Keys.onLeftPressed: animateTurret.rotate(-3);
    Keys.onRightPressed: animateTurret.rotate(3);
    
    function resetBulletPos(){
        bullet.x = root.width / 2 - bullet.width/2;
        bullet.y = root.height - bullet.height /2;    
    }
    
    onHeightChanged: {
        bullet.x = root.width / 2 - bullet.width/2;
    }
    onWidthChanged: {
        bullet.y = root.height - bullet.height /2;
    }
}