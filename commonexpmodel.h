#ifndef COMMONEXPMODEL_H
#define COMMONEXPMODEL_H
#include <QObject>
#include <QAbstractListModel>
#include <mycommonexpenses.h>
#include <string>
#include <iostream>
#include <string.h>
#include <fstream>
#include <BackEnd.h>


class commonExpModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ItemRoles{
        TitleRole=Qt::UserRole+1,
        CategoryRole,
        CostRole
    };
    commonExpModel(QObject *parent=0);
    string getCost(int index);
    string getTitle(int index);
    string getItem(int index);
    string getCategory(int index);
    void addItem(const myCommonExpenses &item);
    void removeItem(int index);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role=Qt::DisplayRole) const;
protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<myCommonExpenses> m_items;

};

#endif // COMMONEXPMODEL_H
