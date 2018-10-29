#include "sqleventmodel.h"

#include <QDebug>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QSqlRecord>
#include <QDate>
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

    query.exec("INSERT INTO Events VALUES(0, 'Milano Rock', '08-05-2019', 'Milano', '90.00', '120000', 'Concert', 'Metallica', 'Metal', NULL, NULL, NULL)");
    query.exec("INSERT INTO Events VALUES(1, 'Romeo e Giulietta', '08-05-2019', 'Parma', '50.00', '1200', 'Ballet', NULL, NULL, 'Bolle', '50', NULL)");
    query.exec("INSERT INTO Events VALUES(2, 'Colorado', '08-05-2019', 'Roma', '25.00', '1200', 'Show', NULL, NULL, NULL, NULL, 'Ettore')");
}

SqlEventModel::SqlEventModel(QObject *parent) :
    QSqlTableModel(parent)
{
    createTable();

    QSqlQuery query;
    if (!query.exec("SELECT * FROM Events")) {
        qFatal("Events SELECT query failed: %s", qPrintable(query.lastError().text()));
    }

    setQuery(query);
    if (lastError().isValid()) {
        qFatal("Cannot set query on SqlEventModel: %s", qPrintable(lastError().text()));
    }

    qDebug() << "Database created.";
}


QVariant SqlEventModel::data(const QModelIndex &index, int role) const {
    if (role < Qt::UserRole)
            return QSqlTableModel::data(index, role);

        const QSqlRecord sqlRecord = record(index.row());
        return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> SqlEventModel::roleNames() const {
    QHash<int, QByteArray> names;
    names[Qt::UserRole] = "code";
    names[Qt::UserRole + 1] = "name";
    names[Qt::UserRole + 2] = "date";
    names[Qt::UserRole + 3] = "place";
    names[Qt::UserRole + 4] = "price";
    names[Qt::UserRole + 5] = "ticket";
    names[Qt::UserRole + 6] = "type_event";
    names[Qt::UserRole + 7] = "artist";
    names[Qt::UserRole + 8] = "genre";
    names[Qt::UserRole + 9] = "first_dancer";
    names[Qt::UserRole + 10] = "number_dancers";
    names[Qt::UserRole + 11] = "director";
   return names;
}

void SqlEventModel::saveEvent(const QString &name, const QString &date, const QString &place,
               const QString &price, const QString &ticket, const QString &type_event,
               const QString &artist, const QString &genre, const QString &first_dancer,
                              const QString &number_dancers, const QString &director) {

    QSqlRecord newRecord = record();
    newRecord.setValue("name", name);
    newRecord.setValue("date", date);
    newRecord.setValue("place", place);
    newRecord.setValue("price", price);
    newRecord.setValue("ticket", ticket);
    newRecord.setValue("type_event", type_event);
    newRecord.setValue("artist", artist);
    newRecord.setValue("genre", genre);
    newRecord.setValue("first_dancer", first_dancer);
    newRecord.setValue("number_dancers", number_dancers);
    newRecord.setValue("director", director);

    if (!insertRecord(rowCount(), newRecord)) {
            qWarning() << "Failed to send message:" << lastError().text();
            return;
        }

}


