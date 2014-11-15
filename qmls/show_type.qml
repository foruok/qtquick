import QtQuick 2.2
 
Rectangle {
    id: root;
    width: 300;
    height: 200;
    Text{
        text: "simple demo";
    }
    Rectangle{
        anchors.bottom: parent.bottom;
        color: "red";
        width: 50;
        height: 30;
    }
    
    signal kkkk(int c);

    Component.onCompleted:{

        console.log("%1 visual children:".arg(children.length));
        for(var i = 0; i < children.length; i++){
            console.log(children[i]);
        }
    /*    
        var name = "Zhang San Feng";
        console.log(typeof name);
        console.log(typeof 60);
        name[0] = "S";
        console.log(name[0]);
        console.log(name);
        console.log(2.0.toString());
    var name = "Zhang San Feng";
    console.log(name.toString());
    console.log(true.toString());
    var visible = false;
    console.log(visible.toString());
    //console.log(2.toString());
    var integer = 3.14159;
    console.log(integer.toString());       
    console.log(parseInt("AK47", 16)); 
    console.log(Boolean(new Array()));
    console.log(Number.POSITIVE_INFINITY);
        var obj = new Object();
        console.log(obj.toString());
        console.log(obj.constructor);
        var a = new Array();
        console.log(a.hasOwnProperty("ToString"));
        console.log(a.toString());
        console.log(a.hasOwnProperty("toString()"));
        console.log(root.hasOwnProperty("width"));
        console.log(Item.isPrototypeOf(root));
        console.log(root.propertyIsEnumerable("children"));
        console.log(root.toString());
        console.log(root.valueOf());
        
        console.log("I\'m a string".length);
        var str = new String("I\'m a string");
        str[0] = 'K';
        console.log(str[0]);
console.log(str.charAt(2));
console.log(str[0]);  
console.log(str.charCodeAt(1)); 
        console.log(str.indexOf("ing"));
        console.log(str.search(/String/));
        console.log(str.match(/String/));
        console.log(str.match(/String/i));
        console.log(str.lastIndexOf(" "));
        console.log(str.search(/String/i));
        console.log(str.search(new RegExp("String", "i")));
        console.log(str.search("i"));
        console.log(str.match("tri"));
        var numberSource = new String("2014-08-18, I got 96");
        var results = numberSource.match(/\d+/g);
        console.log(results.length);
        console.log(results);
        
        console.log("+++concat");
        var str1 = new String("Qt");
        var str2 = "Quick";
        var strResult = str1.concat(str2, " is", " great!");
        console.log(strResult);
        console.log(str1);
        console.log(str1.concat(" Widgets"));
        console.log(str1 + str2);
        
        console.log("+++++substring test");
        var source = new String("I like QML");
        console.log(source.slice(-3));
        console.log(source.slice(2,6));
        console.log(source.substring(0, 6));
        console.log(source.substring(-3));
        console.log(source.substring(4, -3));
        console.log(source.slice(4, -3));
        console.log(source.substr(2,4));
        
        console.log("+++upper / lower");
        var orig = "Qt QuICk";
        console.log(orig.toLocaleLowerCase());
        console.log(orig.toLowerCase());
        console.log(orig.toLocaleUpperCase());
        console.log(orig.toUpperCase());
        
        console.log("++++replace");
        var strSource = new String("Android is best");
        console.log(strSource.replace("Android", "iOS"));
        console.log(strSource.replace(/best/, "worst"));
        */
        
        /*
        console.log("+++array test");
        var a = new Array(10, 6, 3, 21, 22, 30, "zhangsan");
        console.log("array length - ", a.length);
        console.log("2nd element - ", a[1]);
        console.log("7th - ", a[6]);
        a[6] = "ZhangSanFeng";
        a[7] = "XieXun";
        a.push(250);
        a.unshift(1);
        console.log(a.join(" "));
        console.log(a.shift());
        a.reverse();
        console.log(a.pop());
        console.log(a.sort());
        console.log(a.pop());
        console.log(a.pop());
        console.log(a.sort());
        
        console.log("+++array sub");
        var array = new Array("I", "like", "Qt", "Quick");
        var subArray = array.slice(2, 4);
        console.log(subArray.join(" "));
        var newArray = array.concat("!", subArray);
        console.log(newArray.join(" "));
        newArray[0] = "Do you";
        newArray.splice(4, 3, "?", "Yes", "!");
        console.log(newArray.join(" "));
        */
        
        /*
        console.log(Math.E, Math.PI, Math.LN2, Math.LN10, Math.LOG2E, Math.LOG10E, Math.SQRT2, Math.SQRT1_2);
        //console.log(Math.toSource());
        console.log(Math.atan2(10,8));
        console.log(Math.ceil(5.3));
        */
        
        
        var d = new Date();
        console.log(d.toString());
        console.log(d.getFullYear(), "-", d.getMonth(), "-", d.getDate());
        console.log("since 1970.1.1 - ", d.getTime());
        
        
        //console.profile();
        //console.time("regexp");
        //var str = "We are dogs;\nYour dogs;\nWe want meat, please.\nDon\'t drive us, please.";
        //var lines = str.match(/^We.*/mg);
        //console.log(lines.length);
        //console.log(lines);
        //console.timeEnd("regexp");
        
        /*
        var strTemp = "string one";
        strTemp += " two";
        console.log(strTemp);
        
        var num = -10;
        console.log(num >> 1);
        console.log(8^4);
        
        //console.profileEnd();
        

        var d = new Date();
        if(d.getDay() == 5){
            console.log("Good , I want to fly!");
        }else if(d.getDay() == 1){
            console.log("What are you doing?");
        }else{
            console.log("Oh, just so so...");
        }
        
        switch(d.getDay()){
        case 0:
            console.log("Oh, tomorrow will back to work!");
            break;
        case 6:
            console.log("Good, enjoy yourself.");
            break;
        case 1:
            console.log("I\'ve nofeeling about work.");
            break;            
        case 5:
            console.log("Good, go to BBQ tomorrow!");
            break;
        default:
            console.log("Just so so ...");
        }

        var years = 0
        for(; years < 18; years++){
            console.log("I\'m minor, ^_^");
            continue;
            console.log("You shoult not see me");  
        }
        console.assert(years < 18, years);
        console.info("I\'d reached an adult age");
        console.debug("and ought to be earning my own living.");
        console.warn("warn msg");
        console.error("error msg");
        console.assert(false);
        //console.trace();
        console.debug("%d", 3.14159);
        console.debug(root);
                var array = new Array(10, 12, 8, "Anna");
        console.debug("print array:", array);

var uri = "http://www.baidu.com/s?wd=Katie Melua";
var encodedUri = encodeURI(uri);
var encodedComponent = encodeURIComponent(uri);
console.log(encodedUri);
console.log(encodedComponent);
var decodedUri = decodeURI(encodedUri);
var decodedComponent = decodeURIComponent(encodedComponent);
console.log(decodedUri);
console.log(decodedComponent);        
*/
/*
        console.log(eval("5+2"));
        var s = "8+7";
        console.log(eval(s));
        var s2 = new String("9+10");
        console.log(eval(s2));
        */
        var expression = "%1 < %2 = %3";
        var result = expression.arg(7).arg(8).arg("true");
        console.log(result);
        console.log(expression.arg(10).arg(6).arg(false));
        console.log("I am %1 years old.".arg(10));
        console.log("rect %1".arg(root));
        /*
//var birthday1 = new Date("December 17, 1995 03:24:00");
var birthday1 = new Date("2009-10-21T22:24:00");
var birthday2 = new Date(2009, 10, 21);
var birthday3 = new Date(2009, 10, 21, 22, 24, 0);        
console.log(birthday1);
console.log(birthday2);
console.log(birthday3);
//console.log(birthday4);
console.log(Date.now());
console.log(Date.parse("2009-10-21T22:24:00"));
console.log(Date.UTC(1980, 3, 21));
        var start = Date.now();
        for(var i = 0; i < 10000000; i++);
        var end = Date.now();
        var elapsed = end - start;
        console.log(elapsed);
        
        var start = Date.now();
        var future = Date.UTC(2015,1,1,12);
        var distance = future - start;
        console.log(distance);

        var today = new Date();
        console.log(Qt.formatDateTime(today, "yyyy-MM-dd hh:mm:ss.zzz"));
        console.log(today.toLocaleString(Qt.locale("zh_CN")));
        console.log(today.toLocaleString(Qt.locale("en_US"), Locale.ShortFormat));
        console.log(today.toLocaleDateString(Qt.locale("en_US")));
        var date = Date.fromLocaleString(Qt.locale("en_US"), "10/21/2009 10:21 PM", Locale.ShortFormat);
        var r = date instanceof Date;
        */
        /*
        console.log(r);
        console.log(Qt.ElideLeft);
        */
        //Qt.openUrlExternally("http://www.baidu.com/s?wd=gaoyuanyuan");
        //var resolvedUrl = Qt.resolvedUrl("../ColorPicker.qml");
        //console.log(resolvedUrl);
        for(var i = 0; i < 2; i++){
            console.log(i);
        }
        
        /*
        var person = new Object();
        person.name = "zhangsan";
        person.year = 20;
        person.printInfo = function printInfo(){
            console.log("name -", this.name, " year -", this.year);
        }
        */
        var person = {
            "name": "zhangsan",
            "year": 20
        }
        person.printInfo = function printInfo(){
            console.log("name -", this.name, " year -", this.year);
        }        
        
        person.printInfo();
        console.log(person["name"]);
        person["printInfo"]();        
        
        for(var prop in person){
            console.log(prop, ",", person[prop]);
        }
        
        var a = [2, 3, 4, "?", "Quick"]
        console.log(a.length, a[2]);

        
    }
}
