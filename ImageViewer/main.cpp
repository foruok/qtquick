#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include <QIcon>
#include "networkImageModel.h"
#include "directoryTraverse.h"

#include "../../stockMonitor/qDebug2Logcat.h"

#include <QKeyEvent>
#include <QDebug>

class KeyBackQuit: public QObject
{
public:
    KeyBackQuit(QObject *qmlRoot, QObject *parent = 0)
        : QObject(parent), m_qmlRoot(qmlRoot)
    {}

    bool eventFilter(QObject *watched, QEvent * e)
    {
        switch(e->type())
        {
        case QEvent::KeyPress:
            if( ((QKeyEvent*)e)->key() == Qt::Key_Back )
            {
                e->accept();
                return true;
            }
            break;
        case QEvent::KeyRelease:
            if( ((QKeyEvent*)e)->key() == Qt::Key_Back )
            {
                e->accept();
                //qApp->quit();
                QMetaObject::invokeMethod(m_qmlRoot, "backKeyProcess");
                return true;
            }
            break;
        default:
            break;
        }
        return QObject::eventFilter(watched, e);
    }

    QObject *m_qmlRoot;
};

int main(int argc, char *argv[])
{
    installLogcatMessageHandler("ImageViewer");
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

    QList<QObject*> rootObjects = engine.rootObjects();
    int count = rootObjects.size();
    for(int i = 0; i < count; i++)
    {
        if(rootObjects.at(i)->objectName() == "qmlWin")
        {
            qDebug() << "find qmlWin";
            app.installEventFilter(new KeyBackQuit(rootObjects.at(i)));
            break;
        }
    }

    return app.exec();
}
