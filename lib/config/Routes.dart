

import 'package:roberto_desafio_coimbra_app/views/Contratado/AddContratado.dart';
import 'package:roberto_desafio_coimbra_app/views/Contratado/Contratado.dart';
import 'package:roberto_desafio_coimbra_app/views/Contratado/UpdateContratado.dart';
import 'package:roberto_desafio_coimbra_app/views/Contratante/AddContratante.dart';
import 'package:roberto_desafio_coimbra_app/views/Contratante/Contratante.dart';
import 'package:roberto_desafio_coimbra_app/views/Contratante/UpdateContratante.dart';
import 'package:roberto_desafio_coimbra_app/views/Contrato/AddContrato.dart';
import 'package:roberto_desafio_coimbra_app/views/Contrato/DetailContrato.dart';
import 'package:roberto_desafio_coimbra_app/views/Contrato/UpdateContrato.dart';

route() {
  return {
    //rotas contratante
    '/contratante': (context) => Contratante(),
    '/contratante/add': (context) => AddContratante(),
    '/contratante/update': (context) => UpdateContratante(),
    //rotas contratado
    '/contratado': (context) => Contratado(),
    '/contratado/add': (context) => AddContratado(),
    '/contratado/update': (context) => UpdateContratado(),

    // rotas contrato
    '/contrato/add': (context) => AddContrato(),
    '/contrato/detail': (context) => DetailContrato(),
    '/contrato/update': (context) => UpdateContrato(),
  };
}
