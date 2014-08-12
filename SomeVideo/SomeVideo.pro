TEMPLATE = app

QT += qml quick
QT += network

SOURCES += main.cpp \
    probe.cpp \
    probe_p.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    probe.h \
    probe_p.h
