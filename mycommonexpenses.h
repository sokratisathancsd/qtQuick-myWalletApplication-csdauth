#ifndef MYCOMMONEXPENSES_H
#define MYCOMMONEXPENSES_H
#include <QObject>
#include <QQmlApplicationEngine>


class myCommonExpenses
{
public:
    myCommonExpenses(const QString &title, const QString &cost, const QString &category);
    QString title() const;
    void setTitle(const QString &title);
    QString cost() const;
    void setCost(const QString &cost);
    QString category() const;
    void setCategory(const QString &category);
private:
    QString m_title;
    QString m_cost;
    QString m_category;
};

#endif // MYCOMMONEXPENSES_H
