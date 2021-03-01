
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:roberto_desafio_coimbra_app/config/Tables.dart';
import 'package:sqflite/sqflite.dart';

class EnderecoDAO {
  DatabaseConfig config;
  Database db;
  EnderecoDAO() {
    config = DatabaseConfig();
  }

  insert({Map values}) async {
    db = await config.database;
    db.insert('endereco', values).then((value) {
      print(value);
      return value;
    }).catchError((error) {
      print(error.toString());
      return null;
    });
  }

  drop() async {
    db = await config.database;
    db.execute("DROP TABLE endereco").then((value) {
      EasyLoading.showSuccess('executado com sucesso');
    });
  }

  create() async {
    db = await config.database;
    config.createTables(db: db, sql: ENDERECO, verson: 1);
  }

  getEnderecos() async {
    db = await config.database;

    return await db.query('endereco');
  }
}
