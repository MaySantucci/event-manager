#ifndef SQLEVENTMODEL_H
#define SQLEVENTMODEL_H

#include <QSqlQueryModel>

class SqlEventModel : public QSqlQueryModel {

public:
    SqlEventModel(QObject *parent = 0);

};

#endif // SQLEVENTMODEL_H
