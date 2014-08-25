TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    networkImageModel.cpp \
    directoryTraverse.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

HEADERS += \
    networkImageModel.h \
    networkImageModel_p.h \
    directoryTraverse.h

TRANSLATIONS += imageviewer_zh_CN.ts
