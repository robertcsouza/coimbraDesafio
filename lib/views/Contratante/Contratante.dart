import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratanteDAO.dart';
import 'package:roberto_desafio_coimbra_app/components/AppBar.dart';
import 'package:roberto_desafio_coimbra_app/components/Buttons.dart';
import 'package:roberto_desafio_coimbra_app/components/EasyLoading.dart';
import 'package:roberto_desafio_coimbra_app/components/NaviBar.dart';

class Contratante extends StatefulWidget {
  @override
  _ContratanteState createState() => _ContratanteState();
}

class _ContratanteState extends State<Contratante> {
  ContratanteDAO contratanteDAO;
  Future contratantes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    contratanteDAO = ContratanteDAO();
    contratantes = contratanteDAO.getContratantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: 'contratante'),
      bottomNavigationBar: navigation(context: context, index: 0),
      body: body(),
      floatingActionButton: btFloatAction(
          call: () {
            Navigator.pushNamed(context, '/contratante/add');
          },
          iconLable: Icon(Icons.add),
          context: context),
    );
  }

  Widget body() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: contratantes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              easyLoading();
              Future.delayed(Duration(seconds: 2), () {
                EasyLoading.dismiss();
              });
              return SizedBox();
            } else {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/contratante/update',
                                arguments: snapshot.data[index]);
                          },
                          title: Text(snapshot.data[index]['c_razaoSocial']),
                          subtitle: Text(
                              snapshot.data[index]['c_telefone'].toString()),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            }
          },
        ));
  }
}
