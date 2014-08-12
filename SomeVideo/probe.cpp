#include "probe.h"
#include "probe_p.h"

ProbeVideo::ProbeVideo(QObject *parent)
    : QObject(parent), m_priv(new ProbeVideoPrivate(this))
{

}

ProbeVideo::~ProbeVideo()
{

}

void ProbeVideo::startProbe(QString pageUrl)
{
    m_priv->probe(pageUrl);
}

void ProbeVideo::abort()
{
    m_priv->abort();
}

QList<QUrl> ProbeVideo::fileUrls()
{
    return m_priv->m_urls;
}
