
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/Model/CondicoesFinanceiras.dart';
import 'package:roberto_desafio_coimbra_app/components/EasyLoading.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:sqflite/sqflite.dart';

class CondicoesDAO {
  DatabaseConfig config;
  Database db;

  CondicoesDAO() {
    config = DatabaseConfig();
  }

  insert({CondicoesFinanceiras condicoesFinanceiras}) async {
    db = await config.database;
    easyLoading();
    var id = await db
        .insert('condicoesFinanceiras', condicoesFinanceiras.toMap())
        .catchError((error) {
      EasyLoading.showError('nao foi possivel executar essa ação');
    });
    EasyLoading.dismiss();
    return id;
  }

  delete(int id) async {
    db = await config.database;
    db
        .delete('condicoesFinanceiras', where: 'idCondicoesFinanceiras = $id')
        .then((value) {
      EasyLoading.showSuccess('Contratado deletado com sucesso');
    }).catchError((error) {
      EasyLoading.showError('nao foi possivel deletar contratado');
    });
  }

  getCondicoes() async {
    Database db = await config.database;
    return await db.query('condicoesFinanceiras');
  }
}
