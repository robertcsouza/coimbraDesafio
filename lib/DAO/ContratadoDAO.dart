
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratado.dart';
import 'package:roberto_desafio_coimbra_app/Model/Endereco.dart';
import 'package:roberto_desafio_coimbra_app/components/EasyLoading.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:sqflite/sqflite.dart';

class ContratadoDAO {
  DatabaseConfig config;
  Database db;

  ContratadoDAO() {
    config = DatabaseConfig();
  }

  insert({Endereco endereco, Contratado contratado}) async {
    db = await config.database;
    easyLoading();
    db.insert('endereco', endereco.toMap()).then((id) {
      Map<String, dynamic> map = contratado.toMap();
      map.update('endereco_idendereco', (value) => id);
      db.insert('contratado', map).then((value) {
        EasyLoading.showSuccess('Contratado cadastrado com sucesso');
      }).catchError((error) {
        EasyLoading.showError('nao foi possivel cadastrar Contratado');
      });
    });
  }

  delete(int id) async {
    db = await config.database;
    db.delete('contratado', where: 'idContratado = $id').then((value) {
      EasyLoading.showSuccess('Contratado deletado com sucesso');
    }).catchError((error) {
      EasyLoading.showError('nao foi possivel deletar contratado');
    });
  }

  update({Endereco endereco, Contratado contratado}) async {
    db = await config.database;
    easyLoading();

    db.update('endereco', endereco.toMap(),
        where: 'idEndereco = ?', whereArgs: [endereco.idEndereco]).then((id) {
      Map<String, dynamic> map = contratado.toMap();
      map.update('endereco_idendereco', (value) => id);
      db.update('contratado', map,
          where: 'idContratado = ?',
          whereArgs: [contratado.idContratado]).then((value) {
        EasyLoading.showSuccess('Contratado autalizado com sucesso');
      }).catchError((error) {
        print(error);
        EasyLoading.showError('nao foi possivel atualizar Contratado');
      });
    });
  }

  Future getContratados() async {
    Database db = await config.database;
    return db.rawQuery(
        "SELECT * FROM contratado JOIN endereco on endereco.idEndereco = contratado.endereco_idendereco");
  }
}
