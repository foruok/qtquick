#ifndef NETWORKIMAGEMODEL_H
#define NETWORKIMAGEMODEL_H

#include <QAbstractListModel>
class ImageModelPrivate;
class ImageModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString keyword READ keyword WRITE setKeyword)
public:
    friend class ImageModelPrivate;
    ImageModel(QObject *parent = 0);
    ~ImageModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    QString keyword() const;
    void setKeyword(const QString& keyword);

    Q_INVOKABLE QString errorString() const;
    Q_INVOKABLE bool hasError() const;

    Q_INVOKABLE void loadMore();

private:
    ImageModelPrivate *m_dptr;
};

#endif // NETWORKIMAGEMODEL_H
