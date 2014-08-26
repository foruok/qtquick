#ifndef DIRECTORYTRAVERSE_H
#define DIRECTORYTRAVERSE_H
#include <QObject>
#include <QStringList>
#include <QUrl>

class DirectoryRunnable;
class DirectoryTraverse : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString folder READ folder WRITE setFolder)
    Q_PROPERTY(QStringList nameFilters READ nameFilters WRITE setNameFilters)
    Q_PROPERTY(QUrl current READ current WRITE setCurrent)
    Q_PROPERTY(int currentIndex READ currentIndex)

public:
    DirectoryTraverse(QObject *parent = 0);
    ~DirectoryTraverse();

    QString folder() const { return m_strFolder; }
    void setFolder(QString strFolder);
    QStringList nameFilters() const { return m_nameFilters;  }
    void setNameFilters(QStringList nameFilters){ m_nameFilters = nameFilters; }
    QUrl current();
    void setCurrent(QUrl url);
    int currentIndex(){return m_nCurrent;}

    Q_INVOKABLE QList<QString> files(){ return m_files; }
    Q_INVOKABLE QUrl next();
    Q_INVOKABLE QUrl prev();
    Q_INVOKABLE int count(){ return m_files.size();}

    bool event(QEvent *e);

signals:
    void updated();

private:
    QString m_strFolder;
    QStringList m_nameFilters;
    DirectoryRunnable *m_currentRunnable;
    QList<QString> m_files;
    int m_nCurrent;
};

#endif // DIRECTORYTRAVERSE_H
