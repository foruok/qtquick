#ifndef PROBE_P_H
#define PROBE_P_H
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QList>
#include <QUrl>

class ProbeVideo;
class ProbeVideoPrivate : public QObject
{
    Q_OBJECT
public:
    ProbeVideoPrivate(ProbeVideo *pv);
    ~ProbeVideoPrivate();

    void probe(QString pageUrl);
    void abort();

public:
    QList<QUrl> m_urls;

protected slots:
    void onEror(QNetworkReply::NetworkError code);
    void onFinished();

private:
    ProbeVideo *m_pv;
    QNetworkAccessManager m_nam;
    QNetworkReply *m_reply;
};

#endif // PROBE_P_H
