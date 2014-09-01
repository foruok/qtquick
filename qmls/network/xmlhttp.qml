import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2

Window {
    id: root;
    visible: true;
    width: 300;
    height: 200;
    minimumWidth: 300;
    minimumHeight: 200;
    color: "black";
    
    property var xmlhttp: null;
    function onResultReady(){
        if(xmlhttp.readyState == 4){
            console.log("Status Code: ", xmlhttp.status);
            xmlhttp.abort();
        }
    }
    function post(){
        if(xmlhttp == null){
            xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = onResultReady;
        }
        if(xmlhttp.readyState ==0){
            xmlhttp.open("POST", "http://127.0.0.1:8081/POST_AGGRESSIVE_PUSH_IN_CACHE_STATUS_SINGLE.php");
            xmlhttp.send("test post");
        }
    }
    
    Button {
        anchors.centerIn: parent;
        text: "Send";
        onClicked: root.post();
    }
}
