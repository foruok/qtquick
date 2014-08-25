TEMPLATE = app
QT += gui quick

SOURCES += main.cpp \
    imageProcessor.cpp

HEADERS += \
    imageProcessor.h
    
RESOURCES += qml.qrc    

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml
