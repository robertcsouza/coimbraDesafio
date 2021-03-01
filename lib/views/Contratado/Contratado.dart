
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roberto_desafio_coimbra_app/DAO/ContratadoDAO.dart';
import 'package:roberto_desafio_coimbra_app/components/AppBar.dart';
import 'package:roberto_desafio_coimbra_app/components/Buttons.dart';
import 'package:roberto_desafio_coimbra_app/components/EasyLoading.dart';
import 'package:roberto_desafio_coimbra_app/components/NaviBar.dart';

class Contratado extends StatefulWidget {
  @override
  _ContratadoState createState() => _ContratadoState();
}

class _ContratadoState extends State<Contratado> {
  ContratadoDAO contratadoDAO;
  Future contratantes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    contratadoDAO = ContratadoDAO();
    contratantes = contratadoDAO.getContratados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: 'Contratados'),
      bottomNavigationBar: navigation(context: context, index: 2),
      body: body(),
      floatingActionButton: btFloatAction(
          call: () {
            Navigator.pushNamed(context, '/contratado/add');
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/contratado/update',
                              arguments: snapshot.data[index]);
                        },
                        title: Text(snapshot.data[index]['razaoSocial']),
                        subtitle:
                            Text(snapshot.data[index]['telefone'].toString()),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
