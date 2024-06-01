#include "colorschememanager.h"

colorschememanager::colorschememanager(QObject *parent)
    : QAbstractListModel{parent}
{
        m_schemeManager = new KColorSchemeManager(this);
}
int colorschememanager::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_schemeManager->model()->rowCount();
}

QVariant colorschememanager::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Qt::DisplayRole)
        return QVariant();

    return m_schemeManager->model()->data(index, role);
}

void colorschememanager::activateScheme(int index)
{
    qDebug()<<"WWWWWWWWWWWWWW";
    QModelIndex schemeIndex = m_schemeManager->model()->index(index, 0);
    m_schemeManager->activateScheme(schemeIndex);
}
