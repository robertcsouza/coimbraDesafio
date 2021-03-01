import 'package:flutter/material.dart';

Widget inputText(
    {@required TextEditingController controller,
    @required String hint,
    @required bool obscure,
    @required TextInputType textInputType}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
    child: Container(
      child: TextField(
        obscureText: obscure,
        controller: controller,
        keyboardType: textInputType,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          focusedBorder: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          )),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          )),
        ),
      ),
    ),
  );
}
