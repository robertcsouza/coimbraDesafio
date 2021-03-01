
import 'package:roberto_desafio_coimbra_app/Model/Status.dart';
import 'package:roberto_desafio_coimbra_app/Model/TipoContrato.dart';
import 'package:roberto_desafio_coimbra_app/config/DatabaseConfig.dart';
import 'package:sqflite/sqflite.dart';

class FillTables {
  DatabaseConfig databaseConfig;
  Database db;
  FillTables() {
    getdb();
  }

  getdb() async {
    databaseConfig = DatabaseConfig();

    print('era pra instanciar');
  }

  fillTipo() async {
    db = await databaseConfig.database;

    var tipos = ['emprestimo', 'arrendamento', 'seguro', 'locacao'];

    for (var i = 0; i < tipos.length; i++) {
      TipoContrato tipo = TipoContrato(tipo: tipos[i]);
      db.insert('tipoContrato', tipo.toMap());
    }
  }

  fillStatus() async {
    db = await databaseConfig.database;

    var stat = ['edicao', 'ativo', 'cancelado'];

    for (var i = 0; i < stat.length; i++) {
      Status status = Status(status: stat[i]);
      db.insert('tipoContrato', status.toMap());
    }
  }
}
