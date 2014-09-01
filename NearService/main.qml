import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtPositioning 5.3
import QtQuick.Layouts 1.1

Window {
    visible: true
    width: 480
    height: 360;
    color: "black";
    id: root;

    property var city: null;
    property var groupon: null;
    property var geopos;
    property var xmlhttp: new XMLHttpRequest();
    property var parseResult;

    function gotPosition(){
        geopos = positionSource.position.coordinate;
        if(geopos.isValid && city == null){
            clue.text = "正在查询城市信息...";
            console.log("Coordinate:", geopos.longitude, geopos.latitude, geopos.isValid);
            getCity();
        }else{
            console.log("this time update failed, wait...");
        }
    }

    PositionSource {
        id: positionSource;
        updateInterval: 1000;
        active: true;
        onPositionChanged: {
            root.gotPosition();
        }
    }

    function onReadyResult(){
        if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
            parseResult(xmlhttp.responseText);
            xmlhttp.abort();
        }
    }

    function parseLocation(jsonText){
        var newcity = JSON.parse(jsonText);
        if(newcity != null && newcity.result.cityCode != 0){
            if(city == null || city.result.cityCode != newcity.result.cityCode){

                console.log("parseLocation, cityCode" , newcity.result.cityCode);
                listview.headerItem.area.text = newcity.result.addressComponent.city;
                if(city == null){
                    clue.text = "摸一下分类吧";
                    clue.visible = true;
                    positionSource.updateInterval = 30000;
                    busy.running = false;
                }
                city = newcity;
            }
        }else if(city == null){
            city = null;
            clue.text = "获取位置失败";
            clue.color = "red";
            busy.running = false;
        }
    }

    function parseGroupon(jsonText){
        groupon = JSON.parse(jsonText);
        if(groupon == null || groupon.status != 0 || groupon.results.length == 0){
            console.log("searchGroupon failed, ", groupon.message);
            clue.text = "抱歉哦";
        }else{
            listview.model.clear();
            clue.visible = false;

            var it;
            for(var i = 0; i < groupon.results.length; i++){
                it = groupon.results[i];
                listview.model.append(
                            {
                                "name": it.name,
                                "address": it.address,
                                "phone": it.telephone,
                                "distance": it.distance,
                                "count": it.events.length,
                                "picture": it.events[0].groupon_image
                            }
                            );
            }
        }
        busy.running = false;
    }

    function getCity(){
        if(xmlhttp.readyState == 0){
            var apiUrl = "http://api.map.baidu.com/geocoder?location=%1,%2&output=json&ak=28bcdd84fae25699606ffad27f8da77b".arg(geopos.latitude).arg(geopos.longitude);
            console.log("getCity start-", apiUrl);
            xmlhttp.onreadystatechange = onReadyResult;
            parseResult = parseLocation;
            xmlhttp.open("GET", apiUrl, true);
            xmlhttp.send(null);
            if(city == null){
                busy.running = true;
                clue.visible = true;
            }
        }
    }

    function searchGroupon(category){
        if(city != null && xmlhttp.readyState == 0){
            console.log("searchGroupon start...");
            var cate = encodeURIComponent(category);
            var apiUrl = "http://api.map.baidu.com/place/v2/eventsearch?query=%1&region=%2&event=groupon&location=%3,%4&output=json&page_size=6&ak=7fa612aa9f51f2dab4e685404afdcf25".arg(cate).arg(city.result.cityCode).arg(geopos.latitude).arg(geopos.longitude);
            //console.log(apiUrl);
            xmlhttp.onreadystatechange = onReadyResult;
            parseResult = parseGroupon;
            xmlhttp.open("GET", apiUrl, true);
            xmlhttp.send(null);
            busy.running = true;
            clue.visible = true;
            clue.text = "努力获取数据...";
            clue.color = "blue";
        }
    }

    BusyIndicator {
        id: busy;
        anchors.centerIn: parent;
        running: true;
        z: 2;
    }
    Text {
        id: clue;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: busy.bottom;
        anchors.topMargin: 4;
        color: "blue";
        font.pointSize: 16;
        z: 2;
        visible: true;
        text: "正在获取位置……";
    }

    Component {
        id: businessDelegate;
        Item {
            id: wrapper;
            width: parent.width;
            height: 150;
            MouseArea {
                anchors.fill: parent;
                onClicked: wrapper.ListView.view.currentIndex = index;
            }
            Image {
                id: pic;
                x: 2;
                y: 2;
                width: 146;
                height: 146;
                source: picture;
            }

            ColumnLayout {
                anchors.left: pic.right;
                anchors.top: pic.top;
                anchors.right: parent.right;
                anchors.bottom: parent.bottom;
                anchors.margins: 2;
                spacing: 2;
                Text {
                    Layout.fillWidth: true;
                    font.pointSize: 15;
                    font.bold: true;
                    color: "white";
                    text: "<b><font color='#0000FF'>%1</font></b>,%2个结果".arg(name).arg(count);
                }
                Text {
                    Layout.fillWidth: true;
                    font.pointSize: 12;
                    color: "white";
                    elide: Text.ElideRight;
                    text: "地址:%1".arg(address);
                }
                Text {
                    Layout.fillWidth: true;
                    font.pointSize: 12;
                    color: "white";
                    text: "电话:%1".arg(phone);
                }
                Text {
                    Layout.fillWidth: true;
                    font.pointSize: 12;
                    color: "white";
                    text: "距离:%1米".arg(distance);
                }
            }
        }
    }

    ListView {
        id: listview;
        anchors.fill: parent;
        anchors.margins: 4;
        spacing: 4;
        delegate: businessDelegate;
        model: ListModel{}
        highlight: Rectangle{
            width: parent.width;
            color: "lightblue";
        }
        header: actionView;
    }

    Component {
        id: flat;
        ButtonStyle {
            background: Rectangle {
                border.color: "#606060";
                border.width: 2;
                radius: 4;
                color: control.pressed ? "#989898" : "transparent";
                implicitWidth: 80;
                implicitHeight: 36;
            }
            label: Text{
                font.pointSize: 15;
                color: control.pressed ? "blue" : "white";
                text: control.text;
                verticalAlignment: Text.AlignVCenter;
                horizontalAlignment: Text.AlignHCenter;
            }
        }
    }

    Component {
        id: actionView;
        Item {
            width: parent.width;
            height: 46;
            property alias area: location;

            Rectangle {
                id: splitter;
                color: "transparent";
                border.width: 1;
                height: 2;
                border.color: "#666666";
                width: parent.width;
                anchors.bottom: parent.bottom;
            }

            Button{
                id: eat;
                anchors.top: parent.top;
                anchors.topMargin: 2;
                anchors.left: parent.left;
                anchors.leftMargin: 4;
                anchors.bottom: splitter.top;
                style: flat;
                text: "餐饮";
                onClicked: searchGroupon(text);
            }
            Button{
                id: enjoy;
                anchors.top: eat.top;
                anchors.left: eat.right;
                anchors.bottom: eat.bottom;
                anchors.leftMargin: 4;
                style: flat;
                text: "娱乐";
                onClicked: searchGroupon(text);
            }
            Button{
                id: travel;
                anchors.top: eat.top;
                anchors.left: enjoy.right;
                anchors.bottom: eat.bottom;
                anchors.leftMargin: 4;
                width: 140;
                style: flat;
                text: "旅游住宿";
                onClicked: searchGroupon(text);
            }

            Text {
                id: location;
                anchors.leftMargin: 4;
                anchors.left: travel.right;
                anchors.top: travel.top;
                anchors.bottom: travel.bottom;
                font.pointSize: 15;
                color: "steelblue";
                verticalAlignment: Text.AlignVCenter;
            }
        }
    }
}
