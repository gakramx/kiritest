#ifndef COLORSCHEMEMANAGER_H
#define COLORSCHEMEMANAGER_H

#include <QAbstractListModel>
#include <KColorSchemeManager>

class colorschememanager : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit colorschememanager(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void activateScheme(int index);

private:
    KColorSchemeManager *m_schemeManager;
};

#endif // COLORSCHEMEMANAGER_H
