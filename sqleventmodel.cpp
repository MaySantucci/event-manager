#include "sqleventmodel.h"

#include <QDebug>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>

static void createTable()
{
    if (QSqlDatabase::database().tables().contains(QStringLiteral("Events"))) {
        // The table already exists; we don't need to do anything.
        return;
    }

    QSqlQuery query;
    if (!query.exec(
        "CREATE TABLE IF NOT EXISTS 'Events' ("
        "   'code' INTEGER AUTO_INCREMENT NOT NULL DEFAULT 0,"
        "   'name' TEXT NOT NULL,"
        "   'date' DATE NOT NULL,"
        "   'place' TEXT NOT NULL,"
        "   'price' TEXT NOT NULL,"
        "   'ticket' TEXT NOT NULL,"
        "   'type_event' TEXT NOT NULL,"
        "   'artist' TEXT,"
        "   'genre' TEXT,"
        "   'first_dancer' TEXT,"
        "   'number_dancers' TEXT,"
        "   'director' TEXT,"

        "   PRIMARY KEY(code)"
        ")")) {
        qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
    }

    query.exec("INSERT INTO Events VALUES('Milano Rock', '2019-05-8', 'Milano', '90.00', '120000', 'Concert', 'Metallica', 'Metal', NULL, NULL, NULL)");
    query.exec("INSERT INTO Events VALUES('Romeo e Giulietta', '2019-05-8', 'Parma', '50.00', '1200', 'Ballet', NULL, NULL, 'Bolle', '50', NULL)");
    query.exec("INSERT INTO Events VALUES('Colorado', '2019-05-8', 'Roma', '25.00', '1200', 'Show', NULL, NULL, NULL, NULL, 'Ettore')");
}

SqlEventModel::SqlEventModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    createTable();

    QSqlQuery query;
    if (!query.exec("SELECT * FROM Events"))
        qFatal("Events SELECT query failed: %s", qPrintable(query.lastError().text()));

    setQuery(query);
    if (lastError().isValid())
        qFatal("Cannot set query on SqlEventModel: %s", qPrintable(lastError().text()));
}
