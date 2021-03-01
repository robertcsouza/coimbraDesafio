import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/Model/TipoContrato.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:sqflite/sqflite.dart';

class TipoContratoDAO {
  DatabaseConfig config;
  Database db;

  TipoContratoDAO() {
    config = DatabaseConfig();
  }

  insert({TipoContrato tipoContrato}) async {
    db = await config.database;
    return await db
        .insert('tipoContrato', tipoContrato.toMap())
        .catchError((error) {
      EasyLoading.showError('nao foi possivel inserir tipo de Contrato');
      print(error.toString());
      return null;
    });
  }

  drop() async {
    db = await config.database;
    db.execute("DROP TABLE tipoContrato").then((value) {
      EasyLoading.showSuccess('executado com sucesso');
    });
  }

  getTiposContratos() async {
    db = await config.database;

    return await db.query('tipoContrato');
  }
}
