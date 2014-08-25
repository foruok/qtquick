#ifndef VIDEOLISTMODEL_H
#define VIDEOLISTMODEL_H
#include <QAbstractListModel>

class VideoDetail: public QObject
{
    Q_OBJECT
public:
    VideoDetail(QObject * parent = 0)
        : QObject(parent)
    {}
    ~VideoDetail(){}
    Q_INVOKABLE QString name(){ return m_name; }
    Q_INVOKABLE QString date(){ return m_date; }
    Q_INVOKABLE QString img(){ return m_poster; }
    Q_INVOKABLE QString directorTag(){ return m_directorTag; }
    Q_INVOKABLE QString director(){ return m_director; }
    Q_INVOKABLE QString actorTag(){ return m_actorTag; }
    Q_INVOKABLE QString actor(){ return m_actor; }
    Q_INVOKABLE QString ratingTag(){ return m_ratingTag; }
    Q_INVOKABLE QString rating(){ return m_rating; }
    Q_INVOKABLE QString descTag(){ return m_descTag; }
    Q_INVOKABLE QString desc(){ return m_desc; }
    Q_INVOKABLE QString pageUrl(){ return m_pageUrl; }
    Q_INVOKABLE QString playtimesTag(){ return m_playtimesTag; }
    Q_INVOKABLE uint playtimes(){ return m_playtimes; }

public:
    QString m_name;
    QString m_date;
    QString m_poster;
    QString m_directorTag;
    QString m_director;
    QString m_actorTag;
    QString m_actor;
    QString m_ratingTag;
    QString m_rating;
    QString m_descTag;
    QString m_desc;
    QString m_pageUrl;
    QString m_playtimesTag;
    uint m_playtimes;
};

class VideoListModelPrivate;
class VideoListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource)

public:
    VideoListModel(QObject *parent = 0);
    ~VideoListModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    QString source() const;
    void setSource(const QString& filePath);

    Q_INVOKABLE QString errorString() const;
    Q_INVOKABLE bool hasError() const;

    Q_INVOKABLE void reload();
    Q_INVOKABLE void remove(int index);

    VideoDetail * currentVideo();
    Q_INVOKABLE void updateCurrentVideo(int row);
    Q_INVOKABLE void search(QString text);

private:
    VideoListModelPrivate *m_dptr;
};

#endif // VIDEOLISTMODEL_H
