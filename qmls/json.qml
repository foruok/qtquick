import QtQuick 2.2

Rectangle {
    width: 300;
    height: 200;
    function receiver(key, value){
         if(key == "age"){
             return undefined;
         }
         return value;
    }
    Component.onCompleted:{
        var obj = JSON.parse("{\"status\":\"0\",\"t\":\"1401346439107\",\"data\":[{\"location\":\"安徽省宿州市 电信\",\"origip\":\"36.57.177.187\"}]}");
        console.log("status = ", obj.status);
        console.log("ip = ", obj.data[0].origip);
        console.log("area = ", obj.data[0].location);
        
        var filteredObj = JSON.parse("{\"name\":\"Wang Er\",\"age\":18}", function(k,v){if(k == "age") return undefined; return v;});
        console.log("name = ", filteredObj.name);
        console.log("age = ", filteredObj.age);
    }
}