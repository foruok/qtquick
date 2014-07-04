#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QtQml>
#include "colorMaker.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //qmlRegisterType<ColorMaker>("an.qt.ColorMaker", 1, 0, "ColorMaker");

    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("colorMaker", new ColorMaker);
    viewer.setMainQmlFile(QStringLiteral("qml/colorMaker/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
