#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
#if 1
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));
    //engine.load(QUrl("http://127.0.0.1:8081/text.qml"));
#else
    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeViewToRootObject);
    viewer.setSource(QUrl("qrc:///main.qml"));
    viewer.show();
#endif
    return app.exec();
}
