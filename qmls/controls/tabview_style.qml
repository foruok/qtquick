import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Rectangle {
    width: 360;
    height: 240;
    color: "lightgray";
    id: root;
    property var icons: ["call1.png", "call2.png", "call3.png"];
    Component.onCompleted: {
        tabView.addTab("ABC", tabContent);
        tabView.addTab("ZXY", tabContent);
        tabView.addTab("MQF", tabContent);
        tabView.addTab("WKJ", tabContent);
    }
    
    Component {
        id: tabContent;
        Rectangle {
            implicitWidth: 100;
            implicitHeight: 100;
            anchors.fill: parent;
            color: Qt.rgba(Math.random(), Math.random(), Math.random());
        }
    }

    TabView {
        id: tabView;
        anchors.fill: parent;
        
        style: TabViewStyle {
            tab: Item{
                implicitWidth: Math.max(text.width + 8, 80);
                implicitHeight: 48;  
                Rectangle {
                    width: (styleData.index < control.count - 1) ? (parent.width - 2) : parent.width;
                    height: parent.height - 4;
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.leftMargin: 1;
                    visible: styleData.selected;
                    gradient: Gradient {
                        GradientStop{position: 0.0; color: "#606060";}
                        GradientStop{position: 0.5; color: "#c0c0c0";}
                        GradientStop{position: 1.0; color: "#a0a0a0";}
                    }
                }
                Rectangle {
                    width: 2;
                    height: parent.height - 4;
                    anchors.top: parent.top;
                    anchors.right: parent.right;
                    visible: styleData.index < control.count - 1;
                    gradient: Gradient {
                        GradientStop{position: 0.0; color: "#404040";}
                        GradientStop{position: 0.5; color: "#707070";}
                        GradientStop{position: 1.0; color: "#404040";}
                    }
                }                
                RowLayout {
                    implicitWidth: Math.max(text.width, 72);
                    height: 48;
                    anchors.centerIn: parent;
                    z: 1;
                    Image{
                        width: 48;
                        height: 48;
                        source: root.icons[styleData.index%3];
                    }
                    Text {
                        id: text;
                        text: styleData.title;
                        color: styleData.selected ? "blue" : (styleData.hovered ? "green" : "white");
                    }
                }   
            }
            tabBar: Rectangle {
                height: 56;
                gradient: Gradient {
                    GradientStop{position: 0.0; color: "#484848";}
                    GradientStop{position: 0.3; color: "#787878";}
                    GradientStop{position: 1.0; color: "#a0a0a0";}
                }
                Rectangle {
                    width: parent.width;
                    height: 4;
                    anchors.bottom: parent.bottom;
                    border.width: 2;
                    border.color: "#c7c7c7";
                }
            }         
        }
    }    
}
