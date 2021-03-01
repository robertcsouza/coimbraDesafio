
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratoDAO.dart';
import 'package:roberto_desafio_coimbra_app/Model/CondicoesFinanceiras.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratado.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratante.dart';
import 'package:roberto_desafio_coimbra_app/Model/Status.dart';
import 'package:roberto_desafio_coimbra_app/Model/TipoContrato.dart';
import 'package:roberto_desafio_coimbra_app/components/AppBar.dart';
import 'package:roberto_desafio_coimbra_app/components/Buttons.dart';
import 'package:roberto_desafio_coimbra_app/helper/ConvertDate.dart';

class DetailContrato extends StatefulWidget {
  @override
  _DetailContratoState createState() => _DetailContratoState();
}

class _DetailContratoState extends State<DetailContrato> {
  ContratoDAO contratoDAO = ContratoDAO();
  Contratado contratado;
  Contratante contratante;
  CondicoesFinanceiras condicoesFinanceiras;
  Status status;
  TipoContrato tipoContrato;
  int idContrato;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> map = args;
    idContrato = map['idContrato'];

    contratado = Contratado(
        idContratado: map['idContratado'],
        razaoSocial: map['razaoSocial'],
        cnpj: int.parse(map['cnpj']),
        enderecoFK: map['endereco_idendereco'],
        telefone: map['telefone']);

    contratante = Contratante(
        idContratante: map['idContratante'],
        razaoSocial: map['c_razaoSocial'],
        cnpj: map['c_cnpj'],
        enderecoFK: map['c_endereco_idendereco'],
        telefone: map['c_telefone']);

    condicoesFinanceiras = CondicoesFinanceiras(
        id: map['idCondicoesFinanceiras'],
        carencia: map['carencia'],
        valor: map['valor'],
        vigencia: map['vigencia'],
        prazoFinal: map['prazo_final'],
        prazoInicial: map['prazo_inicial']);

    status = Status(id: map['idStatus'], status: map['status']);

    tipoContrato =
        TipoContrato(idTipoContrato: map['idTipoContrato'], tipo: map['tipo']);

    return Scaffold(
      appBar: appbar(title: 'Detalhes Do Contrato'),
      body: _body(),
    );
  }

  _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:16.0, bottom: 16.0),
                child: Text(
                  'Contratado',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Razão Social: ${contratado.razaoSocial}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('CNPJ: ${contratado.cnpj}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Telefone: ${contratado.telefone}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0,bottom: 16),
                child: Text(
                  'Contratante',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Razão Social: ${contratante.razaoSocial}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('CNPJ: ${contratante.cnpj}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Telefone: ${contratante.telefone}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0,bottom: 16),
                child: Text(
                  'Condiçôes Financeiras',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Carência:  ${condicoesFinanceiras.carencia} Mêses'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Vigência:  ${condicoesFinanceiras.vigencia} Mêses'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Valor: R\$ ${condicoesFinanceiras.valor}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Data Inicial:  ${dateConvert(DateTime.fromMillisecondsSinceEpoch(condicoesFinanceiras.prazoInicial), '-')}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Data Final:  ${dateConvert(DateTime.fromMillisecondsSinceEpoch(condicoesFinanceiras.prazoFinal), '-')}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0,bottom: 16),
                child: Text(
                  'Status do Contrato',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Status:  ${status.status}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0,bottom: 16),
                child: Text(
                  'Tipo do Contrato',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tipo:  ${tipoContrato.tipo}'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    btUpdate(
                        call: () {
                          Navigator.pushReplacementNamed(
                              context, '/contrato/update',
                              arguments: {
                                'idContrato': idContrato,
                                'contratado': contratado,
                                'condicoes': condicoesFinanceiras,
                                'status': status,
                                'tipo': tipoContrato,
                                'contratante': contratante
                              });
                        },
                        lable: 'Editar',
                        context: context),
                    btDelete(
                        call: () async {
                          await contratoDAO.delete(idContrato);
                          EasyLoading.showSuccess(
                              'Contrato  deletado com sucesso');
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pushReplacementNamed(context, '/');
                          });
                        },
                        lable: 'Deletar',
                        context: context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
