#include "mycommonexpenses.h"

myCommonExpenses::myCommonExpenses(const QString &title,const  QString &cost, const QString &category)
    : m_title(title), m_cost(cost), m_category(category){

}
QString myCommonExpenses::title() const{
    return m_title;
}

void myCommonExpenses::setTitle(const QString &title){
    if(title != m_title){
        m_title=title;
    }
}

QString myCommonExpenses::cost() const{
    return m_cost;
}

void myCommonExpenses::setCost(const QString &cost){
    if(cost != m_cost){
        m_cost=cost;
    }
}
QString myCommonExpenses::category()const{
    return m_category;
}

void myCommonExpenses::setCategory(const QString &category){
    if(category != m_category){
        m_category=category;
    }
}



