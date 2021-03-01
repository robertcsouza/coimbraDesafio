import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/DAO/CondicoesDAO.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratadoDAO.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratanteDAO.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratoDAO.dart';
import 'package:roberto_desafio_coimbra_app/DAO/StatusDAO.dart';
import 'package:roberto_desafio_coimbra_app/DAO/TipoContratoDAO.dart';
import 'package:roberto_desafio_coimbra_app/Model/CondicoesFinanceiras.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratado.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratante.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contrato.dart';
import 'package:roberto_desafio_coimbra_app/Model/Status.dart';
import 'package:roberto_desafio_coimbra_app/Model/TipoContrato.dart';
import 'package:roberto_desafio_coimbra_app/components/AppBar.dart';
import 'package:roberto_desafio_coimbra_app/components/Buttons.dart';
import 'package:roberto_desafio_coimbra_app/components/Inputs.dart';
import 'package:roberto_desafio_coimbra_app/helper/ConvertDate.dart';

class UpdateContrato extends StatefulWidget {
  @override
  _UpdateContratoState createState() => _UpdateContratoState();
}

class _UpdateContratoState extends State<UpdateContrato> {
  bool tongle = false;
  StatusDAO statusDAO = StatusDAO();
  TipoContratoDAO tipoContratoDAO = TipoContratoDAO();
  ContratanteDAO contratanteDAO = ContratanteDAO();
  ContratadoDAO contratadoDAO = ContratadoDAO();
  CondicoesDAO condicoesDAO = CondicoesDAO();
  ContratoDAO contratoDAO = ContratoDAO();

  List<Contratante> contratantes = List();
  List<Contratado> contratados = List();
  List<Status> status = List();
  List<TipoContrato> tipoContrato = List();

  TextEditingController carencia = TextEditingController();
  TextEditingController vigencia = TextEditingController();
  TextEditingController valor = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime dataInicial = null;
  DateTime dataFinal = null;
  String dataInicialStr = 'Prazo inicial';
  String dataFinalStr = 'Prazo final';
  int contratanteId;
  int contratadoId;
  int tipoContratoId;
  int statusId;
  int idContrato;

  Contratado selectContratado;
  Contratante selectContratante;
  Status selectStatus;
  TipoContrato selectTipoContrato;
  CondicoesFinanceiras selectCondicoesFinanceiras;

  getListStatus() async {
    var rawStatus = await statusDAO.getStatus();
    status.clear();
    for (var item in rawStatus) {
      Status stat = Status(id: item['idStatus'], status: item['status']);
      status.add(stat);
    }
  }

  getListTipoContrato() async {
    var rawTipoContrato = await tipoContratoDAO.getTiposContratos();
    tipoContrato.clear();
    for (var item in rawTipoContrato) {
      TipoContrato tipo = TipoContrato(
          idTipoContrato: item['idTipoContrato'], tipo: item['tipo']);
      tipoContrato.add(tipo);
    }
  }

  getListContratante() async {
    var rawContratante = await contratanteDAO.getContratantes();
    contratantes.clear();
    for (var item in rawContratante) {
      Contratante contratante = Contratante(
          idContratante: item['idContratante'],
          razaoSocial: item['c_razaoSocial'],
          enderecoFK: item['c_endereco_idendereco']);
      contratantes.add(contratante);
    }
  }

  getListContratado() async {
    var rawContratado = await contratadoDAO.getContratados();
    print(rawContratado);
    contratados.clear();
    for (var item in rawContratado) {
      Contratado contratado = Contratado(
          idContratado: item['idContratado'],
          razaoSocial: item['razaoSocial'],
          enderecoFK: item['endereco_idendereco']);
      contratados.add(contratado);
    }
  }

  Future<void> _dataInicial(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      print(picked);
      setState(() {
        dataInicial = picked;
        dataInicialStr = dateConvert(dataInicial, '-');
      });
    }
  }

  Future<void> _dataFinal(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      print(picked);
      setState(() {
        dataFinal = picked;
        dataFinalStr = dateConvert(dataFinal, '-');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListStatus();
    getListTipoContrato();
    getListContratante();
    getListContratado();
  }

  _fillFields(arg) {
    if (tongle == false) {
      idContrato = arg['idContrato'];
      selectContratado = arg['contratado'];
      selectStatus = arg['status'];
      selectTipoContrato = arg['tipo'];
      selectCondicoesFinanceiras = arg['condicoes'];
      selectContratante = arg['contratante'];
      contratadoId = selectContratado.idContratado;
      statusId = selectStatus.id;
      contratanteId = selectContratante.idContratante;
      tipoContratoId = selectTipoContrato.idTipoContrato;
      carencia.text = selectCondicoesFinanceiras.carencia.toString();
      vigencia.text = selectCondicoesFinanceiras.vigencia.toString();
      valor.text = selectCondicoesFinanceiras.valor.toString();
      dataInicial = DateTime.fromMillisecondsSinceEpoch(
          selectCondicoesFinanceiras.prazoInicial);
      dataInicialStr = dateConvert(dataInicial, '-');
      dataFinal = DateTime.fromMillisecondsSinceEpoch(
          selectCondicoesFinanceiras.prazoFinal);
      dataFinalStr = dateConvert(dataFinal, '-');
      setState(() {
        tongle = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> arg = args;
    print(arg);
    //exec once
    _fillFields(arg);

    return Scaffold(
      appBar: appbar(title: 'Atualizar Contrato'),
      body: body(),
    );
  }

  Widget body() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //contratante
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownSearch<Contratante>(
                  items: contratantes,
                  label: "Contratante",
                  selectedItem: selectContratante,
                  itemAsString: (Contratante u) => u.asString(),
                  onChanged: (Contratante data) {
                    setState(() {
                      contratanteId = data.idContratante;
                    });
                  },
                ),
              ),
              //tipo Contrato
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownSearch<TipoContrato>(
                  items: tipoContrato,
                  label: "Tipo Contrato",
                  selectedItem: selectTipoContrato,
                  itemAsString: (TipoContrato u) => u.asString(),
                  onChanged: (TipoContrato data) {
                    setState(() {
                      tipoContratoId = data.idTipoContrato;
                    });
                  },
                ),
              ),
              //contratado
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownSearch<Contratado>(
                  items: contratados,
                  label: "Contratado",
                  selectedItem: selectContratado,
                  itemAsString: (Contratado u) => u.asString(),
                  onChanged: (Contratado data) {
                    setState(() {
                      selectContratado = data;
                      contratadoId = data.idContratado;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownSearch<Status>(
                  items: status,
                  label: "Status",
                  selectedItem: selectStatus,
                  itemAsString: (Status u) => u.asString(),
                  onChanged: (Status data) {
                    setState(() {
                      statusId = data.id;
                    });
                  },
                ),
              ),
              inputText(
                  controller: carencia,
                  hint: 'Carência em Meses',
                  obscure: false,
                  textInputType: TextInputType.number),

              inputText(
                  controller: vigencia,
                  hint: 'Vigência em Meses',
                  obscure: false,
                  textInputType: TextInputType.number),

              inputText(
                  controller: valor,
                  hint: 'Valor',
                  obscure: false,
                  textInputType: TextInputType.number),

              Padding(
                padding: const EdgeInsets.only(left: 8, right: 140),
                child: btSecondary(
                    call: () {
                      _dataInicial(context);
                    },
                    lable: dataInicialStr,
                    context: context),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8, right: 140),
                child: btSecondary(
                    call: () {
                      _dataFinal(context);
                    },
                    lable: dataFinalStr,
                    context: context),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 50),
                child: btPrimary(
                    call: () {
                      _save();
                    },
                    lable: 'Salvar',
                    context: context),
              )
            ],
          ),
        ));
  }

  _save() async {
    if (carencia.text.isNotEmpty &&
        vigencia.text.isNotEmpty &&
        valor.text.isNotEmpty &&
        dataInicial != null &&
        dataFinal != null &&
        selectedDate != null &&
        contratanteId > 0 &&
        contratadoId > 0 &&
        tipoContratoId > 0) {
      CondicoesFinanceiras condicoesFinanceiras = CondicoesFinanceiras(
          carencia: int.parse(carencia.text),
          vigencia: int.parse(vigencia.text),
          valor: int.parse(valor.text),
          prazoInicial: dataInicial.millisecondsSinceEpoch,
          prazoFinal: dataFinal.millisecondsSinceEpoch,
          id: selectCondicoesFinanceiras.id);

      Contrato contrato = Contrato(
          idContrato: idContrato,
          condicoesFK: selectCondicoesFinanceiras.id,
          contratadoFK: contratadoId,
          contratanteFK: contratanteId,
          statusFK: statusId,
          tipoContratoFK: tipoContratoId,
          dataCriacao: selectedDate.millisecondsSinceEpoch);
      await contratoDAO.update(
          contrato: contrato, condicoesFinanceiras: condicoesFinanceiras);

      EasyLoading.showSuccess('contrato cadastrado com sucesso');
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/');
      });
    } else {
      EasyLoading.showError('Por favor preencha todos os campos');
    }
  }
}
