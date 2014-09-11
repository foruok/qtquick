#include "dynamicModel.h"
#include <QDebug>

class DynamicListModelPrivate
{
public:
    DynamicListModelPrivate(DynamicListModel *model)
        : m_model(model), m_start(0), m_end(20)
        , m_total(100), m_pageSize(20)
    {
        m_roleNames.insert(Qt::UserRole, "content");
    }

    void pageDown()
    {
        if(m_end < m_total)
        {
            m_start += m_pageSize;
            m_end += m_pageSize;
            if(m_end > m_total)
            {
                m_end = m_total;
                m_start = m_end - m_pageSize;
            }
        }
    }

    void pageUp()
    {
        if(m_start > 0)
        {
            m_start -= m_pageSize;
            if(m_start < 0) m_start = 0;
            m_end = m_start + m_pageSize;
        }
    }

    void adjustPageRange()
    {
        if(m_end - m_start < m_pageSize)
        {
            m_end = m_start + m_pageSize;
            if(m_end > m_total)
            {
                m_end = m_total;
                m_start = m_end - m_pageSize;
            }
        }
    }

    DynamicListModel *m_model;
    int m_start;
    int m_end;
    int m_total;
    int m_pageSize;
    QHash<int, QByteArray> m_roleNames;
};

DynamicListModel::DynamicListModel(QObject *parent)
    : QAbstractListModel(parent),
    m_dptr(new DynamicListModelPrivate(this))
{

}

DynamicListModel::~DynamicListModel()
{
    delete m_dptr;
}

int DynamicListModel::rowCount(const QModelIndex &parent) const
{
    return m_dptr->m_end - m_dptr->m_start;
}

QVariant DynamicListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    //qDebug() << "index.row - " << row << " start - " << m_dptr->m_start;
    return QString::number(row + m_dptr->m_start);
}

QHash<int, QByteArray> DynamicListModel::roleNames() const
{
    return m_dptr->m_roleNames;
}

void DynamicListModel::loadMore(bool forward)
{
    beginResetModel();
    if(forward)m_dptr->pageDown();
    else m_dptr->pageUp();
    endResetModel();
}

int DynamicListModel::pageSize()
{
    return m_dptr->m_pageSize;
}

void DynamicListModel::setPageSize(int size)
{
    m_dptr->m_pageSize = size;
    m_dptr->adjustPageRange();
    emit pageSizeChanged(size);
}

int DynamicListModel::total()
{
   return m_dptr->m_total;
}

void DynamicListModel::setTotal(int total)
{
    m_dptr->m_total = total;
    m_dptr->adjustPageRange();
    emit totalChanged(total);
}
