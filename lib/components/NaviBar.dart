import 'package:flutter/material.dart';
import 'package:roberto_desafio_coimbra_app/styles/Colors.dart';


BottomNavigationBar navigation({index, ontapped, context}) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.view_list),
        title: Text('Contratante'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        title: Text('Contrato'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('Contratado'),
      ),
    ],
    currentIndex: index,
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/contratante');
          break;

        case 1:
          Navigator.pushNamed(context, '/');
          break;

        case 2:
          Navigator.pushReplacementNamed(context, '/contratado');
          break;
      }
    },
    selectedItemColor: primary,
  );
}
