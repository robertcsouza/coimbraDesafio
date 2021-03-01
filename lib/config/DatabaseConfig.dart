import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:roberto_desafio_coimbra_app/Model/Status.dart';
import 'package:roberto_desafio_coimbra_app/Model/TipoContrato.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  static DatabaseConfig _databaseConfig;
  static Database _database;

// singleton database

  DatabaseConfig._createInstace();

  factory DatabaseConfig() {
    if (_databaseConfig == null) {
      _databaseConfig = DatabaseConfig._createInstace();
    }

    return _databaseConfig;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await inicializaDB();
    }
    return _database;
  }

  Future<Database> inicializaDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'desafioCoimbra.bd';

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print('banco de dados criado');
      },
    );

    return db;
  }

  createTables({Database db, int verson, String sql}) async {
    await db.execute(sql).then((value) => {print('tabela criada')});
  }

  drop({String table}) async {
    _database = await _databaseConfig.database;
    _database.execute("DROP TABLE $table").then((value) {
      // EasyLoading.showSuccess('executado com sucesso');
    });
  }

  fillTipo() async {
    _database = await _databaseConfig.database;

    var tipos = ['emprestimo', 'arrendamento', 'seguro', 'locacao'];

    for (var i = 0; i < tipos.length; i++) {
      TipoContrato tipo = TipoContrato(tipo: tipos[i]);
      _database.insert('tipoContrato', tipo.toMap());
    }
  }

  fillStatus() async {
    _database = await _databaseConfig.database;

    var stat = ['edicao', 'ativo', 'cancelado'];

    for (var i = 0; i < stat.length; i++) {
      Status status = Status(status: stat[i]);
      _database.insert('status', status.toMap());
    }
  }

  describeTable({String table}) async {
    print(await _database.rawQuery('PRAGMA table_info($table)'));
  }
}
