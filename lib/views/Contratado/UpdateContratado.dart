
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratadoDAO.dart';
import 'package:roberto_desafio_coimbra_app/Model/Contratado.dart';
import 'package:roberto_desafio_coimbra_app/Model/Endereco.dart';
import 'package:roberto_desafio_coimbra_app/components/AppBar.dart';
import 'package:roberto_desafio_coimbra_app/components/Buttons.dart';
import 'package:roberto_desafio_coimbra_app/components/Inputs.dart';

class UpdateContratado extends StatefulWidget {
  @override
  _UpdateContratadoState createState() => _UpdateContratadoState();
}

class _UpdateContratadoState extends State<UpdateContratado> {
  TextEditingController razaoSocial = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController rua = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController telefone = TextEditingController();
  ContratadoDAO contratadoDAO;
  Contratado contratado;
  Endereco endereco;
  bool tongle = false;

  _update() async {
    if (razaoSocial.text.isNotEmpty &&
        cnpj.text.isNotEmpty &&
        cidade.text.isNotEmpty &&
        bairro.text.isNotEmpty &&
        numero.text.isNotEmpty &&
        telefone.text.isNotEmpty) {
      Contratado contratanteUpdated = Contratado(
          razaoSocial: razaoSocial.text,
          cnpj: int.parse(cnpj.text),
          telefone: int.parse(telefone.text),
          idContratado: contratado.idContratado);

      Endereco enderecoUpdated = Endereco(
          cidade: cidade.text,
          bairro: bairro.text,
          rua: rua.text,
          numero: int.parse(numero.text),
          idEndereco: endereco.idEndereco);

      await contratadoDAO.update(
          contratado: contratanteUpdated, endereco: enderecoUpdated);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/contratado');
      });
    } else {
      EasyLoading.showError('Por favor preencha todos os campos');
    }
  }

  _delete() async {
    await contratadoDAO.delete(contratado.idContratado);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/contratado');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contratadoDAO = ContratadoDAO();
  }

  _setfields() {
    if (tongle == false) {
      razaoSocial.text = contratado.razaoSocial;
      cnpj.text = contratado.cnpj.toString();
      cidade.text = endereco.cidade;
      bairro.text = endereco.bairro;
      rua.text = endereco.rua;
      numero.text = endereco.numero.toString();
      telefone.text = contratado.telefone.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> arg = args;

    setState(() {
      contratado = Contratado(
          razaoSocial: arg['razaoSocial'],
          cnpj: int.parse(arg['cnpj']),
          enderecoFK: arg['endereco_idendereco'],
          telefone: arg['telefone'],
          idContratado: arg['idContratado']);

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
