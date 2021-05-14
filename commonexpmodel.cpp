#include "commonexpmodel.h"
#include <QDebug>
#include <stdio.h>

commonExpModel::commonExpModel(QObject *parent):QAbstractListModel(parent){

}

void commonExpModel::addItem(const myCommonExpenses &item){
    beginInsertRows(QModelIndex(),rowCount(),rowCount());
    m_items << item;
    endInsertRows();
}


void commonExpModel::removeItem(int index){
    beginRemoveRows(QModelIndex(),index,index);
    m_items.removeAt(index);
    endRemoveRows();
}

string commonExpModel::getCost(int index){
    return m_items.at(index).cost().toStdString();
}
string commonExpModel::getTitle(int index){
    return m_items.at(index).title().toStdString();
}
string commonExpModel::getCategory(int index){
    return m_items.at(index).category().toStdString();
}
string commonExpModel::getItem(int index){
    string role1=getTitle(index);
    string role2=getCost(index);
    string role3=getCategory(index);
    return role1+"@"+role2+"#"+role3;
}

int commonExpModel::rowCount(const QModelIndex &parent) const{
    Q_UNUSED (parent);
    return m_items.count();
}

QVariant commonExpModel::data(const QModelIndex &index, int role) const{
    if (index.row() < 0 || index.row() >= m_items.count())
        return QVariant();
    const myCommonExpenses &item = m_items[index.row()];
    if (role == TitleRole)
        return item.title();
    else if (role==CostRole)
        return item.cost();
    return QVariant();
}

QHash<int, QByteArray> commonExpModel::roleNames() const{
    QHash<int,QByteArray> roles;
    roles[CategoryRole]="category";
    roles[TitleRole] = "title";
    roles[CostRole] = "cost";
    return roles;
}
