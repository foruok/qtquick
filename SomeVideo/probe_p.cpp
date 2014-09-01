#include "probe.h"
#include "probe_p.h"
#include <QXmlStreamReader>
#include <QXmlStreamAttributes>
#include <QDebug>

ProbeVideoPrivate::ProbeVideoPrivate(ProbeVideo *pv)
    : QObject(pv), m_pv(pv), m_nam(this), m_reply(0)
{

}

ProbeVideoPrivate::~ProbeVideoPrivate()
{

}

void ProbeVideoPrivate::probe(QString pageUrl)
{
    qDebug() << "ProbeVideoPrivate::probe - " << pageUrl;
    abort();
    m_urls.clear();
    //TODO: create flvxz.com url
    QByteArray baUrl = pageUrl.toLatin1();
    char *data = baUrl.data();
    data[5] = '#';
    data[6] = '#';
    QByteArray base64 = baUrl.toBase64();
    QString strUrl = QString("http://api.flvxz.com/url/%1").arg(base64.data());
    qDebug() << "base64 - " << strUrl;
    QUrl qurl(strUrl);
    QNetworkRequest req(qurl);
    m_reply = m_nam.get(req);
    connect(m_reply, SIGNAL(error(QNetworkReply::NetworkError)),
            this, SLOT(onEror(QNetworkReply::NetworkError)));
    connect(m_reply, SIGNAL(finished()), this, SLOT(onFinished()));
}

void ProbeVideoPrivate::abort()
{
    if(m_reply)
    {
        m_reply->disconnect(this);
        m_reply->abort();
        m_reply->deleteLater();
        m_reply = 0;
    }
}

void ProbeVideoPrivate::onEror(QNetworkReply::NetworkError code)
{
    qDebug() << "onError";
    m_reply->disconnect(this);
    m_reply->deleteLater();
    m_reply = 0;
}

void ProbeVideoPrivate::onFinished()
{
    qDebug() << "onFinished";
    int status = m_reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    if(status != 200)
    {
        emit m_pv->probeFinished(false);
        return;
    }

    //parse xml
    QByteArray data = m_reply->readAll();
    QXmlStreamReader reader(data);
    QStringRef elementName;
    while(!reader.atEnd())
    {
        reader.readNext();
        if(reader.isStartElement())
        {
            elementName = reader.name();
            if( elementName == "file")
            {
                QString m3u8Url;
                while(!reader.atEnd())
                {
                    reader.readNext();
                    elementName = reader.name();
                    if(elementName == "furl")
                    {
                        m3u8Url = reader.readElementText();
                        m_urls.append(m3u8Url);//暂时只取第一个地址
                        break;
                    }
                    /*
                    else if(elementName == "ftype")
                    {
                        QString type = reader.readElementText();
                        if(type == "m3u8")
                        {
                            qDebug() << m3u8Url;
                            m_urls.append(m3u8Url);
                        }
                        break;
                    }
                    */
                }
                break;
            }
        }
    }
    if(reader.hasError())
    {
    }

    emit m_pv->probeFinished(m_urls.size() > 0);

    m_reply->disconnect(this);
    m_reply->deleteLater();
    m_reply = 0;
}
