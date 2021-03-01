
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratadoDAO.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratado.dart';
import 'package:roberto_desafio_coimbra_app/Model/Endereco.dart';
import 'package:roberto_desafio_coimbra_app/components/AppBar.dart';
import 'package:roberto_desafio_coimbra_app/components/Buttons.dart';
import 'package:roberto_desafio_coimbra_app/components/Inputs.dart';

class AddContratado extends StatefulWidget {
  @override
  _AddContratadoState createState() => _AddContratadoState();
}

class _AddContratadoState extends State<AddContratado> {
  TextEditingController razaoSocial = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController rua = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController telefone = TextEditingController();
  ContratadoDAO contratadoDAO;

  _save() async {
    if (razaoSocial.text.isNotEmpty &&
        cnpj.text.isNotEmpty &&
        cidade.text.isNotEmpty &&
        bairro.text.isNotEmpty &&
        numero.text.isNotEmpty &&
        telefone.text.isNotEmpty) {
      Contratado contratado = Contratado(
        razaoSocial: razaoSocial.text,
        cnpj: int.parse(cnpj.text),
        telefone: int.parse(telefone.text),
      );

      Endereco endereco = Endereco(
          cidade: cidade.text,
          bairro: bairro.text,
          rua: rua.text,
          numero: int.parse(numero.text));

      await contratadoDAO.insert(contratado: contratado, endereco: endereco);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/contratado');
      });
    } else {
      EasyLoading.showError('Por favor preencha todos os campos');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contratadoDAO = ContratadoDAO();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: 'Adicionar Contratado'),
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
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: inputText(
                  controller: razaoSocial,
                  hint: 'Razão Social',
                  obscure: false,
                  textInputType: TextInputType.text),
            ),
            inputText(
                controller: cnpj,
                hint: 'CNPJ',
                obscure: false,
                textInputType: TextInputType.number),
            inputText(
                controller: cidade,
                hint: 'Cidade',
                obscure: false,
                textInputType: TextInputType.text),
            inputText(
                controller: bairro,
                hint: 'Bairro',
                obscure: false,
                textInputType: TextInputType.text),
            inputText(
                controller: rua,
                hint: 'Rua',
                obscure: false,
                textInputType: TextInputType.text),
            inputText(
                controller: numero,
                hint: 'Número',
                obscure: false,
                textInputType: TextInputType.number),
            inputText(
                controller: telefone,
                hint: 'Telefone',
                obscure: false,
                textInputType: TextInputType.phone),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: btPrimary(
                  call: () {
                    _save();
                  },
                  lable: 'Salvar',
                  context: context),
            )
          ],
        ),
      ),
    );
  }
}
