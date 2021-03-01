
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratanteDAO.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratante.dart';
import 'package:roberto_desafio_coimbra_app/Model/Endereco.dart';
import 'package:roberto_desafio_coimbra_app/components/AppBar.dart';
import 'package:roberto_desafio_coimbra_app/components/Buttons.dart';
import 'package:roberto_desafio_coimbra_app/components/Inputs.dart';

class UpdateContratante extends StatefulWidget {
  @override
  _UpdateContratanteState createState() => _UpdateContratanteState();
}

class _UpdateContratanteState extends State<UpdateContratante> {
  TextEditingController razaoSocial = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController rua = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController telefone = TextEditingController();
  ContratanteDAO contratanteDAO;
  Contratante contratante;
  Endereco endereco;
  bool tongle = false;

  _update() async {
    if (razaoSocial.text.isNotEmpty &&
        cnpj.text.isNotEmpty &&
        cidade.text.isNotEmpty &&
        bairro.text.isNotEmpty &&
        numero.text.isNotEmpty &&
        telefone.text.isNotEmpty) {
      Contratante contratanteUpdated = Contratante(
          razaoSocial: razaoSocial.text,
          cnpj: int.parse(cnpj.text),
          telefone: int.parse(telefone.text),
          idContratante: contratante.idContratante);

      Endereco enderecoUpdated = Endereco(
          cidade: cidade.text,
          bairro: bairro.text,
          rua: rua.text,
          numero: int.parse(numero.text),
          idEndereco: endereco.idEndereco);

      await contratanteDAO.update(
          contratante: contratanteUpdated, endereco: enderecoUpdated);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/contratante');
      });
    } else {
      EasyLoading.showError('Por favor preencha todos os campos');
    }
  }

  _delete() async {
    await contratanteDAO.delete(contratante.idContratante);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/contratante');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contratanteDAO = ContratanteDAO();
  }

  _setfields() {
    if (tongle == false) {
      razaoSocial.text = contratante.razaoSocial;
      cnpj.text = contratante.cnpj.toString();
      cidade.text = endereco.cidade;
      bairro.text = endereco.bairro;
      rua.text = endereco.rua;
      numero.text = endereco.numero.toString();
      telefone.text = contratante.telefone.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> arg = args;
    setState(() {
      contratante = Contratante(
          razaoSocial: arg['c_razaoSocial'],
          cnpj: arg['c_cnpj'],
          enderecoFK: arg['c_endereco_idendereco'],
          telefone: arg['c_telefone'],
          idContratante: arg['idContratante']);

      endereco = Endereco(
          cidade: arg['cidade'],
          bairro: arg['bairro'],
          rua: arg['rua'],
          idEndereco: arg['idEndereco'],
          numero: arg['numero']);
    });

    _setfields();

    setState(() {
      tongle = true;
    });

    return Scaffold(
      appBar: appbar(title: 'Atualizar Contratante'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                btUpdate(
                    call: () {
                      _update();
                    },
                    lable: 'Atualizar',
                    context: context),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: btDelete(
                      call: () {
                        _delete();
                      },
                      lable: 'Deletar',
                      context: context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
