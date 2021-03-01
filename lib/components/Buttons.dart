import 'package:flutter/material.dart';
import 'package:roberto_desafio_coimbra_app/styles/Colors.dart';

Widget btPrimary(
    {@required Function call, @required String lable, @required context}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: RaisedButton(
        color: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: call,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Text(
            lable,
            style: TextStyle(
              color: light,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget btUpdate(
    {@required Function call, @required String lable, @required context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    child: RaisedButton(
      color: Colors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: call,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
        child: Text(
          lable,
          style: TextStyle(
            color: light,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}

Widget btDelete(
    {@required Function call, @required String lable, @required context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    child: RaisedButton(
      color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: call,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
        child: Text(
          lable,
          style: TextStyle(
            color: light,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}

Widget btSecondary(
    {@required Function call, @required String lable, @required context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: primary)),
          onPressed: call,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Text(
              lable,
              style: TextStyle(
                color: primary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget btFlat(
    {@required Function call, @required String lable, @required context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: FlatButton(
      child: Text(
        lable,
        style: TextStyle(color: primary, fontSize: 14),
      ),
      onPressed: call,
    ),
  );
}

Widget btFloatAction(
    {@required Function call, @required Icon iconLable, @required context}) {
  return FloatingActionButton(
    onPressed: call,
    backgroundColor: primary,
    child: iconLable,
  );
}
