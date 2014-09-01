TEMPLATE = app

QT += qml quick
QT += positioning
QT += network

SOURCES += main.cpp \
    ../../stockMonitor/qDebug2Logcat.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

HEADERS += \
    ../../stockMonitor/qDebug2Logcat.h
