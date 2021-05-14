#include <QFile>
#include <QStandardPaths>
#include <iostream>
#include <fstream>
#include <QDebug>
#include <QString>
#include "mediator.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <BackEnd.h>
#include <QString>
#include <QDebug>
#include <QObjectList>
#include <qqmlcontext.h>
#include <QFile>
#include <QStandardPaths>
#include <iostream>
#include <fstream>
#include <iostream>
#include <string>
#include <QModelIndex>
using namespace std;

mediator::mediator(QObject *parent): QObject(parent)
{
    _commonExpModel = new commonExpModel();
    QFile file(QStandardPaths::DesktopLocation+"commonExpenses.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text )){
           qDebug()<<"COULD NOT READ//FILE NOT EXIST";
           std::ofstream outfile(QStandardPaths::DesktopLocation+"commonExpenses.txt"); //create file if not exists
    }
    while (!file.atEnd()) {
            QString templine = file.readLine();
            string line=templine.toStdString();
            int pos=line.find("@");
            int pos2=line.find("#");
            int pos3=line.find("\n");
            string title=line.substr(0,pos);
            string cost=line.substr(pos+1,pos2-pos-1);
            string category=line.substr(pos2+1,pos3-pos2-1);
            qDebug()<<QString::fromStdString(title);
            qDebug()<<QString::fromStdString(cost);
            qDebug()<<QString::fromStdString(category);
            /*string line=templine.toStdString();
            int pos = line.find("@");
            string title=line.substr(0,pos);
            string tempcost=line.substr(pos+1,line.size());
            string cost = tempcost.substr(0,tempcost.size()-1);
            qDebug()<<QString::fromStdString(title);
            qDebug()<<QString::fromStdString(cost);*/
            insertItem(QString::fromStdString(title),QString::fromStdString(cost),QString::fromStdString(category));
    }
    file.close();

}

double mediator::getCost(int index){
    string strcost=_commonExpModel->getCost(index);
    return std::atof(strcost.c_str());
}
QString mediator::getTitle(int index){
    return QString::fromStdString(_commonExpModel->getTitle(index));
}
QString mediator::getCategory(int index){
    //qDebug()<<QString::fromStdString(_commonExpModel->getCategory(index));
    return QString::fromStdString(_commonExpModel->getCategory(index));

}
/*QObject mediator::getItemAsQOBject(int index){
    QObject item = new QObject();
    item.setProperty("title",getTitle(index));
    item.setProperty("cost",getCost(index));
    return item;
}*/

void mediator::removeItem(int index){
    string deleteLine= _commonExpModel->getItem(index);
    qDebug()<<QString::fromStdString(deleteLine);
   _commonExpModel->removeItem(index);
    commonExpModelChanged();

    //DELETE IT FROM FILE
    ifstream file;
    ofstream newfile;
    file.open (QStandardPaths::DesktopLocation+"commonExpenses.txt");
    newfile.open(QStandardPaths::DesktopLocation+"newcommonExpenses.txt");
    string line;

    while (getline(file,line))
    {
        if(line.compare(deleteLine)){
            qDebug()<<QString::fromStdString(line);
            newfile<<line<<endl;
        }
    }
    file.close();
    newfile.close();
    remove(QStandardPaths::DesktopLocation+"commonExpenses.txt");
    rename(QStandardPaths::DesktopLocation+"newcommonExpenses.txt",QStandardPaths::DesktopLocation+"commonExpenses.txt");

}
void mediator::insertItem(QString itemName, QString itemCost, QString itemCategory){
    qDebug()<<itemName+"@"+itemCost+"#"+itemCategory;
    _commonExpModel->addItem(myCommonExpenses(itemName,itemCost,itemCategory));
    commonExpModelChanged();
}
