import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Particles 2.0

Window {
    visible: true;
    width: 600;
    height: 400;
    color: "lightblue";
    id: root;

    Rectangle {
        id: target;
        color: "transparent";
        width: parent.width/2;
        height: 100;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 4;
    }

    ParticleSystem {
        id: particleSystem;
    }

    Emitter {
        id: emitter;
        system: particleSystem;

        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        width: 80;
        height: 80;

        size: 20;
        endSize: 80;
        sizeVariation: 10;
        emitRate: 20;
        lifeSpan: 4000;
        lifeSpanVariation: 200;
        velocity: TargetDirection {
            targetItem: target;
            targetX: target.width/2;
            targetY: 0;
            targetVariation: target.width/2;
            magnitude: root.height/3;
        }
    }

    ImageParticle {
        system: particleSystem;
        source: "qrc:///bubble_1.png";
    }
}
