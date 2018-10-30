#ifndef SQLEVENTMODEL_H
#define SQLEVENTMODEL_H

#include <QFile>
#include <QtSql/QSqlTableModel>

class SqlEventModel : public QSqlTableModel
{
    Q_OBJECT
public:
    SqlEventModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addEvent( const QString &name, const QString &date, const QString &place,
                               const QString &price, const QString &ticket, const QString &type_event,
                               const QString &artist = "", const QString &genre = "", const QString &first_dancer = "",
                               const QString &number_dancers = "", const QString &director = "");

    Q_INVOKABLE void saveEvent(const int &code, const QString &name, const QString &date, const QString &place,
                               const QString &price, const QString &ticket, const QString &type_event,
                               const QString &artist = "", const QString &genre = "", const QString &first_dancer = "",
                               const QString &number_dancers = "", const QString &director = "");

               void updateEvent(const int &code, const QString &name, const QString &date, const QString &place,
                               const QString &price, const QString &ticket, const QString &type_event,
                               const QString &artist = "", const QString &genre = "", const QString &first_dancer = "",
                               const QString &number_dancers = "", const QString &director = "");

};

#endif // SQLEVENTMODEL_H
