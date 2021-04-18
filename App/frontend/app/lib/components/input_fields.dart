import '../constants.dart';

import 'package:flutter/material.dart';

class InputFieldNotValidated extends StatelessWidget {
  final ValueChanged<String> field;
  final String title;

  const InputFieldNotValidated({
    Key key,
    this.field,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: TextFormField(
        cursorColor: Theme.of(context).cursorColor,
        onChanged: field,
        maxLength: 20,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}

class InputFieldValidated extends StatelessWidget {
  final String field;
  final String title;

  const InputFieldValidated({
    Key key,
    @required this.field,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: TextFormField(
        cursorColor: Theme.of(context).cursorColor,
        initialValue: field,
        maxLength: 20,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.check_circle,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}

class InputPassword extends StatelessWidget {
  final String field;
  final String title;

  const InputPassword({
    Key key,
    @required this.field,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: TextFormField(
        initialValue: field,
        maxLength: 20,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.check_circle,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
