#ifndef SIZEUTIL_H
#define SIZEUTIL_H
#include <QFont>
#include <QString>

class SizeUtil: public QObject
{
    Q_OBJECT
private:
    SizeUtil(const SizeUtil &);
    SizeUtil & operator=(const SizeUtil&);
public:
    SizeUtil(){}
    ~SizeUtil(){}

    Q_INVOKABLE int defaultFontHeight();
    Q_INVOKABLE int widthWithDefaultFont(const QString &text);
    Q_INVOKABLE int widthWithFont(const QString &text, int fontPointSize);
    Q_INVOKABLE int fontHeight(int fontPointSize);
    Q_INVOKABLE qreal dpiFactor();
};

#endif // SIZEUTIL_H
