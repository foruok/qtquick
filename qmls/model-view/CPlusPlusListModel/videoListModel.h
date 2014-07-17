#ifndef VIDEOLISTMODEL_H
#define VIDEOLISTMODEL_H
#include <QAbstractListModel>

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

private:
    VideoListModelPrivate *m_dptr;
};

#endif // VIDEOLISTMODEL_H
