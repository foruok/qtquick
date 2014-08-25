#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include <QIcon>
#include "networkImageModel.h"
#include "directoryTraverse.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/icons/ic_find.png"));
    QTranslator t;
    t.load(":/imageviewer_zh_CN.qm");
    app.installTranslator(&t);

    QQmlApplicationEngine engine;
    ImageModel * model = new ImageModel();
    DirectoryTraverse *traverse = new DirectoryTraverse();
    engine.rootContext()->setContextProperty("imageModel", model);
    engine.rootContext()->setContextProperty("dirTraverse", traverse);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
