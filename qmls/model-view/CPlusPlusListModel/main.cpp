#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/QtQml>
#include "videoListModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<VideoListModel>("an.qt.CModel", 1, 0, "VideoListModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
