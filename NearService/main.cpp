#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "../../stockMonitor/qDebug2Logcat.h"

int main(int argc, char *argv[])
{
    installLogcatMessageHandler("NearService");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
