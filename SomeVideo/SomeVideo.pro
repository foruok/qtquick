TEMPLATE = app

QT += qml quick
QT += network
QT += multimedia

SOURCES += main.cpp \
    probe.cpp \
    probe_p.cpp \
    videoListModel.cpp \
    ../../stockMonitor/qDebug2Logcat.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    probe.h \
    probe_p.h \
    videoListModel.h \
    ../../stockMonitor/qDebug2Logcat.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

#contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
#    ANDROID_EXTRA_LIBS = C:/Qt/Qt5.3.1/5.3/android_armv7/lib/libQt5MultimediaQuick_p.so \
#        C:\Qt\Qt5.3.1\5.3\android_armv7\lib\libQt5Multimedia.so
#}
