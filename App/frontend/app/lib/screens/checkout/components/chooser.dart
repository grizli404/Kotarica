import 'package:app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chooser extends StatefulWidget {
  Chooser(
      {this.shippingSetter,
      this.paymentSetter,
      this.confirmSetter,
      this.confirm = false,
      this.payment = false,
      this.shipping = false});
  Function shippingSetter;
  Function paymentSetter;
  Function confirmSetter;
  bool shipping, payment, confirm;
  @override
  State<Chooser> createState() => ChooserState();
}

class ChooserState extends State<Chooser> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: GestureDetector(
                onTap: () {
                  widget.paymentSetter(false);
                  widget.confirmSetter(false);
                  widget.shippingSetter(true);
                },
                child: Icon(
                  Icons.location_on,
                  color: widget.shipping ? kPrimaryColor : Colors.grey,
                ),
              ))),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: GestureDetector(
                onTap: () {
                  widget.shippingSetter(false);
                  widget.confirmSetter(false);

                  widget.paymentSetter(true);
                },
                child: Icon(
                  Icons.payment,
                  color: widget.payment ? kPrimaryColor : Colors.grey,
                ),
              ))),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: GestureDetector(
                onTap: () {
                  widget.shippingSetter(false);
                  widget.paymentSetter(false);
                  widget.confirmSetter(true);
                },
                child: Icon(
                  Icons.check,
                  color: widget.confirm ? kPrimaryColor : Colors.grey,
                ),
              ))),
        ],
      ),
    );
  }
}
