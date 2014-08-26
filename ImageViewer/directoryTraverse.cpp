#include "directoryTraverse.h"
#include <QThreadPool>
#include <QFileInfoList>
#include <QDir>
#include <QRunnable>
#include <QPointer>
#include <QEvent>
#include <QDebug>
#include <QCoreApplication>


class ExcutedEvent : public QEvent
{
public:
    ExcutedEvent(DirectoryRunnable *r)
        : QEvent(evType()), m_runnable(r)
    {

    }
    ~ExcutedEvent();

    DirectoryRunnable *m_runnable;

    static QEvent::Type evType()
    {
        if(s_evType == QEvent::None)
        {
            s_evType = (QEvent::Type)registerEventType();
        }
        return s_evType;
    }

private:
    static QEvent::Type s_evType;
};
QEvent::Type ExcutedEvent::s_evType = QEvent::None;

class DirectoryRunnable : public QRunnable
{
public:
    DirectoryRunnable(QObject *observer,
                      const QString &path,
                      QStringList &nameFilters)
        : m_observer(observer)
        , m_path(path)
        , m_nameFilters(nameFilters)
    {

    }

    void run()
    {
        QDir dir(m_path);
        m_fileInfos = dir.entryInfoList(m_nameFilters,
                                QDir::Files|QDir::Readable,
                                QDir::Name|QDir::IgnoreCase);
        QCoreApplication::postEvent(m_observer, new ExcutedEvent(this));
    }

    void extractFiles(QList<QString> &files)
    {
        int count = m_fileInfos.size();
        for(int i = 0; i < count; i++)
        {
            files.append(m_fileInfos.at(i).fileName());
        }
    }

    QPointer<QObject> m_observer;
    QString m_path;
    QStringList m_nameFilters;
    QFileInfoList m_fileInfos;
};

ExcutedEvent::~ExcutedEvent()
{
    delete m_runnable;
}


DirectoryTraverse::DirectoryTraverse(QObject *parent)
    : QObject(parent), m_currentRunnable(0), m_nCurrent(-1)
{
    m_nameFilters << "*.jpg" << "*.JPG" << "*.PNG" << "*.png" << "*.bmp" << "*.BMP" << "*.GIF" << "*.gif";
}

DirectoryTraverse::~DirectoryTraverse()
{

}

bool DirectoryTraverse::event(QEvent *e)
{
    if(e->type() == ExcutedEvent::evType())
    {
        e->accept();
        ExcutedEvent *ee = (ExcutedEvent*)e;
        if(ee->m_runnable == m_currentRunnable)
        {
            m_files.clear();
            ee->m_runnable->extractFiles(m_files);
            m_currentRunnable = 0;
            emit updated();
        }

        return true;
    }
    return QObject::event(e);
}

void DirectoryTraverse::setFolder(QString strFolder)
{

#ifdef Q_OS_WIN
    m_strFolder = strFolder.mid(8);
#else
    m_strFolder = strFolder.mid(7);
#endif
    //qDebug() << "setFolder - " << m_strFolder;
    m_currentRunnable = new DirectoryRunnable(this, m_strFolder, m_nameFilters);
    m_currentRunnable->setAutoDelete(false);
    QThreadPool::globalInstance()->start(m_currentRunnable);
}

QUrl DirectoryTraverse::current()
{
    int count = m_files.size();
    if(count && m_nCurrent < count)
    {
        return QUrl::fromLocalFile(QString("%1/%2").arg(m_strFolder).arg(m_files.at(m_nCurrent)));
    }
    return QUrl();
}

void DirectoryTraverse::setCurrent(QUrl url)
{
    QString fileName = url.fileName();
    int count = m_files.size();
    //qDebug() << "setCurrent, count - " << count << " ," << fileName;
    for(int i = 0; i < count; i++)
    {
        if(m_files.at(i) == fileName)
        {
            m_nCurrent = i;
            return;
        }
    }
    m_nCurrent = -1;
}

QUrl DirectoryTraverse::next()
{
    int count = m_files.size();
    if(m_nCurrent >=0 && count)
    {
        if( ++m_nCurrent >= count)
        {
            m_nCurrent = 0;
        }
        return QUrl::fromLocalFile(QString("%1/%2").arg(m_strFolder).arg(m_files.at(m_nCurrent)));
    }
    return QUrl();
}

QUrl DirectoryTraverse::prev()
{
    int count = m_files.size();
    if(m_nCurrent >= 0 && count)
    {
        if( --m_nCurrent < 0)
        {
            m_nCurrent = count - 1;
        }
        return QUrl::fromLocalFile(QString("%1/%2").arg(m_strFolder).arg(m_files.at(m_nCurrent)));
    }
    return QUrl();
}
