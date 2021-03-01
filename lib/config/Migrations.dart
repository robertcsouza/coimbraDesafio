
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:roberto_desafio_coimbra_app/config/Tables.dart';
import 'package:sqflite/sqflite.dart';

class Migrations {
  Database db;
  DatabaseConfig config;

  Migrations() {
    config = DatabaseConfig();
  }

  inicializeDB() async {
    config.inicializaDB();
    db = await config.database;
    await config.drop(table: 'status');
    await config.drop(table: 'tipoContrato');
    await config.createTables(db: db, sql: STATUS, verson: 1);
    await config.createTables(db: db, sql: CONDICOES, verson: 1);
    await config.createTables(db: db, sql: TIPO, verson: 1);
    await config.createTables(db: db, sql: ENDERECO, verson: 1);
    await config.createTables(db: db, sql: CONTRATANTE, verson: 1);
    await config.createTables(db: db, sql: CONTRATADO, verson: 1);
    await config.createTables(db: db, sql: CONTRATO, verson: 1);

    await config.fillStatus();
    await config.fillTipo();
  }

  reconfigure() async {
    db = await config.database;

    print(await db.rawQuery('PRAGMA table_info(status)'));
    //inicializeDB();
  }
}
