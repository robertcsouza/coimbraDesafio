
import 'package:flutter/material.dart';
import 'package:roberto_desafio_coimbra_app/styles/Colors.dart';

AppBar appbar({String title}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title), /*_stream()*/
      ],
    ),
    backgroundColor: primary,
  );
}
