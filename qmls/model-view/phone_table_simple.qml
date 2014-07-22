import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

Rectangle {
    width: 360;
    height: 300;
    color: "#EEEEEE";
    
    TableView {
        id: phoneTable;
        anchors.fill: parent;
        TableViewColumn{ role: "name"  ; title: "Name" ; width: 100; elideMode: Text.ElideRight;}
        TableViewColumn{ role: "cost" ; title: "Cost" ; width: 100; }        
        TableViewColumn{ role: "manufacturer" ; title: "Manufacturer" ; width: 140; }        

        itemDelegate: Text{ 
            text: styleData.value;
            color: styleData.selected ? "red" : styleData.textColor;
            elide: styleData.elideMode;
        }
        
        model: ListModel {
            id: phoneModel;
            ListElement{
                name: "iPhone 3GS";
                cost: "1000";
                manufacturer: "Apple";
            }
            ListElement{
                name: "iPhone 4";
                cost: "1800";
                manufacturer: "Apple";
            }            
            ListElement{
                name: "iPhone 4S";
                cost: "2300";
                manufacturer: "Apple";
            } 
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