#include "sizeUtil.h"
#include <QGuiApplication>
#include <QFontMetrics>
#include <QScreen>

int SizeUtil::defaultFontHeight()
{
    QFont f = qApp->font();
    QFontMetrics fm(f);
    return fm.height();
}

int SizeUtil::widthWithDefaultFont(const QString &text)
{
    QFont f = qApp->font();
    QFontMetrics fm(f);
    return fm.boundingRect(text).width();
}

int SizeUtil::widthWithFont(const QString &text, int fontPointSize)
{
    QFont f = qApp->font();
    f.setPointSize(fontPointSize);
    QFontMetrics fm(f);
    return fm.boundingRect(text).width();
}

int SizeUtil::fontHeight(int fontPointSize)
{
    QFont f = qApp->font();
    f.setPointSize(fontPointSize);
    QFontMetrics fm(f);
    return fm.height();
}

qreal SizeUtil::dpiFactor()
{
    QScreen *screen = qApp->primaryScreen();
    return screen->logicalDotsPerInch() / 72;
}
