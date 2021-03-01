
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/Model/CondicoesFinanceiras.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contrato.dart';
import 'package:roberto_desafio_coimbra_app/components/EasyLoading.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:sqflite/sqflite.dart';

class ContratoDAO {
  DatabaseConfig config;
  Database db;

  ContratoDAO() {
    config = DatabaseConfig();
  }

  insert({Contrato contrato}) async {
    db = await config.database;
    return await db.insert('contrato', contrato.toMap()).catchError((error) {
      EasyLoading.showError('nao foi possivel inserir o status');
      print(error.toString());
      return null;
    });
  }

  update({Contrato contrato, CondicoesFinanceiras condicoesFinanceiras}) async {
    db = await config.database;
    easyLoading();

    db.update('condicoesFinanceiras', condicoesFinanceiras.toMap(),
        where: 'idCondicoesFinanceiras = ?',
        whereArgs: [condicoesFinanceiras.id]).then((value) {
      db.update('contrato', contrato.toMap(),
          where: 'idContrato = ?',
          whereArgs: [contrato.idContrato]).then((value) {
        EasyLoading.showSuccess('Contrato atualizado com sucesso!');
      });
    });
  }

  delete(int id) async {
    db = await config.database;
    db.delete('contrato', where: 'idContrato = $id').then((value) {
      EasyLoading.showSuccess('Contrato  deletado com sucesso');
    }).catchError((error) {
      EasyLoading.showError('nao foi possivel deletar Contrato');
    });
  }

  drop() async {
    db = await config.database;
    db.execute("DROP TABLE contrato").then((value) {
      EasyLoading.showSuccess('executado com sucesso');
    });
  }

  describe() async {
    db = await config.database;
    return await db.rawQuery("PRAGMA table_info(contrato)");
  }

  getContratosFilter({String column, int id}) async {
    db = await config.database;

    return db.rawQuery(
        "SELECT * FROM contrato JOIN contratado ON contratado.idContratado = contrato.contratado_idContratado JOIN condicoesFinanceiras ON condicoesFinanceiras.idCondicoesFinanceiras = contrato.condicoesFinanceiras_idCondicoesFinanceiras JOIN contratante ON contratante.idContratante = contrato.contratante_idContratante JOIN status ON status.idStatus = contrato.status_idStatus JOIN tipoContrato on tipoContrato.idTipoContrato = contrato.tipoContrato_idTipoContrato WHERE $column = $id");
  }

  getContratos() async {
    db = await config.database;

    return db.rawQuery(
        "SELECT * FROM contrato JOIN contratado ON contratado.idContratado = contrato.contratado_idContratado JOIN condicoesFinanceiras ON condicoesFinanceiras.idCondicoesFinanceiras = contrato.condicoesFinanceiras_idCondicoesFinanceiras JOIN contratante ON contratante.idContratante = contrato.contratante_idContratante JOIN status ON status.idStatus = contrato.status_idStatus JOIN tipoContrato on tipoContrato.idTipoContrato = contrato.tipoContrato_idTipoContrato");
  }
}
