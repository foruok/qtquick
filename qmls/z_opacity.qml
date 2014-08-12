import QtQuick 2.2

Rectangle {
    width: 300;
    height: 200;

    Rectangle {
        x: 20;
        y: 20;
        width: 150;
        height: 100;
        color: "#000080";
        z: 0.5;
    }

    Rectangle {
        x: 100;
        y: 70;
        width: 100;
        height: 100;
        color: "#00c000";
        z: 1;
        opacity: 0.6;
    }
}