#ifndef SQLEVENTMODEL_H
#define SQLEVENTMODEL_H

#include <QFile>
#include <QMetaEnum>
#include <QSqlRecord>
#include <QtSql/QSqlTableModel>

class SqlEventModel : public QSqlTableModel {
  Q_OBJECT
public:
  SqlEventModel(QObject *parent = 0);
  QVariant data(const QModelIndex &index, int role) const override;
  QHash<int, QByteArray> roleNames() const override;

  enum TypeEvent { Concert, Show, Ballet };

  Q_ENUM(TypeEvent)

  enum EventRole {
    CodeRole = Qt::UserRole,
    NameRole,
    DateRole,
    PlaceRole,
    PriceRole,
    TicketRole,
    TypeEventRole,
    ArtistRole,
    GenreRole,
    FirstDancerRole,
    NumberDancersRole,
    DirectorRole
  };

  Q_ENUM(EventRole)

  Q_INVOKABLE int addEvent(const QString &name, const QString &date,
                           const QString &place, const QString &price,
                           const QString &ticket, const TypeEvent &type_event,
                           const QString &artist, const QString &genre,
                           const QString &first_dancer,
                           const QString &number_dancers,
                           const QString &director);

  Q_INVOKABLE void updateEvent(int index, const int &code, const QString &name,
                               const QString &date, const QString &place,
                               const QString &price, const QString &ticket,
                               const TypeEvent &type_event,
                               const QString &artist, const QString &genre,
                               const QString &first_dancer,
                               const QString &number_dancers,
                               const QString &director);

  Q_INVOKABLE void removeEvent(int index);

  Q_INVOKABLE QString get(int index, int role);
};

#endif // SQLEVENTMODEL_H
