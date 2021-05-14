#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <BackEnd.h>
#include <QString>
#include <QDebug>
#include <QObjectList>
#include <qqmlcontext.h>
#include <QFile>
#include <QStandardPaths>
#include <QGuiApplication>
#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <mycommonexpenses.h>
#include <mediator.h>
#include <QFont>
#include <QProcess>
#include <QDebug>

int main(int argc, char *argv[])
{
    /*#if defined(Q_OS_ANDROID) an to programma paei na treksei se android allazei to default font tis efarmogis, PROSOXI kai alles allages prepei na ginoun
        qputenv("QT_SCALE_FACTOR", "0.7");
        qDebug() << "OK" ;
    #else
        qDebug()<< "TEST";
    #endif*/

    //qputenv("QT_SCALE_FACTOR", "0.3");//allazei ta font tou qtableview
    qmlRegisterType<BackEnd>("BackEnd", 1, 0, "BackEnd" );
    QApplication app(argc, argv);
    mediator *m = new mediator();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("mediator",m);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

