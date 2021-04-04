import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double sizeQ;
  const TextFieldContainer({
    Key key,
    this.child,
    this.color = kPrimaryLightColor,
    this.sizeQ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * sizeQ,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(29),
        ),
        child: child);
  }
}
