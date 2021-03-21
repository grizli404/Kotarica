<<<<<<< HEAD
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  RoundedButton({
    Key key,
    this.size,
    this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.press,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        // ignore: deprecated_member_use
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
=======
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  RoundedButton({
    Key key,
    this.size,
    this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.press,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        // ignore: deprecated_member_use
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
>>>>>>> 2ef4c09f107e2e28241f6bbd5d22ff5e1f235d19
