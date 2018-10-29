#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlDatabase>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>
#include <QSqlError>


#include "sqleventmodel.h"

static void connectToDatabase()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("events-manager");
    if(db.open()) {
        qDebug() << "Connection open";
        db = QSqlDatabase::database(); // in this way we get the pointer to that database connection

        if(!db.isValid()) {
            qDebug() << "Db error pointer connection: " << db.lastError();
        }
    } else {
        qFatal("Cannot open database: %s", qPrintable(db.lastError().text()));
        QFile::remove("events-manager");
    }
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<SqlEventModel>("io.qt.example.eventsmanager", 1, 0, "SqlEventModel");
    connectToDatabase();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
