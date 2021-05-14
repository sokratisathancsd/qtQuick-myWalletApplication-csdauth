#include "BackEnd.h"
#include <QFile>
#include <QTextStream>
#include <iostream>
#include <string>
#include <stdio.h>
#include <QDebug>
#include <QStandardPaths>
#include <QQuickView>
#include <QQuickView>
#include <QQmlContext>
#include <QQmlComponent>
#include <QUrl>
#include <QQuickItem>
#include <QObjectList>
#include <QQmlApplicationEngine>
#include <QModelIndex>
#include <fstream>
#include <QProcess>

using namespace std;

BackEnd::BackEnd(QObject *parent) : QObject(parent)
{

}
void BackEnd::writeCategory(QString category,double cost){
    QFile file(QStandardPaths::DesktopLocation+"chart.txt");
       if (!file.open(QIODevice::WriteOnly | QIODevice::Append )){
           qDebug()<<"COULD NOT WRITE";
           return;
       }
       QTextStream stream( &file );
       stream <<category<<"@"<<cost<<endl;
       file.close();
}
double BackEnd::returnAllChartLines(){
    QFile file(QStandardPaths::DesktopLocation+"chart.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){

    }
    double count=0;
    while(!file.atEnd()){
        QString templine=file.readLine();
        string line=templine.toStdString();
        int pos=line.find("@");
        string tempcost=line.substr(pos+1,line.length()-2);
        double cost = std::atof(tempcost.c_str());
        count+=cost;
    }
    qDebug()<<count;
    return count;
}
double BackEnd::dataChart(QString word){
    qDebug()<<word;
    QString tword=word+"\n";
    QFile file(QStandardPaths::DesktopLocation+"chart.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
    return 0;}
    double count=0;
       while (!file.atEnd()) {
            QString templine = file.readLine();
            string temp2line=templine.toStdString();
            int pos=temp2line.find("@");
            QString temp3line=QString::fromStdString(temp2line.substr(0,pos));
            QString line=temp3line+"\n";
            if(!tword.compare(line)){
                string tempcost=temp2line.substr(pos+1,line.length()-2);
                double cost=std::atof(tempcost.c_str());
                //qDebug()<<"COST"<<cost;
                count+=cost;
            }
       }

       file.close();
       qDebug()<<count;
       return count;
}
void BackEnd::addItem(QString title, QString cost,QString category){
    qDebug()<<"MPIKE";
    QString newLine = title + "@" + cost + "#" + category;
    QFile file(QStandardPaths::DesktopLocation+"commonExpenses.txt");
       if (!file.open(QIODevice::WriteOnly | QIODevice::Append )){
           qDebug()<<"COULD NOT WRITE";
           return;
       }
       QTextStream stream( &file );
       stream <<newLine<<endl;
       file.close();


}
/*void BackEnd:: readBalance(){
    QFile file(QStandardPaths::DesktopLocation+"balance.txt");
       if (!file.open(QIODevice::ReadOnly | QIODevice::Text )){
           qDebug()<<"COULD NOT READ";
           return;
       }
       while (!file.atEnd()) {
            QString line = file.readLine();

       }
       file.close();

}*/
double BackEnd:: removeBalance(QString aBalance, double balance){
    //balance=getBalance();
    double myBalance = balance;
    myBalance -= aBalance.toDouble();
    return myBalance;

}
void BackEnd:: addBalance(QString aBalance){

        balance = getBalance();
        double myBalance = aBalance.toDouble() + balance;
        writeBalance(myBalance);

}

void BackEnd::writeBalance(double balance){
    QString aBalance = QString::number(balance);

    QFile file(QStandardPaths::DesktopLocation+"balance.txt");
       if (!file.open(QIODevice::WriteOnly | QIODevice::Text )){
           qDebug()<<"COULD NOT WRITE";
           return;
       }
       qDebug()<<aBalance;
       QTextStream stream( &file );
       stream <<aBalance ;
       file.close();
}
QString BackEnd::getBalanceQML(){
    QString balanceQML;
    QFile file(QStandardPaths::DesktopLocation+"balance.txt");
       if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
           return 0;
       while (!file.atEnd()) {
            balanceQML = file.readLine();

       }
       file.close();
       return balanceQML;
}
double BackEnd::getBalance(){
    QFile file(QStandardPaths::DesktopLocation+"balance.txt");
       if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
           return 0;
       while (!file.atEnd()) {
            balance = file.readLine().toDouble();
            qDebug()<<balance;
       }
       file.close();
       return balance;
}

void BackEnd::addToHistory(QString itemsForHistory){
    qDebug()<<itemsForHistory;
    QFile file(QStandardPaths::DesktopLocation+"history.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Append )){
           qDebug()<<"COULD NOT READ//FILE NOT EXIST";
           std::ofstream outfile(QStandardPaths::DesktopLocation+"history.txt"); //create file if not exists
    }
    QTextStream stream( &file );
    stream<<itemsForHistory;
    file.close();
    /*int pos1 = line.find("@");
    string title=line.substr(0,pos1);
    int pos2 = pos1+line.substr(pos1+1).find("@");
    string cost=line.substr(pos1+1,pos2-1);
    stream<<QString::fromStdString(title+cost);*/
}
int BackEnd::historyLines(){
    QFile file(QStandardPaths::DesktopLocation+"history.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
    return 0;}
    int count=0;
    while (!file.atEnd()) {
         QString line = file.readLine();
         count++;
    }
    qDebug()<<count;
    file.close();
    return count;
}
QString BackEnd::getDate(int index){
    QFile file(QStandardPaths::DesktopLocation+"history.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
    return 0;}
    QString line;
    while (!file.atEnd()) {
        for(int i=0;i<=index;i++){
         line = file.readLine();
        }
        int pos=line.toStdString().find("#");
        qDebug()<<QString::fromStdString(line.toStdString().substr(0,pos));
        return QString::fromStdString(line.toStdString().substr(0,pos));
    }
    file.close();
    return "fail";

}
QString BackEnd::getDateData(QString aDate){
    QString dateData="";
    QFile file(QStandardPaths::DesktopLocation+"history.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        return "fail";
    }
    QString line;
    while(!file.atEnd()){
        line=file.readLine();
        string templine=line.toStdString();
        int pos=templine.find("#");
        string testline=templine.substr(0,pos);
        if(!aDate.compare(QString::fromStdString(testline))){
            templine.erase(0,pos+1);
            qDebug()<<QString::fromStdString(templine);
            std::replace( templine.begin(), templine.end(), '@', ' '); // replace all '@' to ' '
            std::replace( templine.begin(), templine.end(), '$', '\n'); // replace all '$' to 'endl'
            if(templine.compare("\n")){
            dateData=dateData+QString::fromStdString(templine);
            }
        }
    }
    file.close();
    qDebug()<<dateData;
    return dateData;
}
void BackEnd::deleteAll(){
    remove(QStandardPaths::DesktopLocation+"chart.txt");
    remove(QStandardPaths::DesktopLocation+"history.txt");
    remove(QStandardPaths::DesktopLocation+"commonExpenses.txt");
    remove(QStandardPaths::DesktopLocation+"balance.txt");

    // restart: trexei mono se windows OXI se kinito
    qApp->quit();
    QProcess::startDetached(qApp->arguments()[0], qApp->arguments());
}
