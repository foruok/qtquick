#include <QtGui/QGuiApplication>
//#include <QtQuick/QQuickView>
#include <QQmlApplicationEngine>
#include "changeColor.h"
#include <QMetaObject>
#include <QDebug>
#include <QColor>
#include <QVariant>
//#include <QtQml>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    /*
    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource(QUrl("qrc:///main.qml"));
    viewer.show();
    */
    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:///main.qml"));

    QObject * root = NULL;//= qobject_cast<QObject*>(viewer.rootObject());
    QList<QObject*> rootObjects = engine.rootObjects();
    int count = rootObjects.size();
    qDebug() << "rootObjects- " << count;
    for(int i = 0; i < count; i++)
    {
        if(rootObjects.at(i)->objectName() == "rootObject")
        {
            root = rootObjects.at(i);
            break;
        }
    }
    new ChangeQmlColor(root);
    QObject * quitButton = root->findChild<QObject*>("quitButton");
    if(quitButton)
    {
        QObject::connect(quitButton, SIGNAL(clicked()), &app, SLOT(quit()));
    }

    QObject *textLabel = root->findChild<QObject*>("textLabel");
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
