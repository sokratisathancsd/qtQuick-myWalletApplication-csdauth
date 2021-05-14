#ifndef BACKEND_H
#define BACKEND_H
#include <QObject>
#include <string>
#include <QtWidgets/QApplication>
using namespace std;

class BackEnd : public QObject
{
    Q_OBJECT
public:
    explicit BackEnd(QObject *parent = nullptr);
    Q_INVOKABLE void addItem(QString title, QString cost,QString category);
    //Q_INVOKABLE void readBalance();
    Q_INVOKABLE void addBalance(QString aBalance);
    Q_INVOKABLE double removeBalance(QString aBalance, double balance);
    Q_INVOKABLE double getBalance();
    Q_INVOKABLE void writeBalance(double aBalance);
    Q_INVOKABLE QString getBalanceQML();
    Q_INVOKABLE void addToHistory(QString itemsForHistory);
    Q_INVOKABLE double dataChart(QString word);
    Q_INVOKABLE double returnAllChartLines();
    Q_INVOKABLE void writeCategory(QString category,double cost);
    Q_INVOKABLE int historyLines();
    Q_INVOKABLE QString getDate(int index);
    Q_INVOKABLE QString getDateData(QString aDate);
    Q_INVOKABLE void deleteAll();
private:
    double balance;

signals:

public slots:
};

#endif // BACKEND_H
