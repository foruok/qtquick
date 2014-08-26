import QtQuick 2.2
import QtQuick.Window 2.1

Window {
    visible: true
    width: 360
    height: 360

    MultiPointTouchArea {
        anchors.fill: parent;
        touchPoints:[
            TouchPoint{
                id: tp1;
            },
            TouchPoint{
                id: tp2;
            },
            TouchPoint{
                id: tp3;
            }

        ]
    }

    Image {
        source: "ic_qt.png";
        x: tp1.x;
        y: tp1.y;
    }

    Image {
        source: "ic_android.png";
        x: tp2.x;
        y: tp2.y;
    }

    Image {
        source: "ic_android_usb.png";
        x: tp3.x;
        y: tp3.y;
    }
}
