import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/Model/Status.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:sqflite/sqflite.dart';

class StatusDAO {
  DatabaseConfig config;
  Database db;

  StatusDAO() {
    config = DatabaseConfig();
  }

  insert({Status status}) async {
    db = await config.database;
    return await db.insert('status', status.toMap()).catchError((error) {
      EasyLoading.showError('nao foi possivel inserir o status');
      print(error.toString());
      return null;
    });
  }

  drop() async {
    db = await config.database;
    db.execute("DROP TABLE status").then((value) {
      EasyLoading.showSuccess('executado com sucesso');
    });
  }

  getStatus() async {
    db = await config.database;

    return await db.query('status');
  }
}
