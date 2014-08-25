#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "probe.h"
#include "videoListModel.h"
#include <QLibraryInfo>
#include "../../stockMonitor/qDebug2Logcat.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    installLogcatMessageHandler("SomeVideo");
    //qDebug() << "libpath - " << QLibraryInfo::location(QLibraryInfo::LibrariesPath);

    ProbeVideo * probe = new ProbeVideo;
    VideoListModel *model = new VideoListModel;
    model->setSource(":/videos.xml");
    QQmlApplicationEngine engine;
    QQmlContext *ctx = engine.rootContext();
    ctx->setContextProperty("vprobe", probe);
    ctx->setContextProperty("vmodel", model);
    ctx->setContextProperty("currentVideo", model->currentVideo());
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
