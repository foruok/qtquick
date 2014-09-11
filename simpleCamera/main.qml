import QtQuick 2.2
import QtQuick.Window 2.1
import QtMultimedia 5.2
import QtQuick.Controls 1.1

Window {
    visible: true;
    width: 600;
    height: 400;
    color: "black";

    Camera {
        id: camera;
        captureMode: Camera.CaptureStillImage;

        focus {
            focusMode: Camera.FocusAuto;
            focusPointMode: Camera.FocusPointCenter;
        }

        imageProcessing {
            whiteBalanceMode: CameraImageProcessing.WhiteBalanceAuto;
        }
        flash.mode: Camera.FlashAuto;

        imageCapture {
            resolution: Qt.size(640, 480);
            onImageCaptured: {
                camera.stop();
                photoPreview.visible = true;
                actionBar.visible = false;
                viewfinder.visible = false;
                photoPreview.source = preview
            }
            onImageSaved: {
                console.log(path);
            }
        }
        onLockStatusChanged: {
            switch(lockStatus){
            case Camera.Locked:
                console.log("locked");
                imageCapture.captureToLocation("capture.jpg");
                unlock();
                break;
            case Camera.Searching:
                console.log("searching");
                break;
            case Camera.Unlocked:
                console.log("unlocked");
                break;
            }
        }
    }

    VideoOutput {
        id: viewfinder;
        source: camera;
        focus : visible;
        anchors.fill: parent;
        autoOrientation: true;
    }

    Image {
        id: photoPreview;
        anchors.fill: parent;
        visible: false;
        fillMode: Image.PreserveAspectFit;

        FlatButton {
            iconSource: "res/ic_launcher_camera.png";
            width: 76;
            height: 76;
            anchors.left: parent.left;
            anchors.bottom: parent.bottom;
            anchors.margins: 8;
            onClicked: {
                camera.start();
                actionBar.visible = true;
                viewfinder.visible = true;
                photoPreview.visible = false;
            }
        }
    }

    Image {
        id: actionBar;
        source: "res/control_bar.png";
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 8;
        anchors.horizontalCenter: parent.horizontalCenter;
        z: 1;
        FlatButton {
            id: shutter;
            anchors.centerIn: parent;
            iconSource: "res/ic_cam_shutter.png";
            width: 88;
            height: 88;
            iconWidth: 84;
            iconHeight: 84;
            onClicked: {
                camera.searchAndLock();
            }
        }
        FlatButton {
            id: zoomout;
            anchors.verticalCenter: shutter.verticalCenter;
            anchors.right: shutter.left;
            anchors.rightMargin: 4;
            width: 70;
            height: 70;
            iconWidth: 40;
            iconHeight: 40;
            text: "缩小";
            font.pointSize: 12;
            iconSource: "res/ic_zoom_out.png";
            onClicked: {
                console.log("maximumDigitalZoom-", camera.maximumDigitalZoom);
                console.log("maximumOpticalZoom-", camera.maximumOpticalZoom);
                if(camera.digitalZoom > 1){
                    camera.digitalZoom -= 1;
                }
            }
        }
        FlatButton {
            id: zoomin;
            anchors.verticalCenter: shutter.verticalCenter;
            anchors.right: zoomout.left;
            anchors.rightMargin: 4;
            width: 70;
            height: 70;
            iconWidth: 40;
            iconHeight: 40;
            text: "放大";
            font.pointSize: 12;
            iconSource: "res/ic_zoom_in.png";
            onClicked: {
                if(camera.digitalZoom < camera.maximumDigitalZoom){
                    camera.digitalZoom += 1;
                }
            }
        }
        FlatButton {
            id: currentFlash;
            anchors.verticalCenter: shutter.verticalCenter;
            anchors.left: shutter.right;
            anchors.leftMargin: 4;
            width: 70;
            height: 70;
            iconWidth: 40;
            iconHeight: 40;
            font.pointSize: 12;
            property var modeIcon: [
                "res/ic_menu_stat_flash_auto.png",
                "res/ic_menu_stat_flash.png",
                "res/ic_menu_stat_flash_off.png"
            ]
            property var modeDesc: [
                "自动", "打开", "关闭"
            ]
            property var flashMode: [
                Camera.FlashAuto, Camera.FlashOn, Camera.FlashOff
            ]
            property int mode: 0;
            text: modeDesc[mode];
            iconSource: modeIcon[mode];
            onClicked: {
                mode = (mode + 1)%3;
                camera.flash.mode = flashMode[mode];
            }
        }
        FlatButton {
            id: currentScene;
            anchors.verticalCenter: shutter.verticalCenter;
            anchors.left: currentFlash.right;
            anchors.leftMargin: 4;
            width: 70;
            height: 70;
            iconWidth: 40;
            iconHeight: 40;
            font.pointSize: 12;

            property var modeIcon: [
                "res/ic_menu_stat_auto.png",
                "res/ic_menu_stat_portrait.png",
                "res/ic_menu_stat_landscape.png",
                "res/ic_menu_stat_night.png",
                "res/ic_menu_stat_action.png"
            ]
            property var modeDesc: [
                "自动", "人物", "风景", "夜间", "运动"
            ]
            property var exposureMode: [
                Camera.ExposureAuto, Camera.ExposurePortrait,
                Camera.ExposureBeach, Camera.ExposureNight,
                Camera.ExposureSports
            ]
            property int mode: 0;
            text: modeDesc[mode];
            iconSource: modeIcon[mode];
            onClicked: {
                mode = (mode + 1)%5;
                camera.exposure.exposureMode = exposureMode[mode];
            }
        }
    }
}
