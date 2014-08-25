#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QQuickItem>
#include "changeColor.h"
#include <QMetaObject>
#include <QDebug>
#include <QColor>
#include <QVariant>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource(QUrl("qrc:///main.qml"));
    viewer.show();

    QQuickItem * rootItem = viewer.rootObject();
    new ChangeQmlColor(rootItem);
    QObject * quitButton = rootItem->findChild<QObject*>("quitButton");
    if(quitButton)
    {
        QObject::connect(quitButton, SIGNAL(clicked()), &app, SLOT(quit()));
    }

    QObject *textLabel = rootItem->findChild<QObject*>("textLabel");
    if(textLabel)
    {
        //1. failed call
        bool bRet = QMetaObject::invokeMethod(textLabel, "setText", Q_ARG(QString, "world hello"));
        qDebug() << "call setText return - " << bRet;
        textLabel->setProperty("color", QColor::fromRgb(255,0,0));
        bRet = QMetaObject::invokeMethod(textLabel, "doLayout");
        qDebug() << "call doLayout return - " << bRet;
    }

    return app.exec();
}
