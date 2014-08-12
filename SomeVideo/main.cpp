#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "probe.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ProbeVideo * probe = new ProbeVideo;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("vprobe", probe);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
