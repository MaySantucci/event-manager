#include "sqleventmodel.h"

#include <QDate>
#include <QDebug>
#include <QSqlRecord>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>

static void createTable() {
  if (QSqlDatabase::database().tables().contains(QStringLiteral("Events"))) {
    // The table already exists; we don't need to do anything.
    return;
  }

  QSqlQuery query;
  if (!query.exec("CREATE TABLE IF NOT EXISTS 'Events' ("
                  "   'code' INTEGER PRIMARY KEY,"
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
                  "   'director' TEXT"
                  ")")) {
    qFatal("Failed to query database: %s",
           qPrintable(query.lastError().text()));
  }

  qDebug() << "Database created.";
}

SqlEventModel::SqlEventModel(QObject *parent) : QSqlTableModel(parent) {
  createTable();
  setTable("Events");
  setEditStrategy(QSqlTableModel::OnManualSubmit);
  select();
}

QVariant SqlEventModel::data(const QModelIndex &index, int role) const {
  if (role < Qt::UserRole) {
    return QSqlTableModel::data(index, role);
  }

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

void SqlEventModel::addEvent(const QString &name, const QString &date,
                             const QString &place, const QString &price,
                             const QString &ticket, const QString &type_event,
                             const QString &artist, const QString &genre,
                             const QString &first_dancer,
                             const QString &number_dancers,
                             const QString &director) {
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

  if (!insertRecord(-1, newRecord)) {
    qWarning() << "Failed to save event:" << lastError().text();
    return;
  }
  submitAll();
}

void SqlEventModel::updateEvent(int index, const int &code, const QString &name,
                                const QString &date, const QString &place,
                                const QString &price, const QString &ticket,
                                const QString &type_event,
                                const QString &artist, const QString &genre,
                                const QString &first_dancer,
                                const QString &number_dancers,
                                const QString &director) {

  QSqlQuery qry;
  qry.prepare("UPDATE Events SET name = :name, date = :date, place = :place,"
              "price = :price, ticket = :ticket, type_event = :type_event, "
              "artist = :artist, genre = :genre, first_dancer = :first_dancer, "
              "number_dancers = :number_dancers, director =:director WHERE "
              "code =:code");

  qry.bindValue(":code", code);
  qry.bindValue(":name", name);
  qry.bindValue(":date", date);
  qry.bindValue(":place", place);
  qry.bindValue(":price", price);
  qry.bindValue(":ticket", ticket);
  qry.bindValue(":type_event", type_event);
  qry.bindValue(":artist", artist);
  qry.bindValue(":genre", genre);
  qry.bindValue(":first_dancer", first_dancer);
  qry.bindValue(":number_dancers", number_dancers);
  qry.bindValue(":director", director);

  QModelIndex i = createIndex(index, 0);
  QVector<int> value;

  if (qry.exec()) {
    qDebug() << "Query done.";
    dataChanged(i, i, value);
  } else {
    qDebug() << "Error: " << lastError().text();
  }
  submitAll();
}

void SqlEventModel::saveEvent(int index, const int &code, const QString &name,
                              const QString &date, const QString &place,
                              const QString &price, const QString &ticket,
                              const QString &type_event, const QString &artist,
                              const QString &genre, const QString &first_dancer,
                              const QString &number_dancers,
                              const QString &director) {

  // take code and check if it is in db. if exists set/replace the values.
  if (code == NULL) {
    addEvent(name, date, place, price, ticket, type_event, artist, genre,
             first_dancer, number_dancers, director);
  } else {
    updateEvent(index, code, name, date, place, price, ticket, type_event,
                artist, genre, first_dancer, number_dancers, director);
  }
}
