#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "PaintedItem.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<PaintedItem>("an.qml.Controls", 1, 0, "APaintedItem");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
