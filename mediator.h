#ifndef MEDIATOR_H
#define MEDIATOR_H
#include <QObject>
#include <commonexpmodel.h>

class mediator: public QObject{
    commonExpModel *_commonExpModel;
    Q_OBJECT
    Q_PROPERTY(commonExpModel* myModel READ myModel WRITE setCommonExpModel NOTIFY commonExpModelChanged)
public:
    explicit mediator(QObject *parent=0);
    void setCommonExpModel(commonExpModel *m){
        _commonExpModel = m ;
        emit commonExpModelChanged();
    }
    commonExpModel* myModel(){
        return _commonExpModel;
    }
signals:
    void commonExpModelChanged();
public slots:
    void insertItem(QString itemName,QString itemCost,QString itemCategory);
    void removeItem(int index);
    double getCost(int index);
    QString getTitle(int index);
    QString getCategory(int index);
    //QObject getItemAsQObject(int index);
};

#endif // MEDIATOR_H
