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

  qDebug() << newRecord;

  if (!insertRecord(-1, newRecord)) {
    qWarning() << "Failed to save event:" << lastError().text();
    return;
  }
  submitAll();
}

void SqlEventModel::updateEvent(const int &code, const QString &name,
                                const QString &date, const QString &place,
                                const QString &price, const QString &ticket,
                                const QString &type_event,
                                const QString &artist, const QString &genre,
                                const QString &first_dancer,
                                const QString &number_dancers,
                                const QString &director) {

  QString codeString = QString::number(code);

  QSqlQuery qry("SELECT * FROM Events WHERE code =" + codeString);
  QSqlRecord upRecord = qry.record();
  if (upRecord.isEmpty()) {
    qDebug() << "no record found.";
  } else {
    qDebug() << "record found.";
    QSqlQuery updateQry;
    updateQry.prepare(
        "UPDATE Events SET name = :name, date = :date, place = :place,"
        "price = :price, ticket = :ticket, type_event = :type_event, artist = "
        ":artist, "
        "genre = :genre, first_dancer = :first_dancer, number_dancers = "
        ":number_dancers, "
        "director = :director WHERE code =" +
        codeString);

    updateQry.bindValue(":name", name);
    updateQry.bindValue(":date", date);
    updateQry.bindValue(":place", place);
    updateQry.bindValue(":price", price);
    updateQry.bindValue(":ticket", ticket);
    updateQry.bindValue(":type_event", type_event);
    updateQry.bindValue(":artist", artist);
    updateQry.bindValue(":genre", genre);
    updateQry.bindValue(":first_dancer", first_dancer);
    updateQry.bindValue(":number_dancers", number_dancers);
    updateQry.bindValue(":director", director);

    if (!updateQry.exec()) {
      qDebug() << updateQry.lastError().text();
    } else {
      qDebug() << "Updated!";
    }
  }
}

void SqlEventModel::saveEvent(const int &code, const QString &name,
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
    updateEvent(code, name, date, place, price, ticket, type_event, artist,
                genre, first_dancer, number_dancers, director);
  }
}
