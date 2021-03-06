#include <QDebug>
#include <QDir>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSqlDatabase>
#include <QSqlError>
#include <QStandardPaths>

#include "sqleventmodel.h"

static void connectToDatabase() {
  QSqlDatabase database = QSqlDatabase::database();
  if (!database.isValid()) {
    database = QSqlDatabase::addDatabase("QSQLITE");
    if (!database.isValid())
      qFatal("Cannot add database: %s",
             qPrintable(database.lastError().text()));
  }

  const QDir writeDir =
      QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
  if (!writeDir.mkpath("."))
    qFatal("Failed to create writable directory at %s",
           qPrintable(writeDir.absolutePath()));

  // Ensure that we have a writable location on all devices.
  const QString fileName = writeDir.absolutePath() + "/event-manager.sqlite3";
  qDebug() << fileName;
  // When using the SQLite driver, open() will create the SQLite database if it
  // doesn't exist.
  database.setDatabaseName(fileName);
  if (!database.open()) {
    qFatal("Cannot open database: %s", qPrintable(database.lastError().text()));
    QFile::remove(fileName);
  }
}

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);

  qmlRegisterType<SqlEventModel>("io.qt.example.eventsmanager", 1, 0,
                                 "SqlEventModel");
  connectToDatabase();

  QQmlApplicationEngine engine;
  SqlEventModel myDb;
  engine.rootContext()->setContextProperty("myDb", &myDb);
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  if (engine.rootObjects().isEmpty())
    return -1;

  return app.exec();
}
