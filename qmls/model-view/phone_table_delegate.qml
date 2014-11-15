import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle {
    width: 360;
    height: 300;
    id: root;
    property var background: "#d7e3bc";
    property var alterBackground: "white";
    property var highlight: "#e4f7d6";
    property var headerBkgnd: "#F0F0F0";
    property var normalG: Gradient {
            GradientStop { position: 0.0; color: "#c7d3ac" }
            GradientStop { position: 1.0; color: "#F0F0F0" }
        }
    property var hoverG: Gradient {
            GradientStop { position: 0.0; color: "white"; }
            GradientStop { position: 1.0; color: "#d7e3bc"; }
        }
    property var pressG: Gradient {
            GradientStop { position: 0.0; color: "#d7e3bc"; }
            GradientStop { position: 1.0; color: "white"; }
        }           
    
    TableView {
        id: phoneTable;
        anchors.fill: parent;
        TableViewColumn{ role: "name"  ; title: "Name" ; width: 100; elideMode: Text.ElideRight;}
        TableViewColumn{ role: "cost" ; title: "Cost" ; width: 100; }        
        TableViewColumn{ role: "manufacturer" ; title: "Manufacturer" ; width: 140; }        

        itemDelegate: Text { 
            text: styleData.value;
            color: styleData.selected ? "red" : styleData.textColor;
            elide: styleData.elideMode;
        }
        
        rowDelegate: Rectangle {
            color: styleData.selected ? root.highlight : 
              (styleData.alternate ? root.alterBackground : root.background);
        }

        headerDelegate: Rectangle {
            implicitWidth: 10;
            implicitHeight: 24;
            gradient: styleData.pressed ? root.pressG : (styleData.containsMouse ? root.hoverG: root.normalG);
            border.width: 1;
            border.color: "gray";
            Text {
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: 4;
                anchors.right: parent.right;
                anchors.rightMargin: 4;
                text: styleData.value;
                color: styleData.pressed ? "red" : "blue";
                font.bold: true;
            }
        }
        
        model: ListModel {
            id: phoneModel;
            ListElement{
                name: "iPhone 5";
                cost: "4900";
                manufacturer: "Apple";
            }    
            ListElement{
                name: "B199";
                cost: "1590";
                manufacturer: "HuaWei";
            }  
            ListElement{
                name: "MI 2S";
                cost: "1999";
                manufacturer: "XiaoMi";
            }         
            ListElement{
                name: "GALAXY S5";
                cost: "4699";
                manufacturer: "Samsung";
            }                                                  
        }
        
        focus: true;
    }
}