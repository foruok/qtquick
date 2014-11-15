import QtQuick 2.2
import QtQuick.Window 2.1

Rectangle {
    readonly property string currentDir: detectResDir();

    Image{
        anchors.centerIn: parent;
        source: "res/" + currentDir + "/logo.png";
    }
    
    function detectResDir(){
        var dpi = Screen.pixelDensity*25.4;
        if(dpi >= 480){
            return "XXHDPI";
        }else if (dpi >= 320){
            return "XHDPI";
        }else if (dpi >= 240){
            return "HDPI";
        }else if (dpi >= 180){
            return "MDPI";
        }else{
            return "LDPI";
        }    
    }
}