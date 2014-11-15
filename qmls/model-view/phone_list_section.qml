import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    width: 360;
    height: 400;
    color: "#EEEEEE";
    
    Component {
        id: phoneModel;
        ListModel {
            // Apple section
            ListElement{
                name: "iPhone 5";
                cost: "4900";
                manufacturer: "Apple";
            }           
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
            //HuaWei section
            ListElement{
                name: "B199";
                cost: "1590";
                manufacturer: "HuaWei";
            }                 
            ListElement{
                name: "C8816D";
                cost: "590";
                manufacturer: "HuaWei";
            }               
            // Sumsung section
            ListElement{
                name: "GALAXY S4";
                cost: "3099";
                manufacturer: "Samsung";
            }       
            ListElement{
                name: "GALAXY S5";
                cost: "4699";
                manufacturer: "Samsung";
            }   
            // XiaoMi section                    
            ListElement{
                name: "MI 2S";
                cost: "1999";
                manufacturer: "XiaoMi";
            }         

            ListElement{
                name: "MI 3";
                cost: "1999";
                manufacturer: "XiaoMi";
            }                                                            
        }
    }
    
    Component {
        id: phoneDelegate;
        Item {
            id: wrapper;
            width: parent.width;
            height: 30;
            ListView.onAdd: {
                console.log("count:", ListView.view.count);
            }       
            
            MouseArea {
                anchors.fill: parent;
                onClicked: wrapper.ListView.view.currentIndex = index;
            }                 
            
            RowLayout {
                anchors.left: parent.left;
                anchors.verticalCenter: parent.verticalCenter;
                spacing: 8;
                Text { 
                    id: col1;
                    text: name; 
                    color: wrapper.ListView.isCurrentItem ? "red" : "black";
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18;
                    Layout.preferredWidth: 120;
                }
                
                Text { 
                    text: cost; 
                    color: wrapper.ListView.isCurrentItem ? "red" : "black";
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18;
                    Layout.preferredWidth: 80;
                }
                
                Text { 
                    text: manufacturer; 
                    color: wrapper.ListView.isCurrentItem ? "red" : "black";
                    font.pixelSize: wrapper.ListView.isCurrentItem ? 22 : 18;
                    Layout.fillWidth: true;
                }                
            }
        }
    }
    
   Component {
        id: sectionHeader
        Rectangle {
            width: parent.width
            height: childrenRect.height
            color: "lightsteelblue"

            Text {
                text: section
                font.bold: true
                font.pixelSize: 20
            }
        }
    }    
    
    ListView {
        id: listView;
        anchors.fill: parent;

        delegate: phoneDelegate;
        model: phoneModel.createObject(listView);
        focus: true;
        highlight: Rectangle{
            width: parent.width;
            color: "lightblue";
        }
        
        section.property: "manufacturer";
        section.criteria: ViewSection.FullString;
        section.delegate: sectionHeader;
    }
}
