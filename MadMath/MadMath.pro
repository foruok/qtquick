TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    sizeUtil.cpp \
    problem.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    sizeUtil.h \
    problem.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

TRANSLATIONS = madmath_zh_cn.ts

lupdate_only {
    SOURCES = main.qml
}
