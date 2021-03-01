
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratante.dart';
import 'package:roberto_desafio_coimbra_app/Model/Endereco.dart';
import 'package:roberto_desafio_coimbra_app/components/EasyLoading.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:sqflite/sqflite.dart';

class ContratanteDAO {
  DatabaseConfig config;
  Database db;

  ContratanteDAO() {
    config = DatabaseConfig();
  }

  insert({Endereco endereco, Contratante contratante}) async {
    db = await config.database;
    easyLoading();
    db.insert('endereco', endereco.toMap()).then((id) {
      Map<String, dynamic> map = contratante.toMap();
      map.update('c_endereco_idendereco', (value) => id);
      db.insert('contratante', map).then((value) {
        EasyLoading.showSuccess('Contratante cadastrado com sucesso');
      }).catchError((error) {
        EasyLoading.showError('nao foi possivel cadastrar contratante');
      });
    });
  }

  delete(int id) async {
    db = await config.database;
    db.delete('contratante', where: 'idContratante = $id').then((value) {
      EasyLoading.showSuccess('Contratante deletado com sucesso');
    }).catchError((error) {
      EasyLoading.showError('nao foi possivel deletar contratante');
    });
  }

  update({Endereco endereco, Contratante contratante}) async {
    db = await config.database;
    easyLoading();
    db.update('endereco', endereco.toMap(),
        where: 'idEndereco = ?', whereArgs: [endereco.idEndereco]).then((id) {
      Map<String, dynamic> map = contratante.toMap();
      map.update('c_endereco_idendereco', (value) => id);
      db.update('contratante', map,
          where: 'idContratante = ?',
          whereArgs: [contratante.idContratante]).then((value) {
        EasyLoading.showSuccess('Contratante autalizado com sucesso');
      }).catchError((error) {
        EasyLoading.showError('nao foi possivel atualizar contratante');
      });
    });
  }

  Future getContratantes() async {
    Database db = await config.database;
    return db.rawQuery(
        "SELECT * FROM contratante JOIN endereco on endereco.idEndereco = contratante.c_endereco_idendereco");
  }
}
