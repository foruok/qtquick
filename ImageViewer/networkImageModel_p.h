#ifndef NETWORKIMAGEMODEL_P_H
#define NETWORKIMAGEMODEL_P_H
//http://image.baidu.com/i?tn=resultjsonavstar&ie=utf-8&word=高圆圆&pn=0&rn=60
//http://image.baidu.com/i?tn=resultjsonavstar&ie=utf-8&word=%E9%AB%98%E5%9C%86%E5%9C%86&pn=0&rn=60
//
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QList>

class ImageModel;
class ImageModelPrivate : public QObject
{
    Q_OBJECT
public:
    ImageModelPrivate(ImageModel *model);
    ~ImageModelPrivate();

    void search(const QString & keyword);
    QStringList m_urls;
    QString m_keyword; //encoded
    QHash<int, QByteArray> m_roleNames;

protected slots:
    void onSearchFinished();
    void onSearchError(QNetworkReply::NetworkError code);

protected:
    void parseResult(const QByteArray &data);
    void timerEvent(QTimerEvent *e);

private:
    ImageModel * m_model;
    QNetworkAccessManager m_nam;
    QNetworkReply * m_reply;
    int m_timeoutTimerId;

};

#endif // NETWORKIMAGEMODEL_P_H
