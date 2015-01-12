#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFont>
#include <QQmlContext>
#include <QIcon>
#include <QLocale>
#include <QTranslator>
#include "sizeUtil.h"
#include "problem.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QFont f = app.font();
    f.setPointSize(24);
    app.setWindowIcon(QIcon(":/res/madmath_36.png"));

    QLocale locale = QLocale::system();
    if(locale.language() == QLocale::Chinese)
    {
        QTranslator *translator = new QTranslator(&app);
        if(translator->load(":/madmath_zh_cn.qm"))
        {
            app.installTranslator(translator);
        }
    }

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("sizeUtil", new SizeUtil);
    engine.rootContext()->setContextProperty("problems", new MathProblem);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
