import QtQuick 2.2

Rectangle {
    width: 300;
    height: 200;
    id: root;
    property var person: new Object();
    function replacer(key, value){
        switch(key){
        case "name":
            return "Zhang San";
        }
        return value;
    }
    
    property var array: new Array();
    
    
    Component.onCompleted:{
        //stringify an array
        array[0] = "version";
        array[1] = 2.3;
        console.log(JSON.stringify(array));
        
        //stringify object
        person.name = "zhangsan";
        person.mobile = "13888888888";
        person.age = 20;
        person.country = "China";
        
        console.log(JSON.stringify(person));
        console.log(JSON.stringify(person, null, 4));
        console.log(JSON.stringify(person, ["name", "mobile"], "  "));
        console.log(JSON.stringify(person, replacer));
        
        //use toJSON
        person.toJSON = function(key){
            var replacement = new Object();
            for(var p in this){
                if (typeof (this[p]) === 'string'){
                    replacement[p] = this[p].toUpperCase();
                }else{
                    replacement[p] = this[p];
                }
            }
            return replacement;
        }
        console.log(JSON.stringify(person));
    }
}