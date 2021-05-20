import '../constants.dart';

import 'package:flutter/material.dart';

class InputFieldNotValidated extends StatefulWidget {
  final ValueChanged<String> field;
  final String title;
  final int maxLen;
  final myController;

  const InputFieldNotValidated({
    Key key,
    this.field,
    @required this.title,
    this.maxLen,
    this.myController,
  }) : super(key: key);

  @override
  _InputFieldNotValidatedState createState() =>
      _InputFieldNotValidatedState(myController);
}

class _InputFieldNotValidatedState extends State<InputFieldNotValidated> {
  var textController;
  _InputFieldNotValidatedState(myController) {
    textController = myController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        cursorColor: Theme.of(context).cursorColor,
        controller: textController,
        onChanged: widget.field,
        maxLength: widget.maxLen,
        decoration: InputDecoration(
          labelText: widget.title,
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
