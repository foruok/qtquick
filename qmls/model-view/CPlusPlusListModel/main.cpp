#include <QtGui/QGuiApplication>
//#include "qtquick2applicationviewer.h"
#include <QtQml/QtQml>
#include <QtQuick/QQuickView>
#include "videoListModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<VideoListModel>("an.qt.CModel", 1, 0, "VideoListModel");

    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource(QUrl("qrc:/res/main.qml"));
    viewer.show();

    return app.exec();
}
