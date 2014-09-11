#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "dynamicModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *ctx = engine.rootContext();
    ctx->setContextProperty("dynamicModel", new DynamicListModel());
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
