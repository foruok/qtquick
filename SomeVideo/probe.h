#ifndef PROBE_H
#define PROBE_H
#include <QObject>
#include <QList>
#include <QUrl>

class ProbeVideoPrivate;
class ProbeVideo: public QObject
{
    Q_OBJECT
public:
    ProbeVideo(QObject *parent = 0);
    ~ProbeVideo();

    Q_INVOKABLE void startProbe(QString pageUrl);
    Q_INVOKABLE void abort();
    Q_INVOKABLE QList<QUrl> fileUrls();

signals:
    void probeFinished(bool bSuccess);

private:
    ProbeVideoPrivate *m_priv;
};

#endif // PROBE_H
