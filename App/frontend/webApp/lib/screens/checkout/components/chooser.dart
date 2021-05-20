import 'package:app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chooser extends StatefulWidget {
  Chooser({this.confirm = false, this.payment = false, this.shipping = false});
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Icon(
                  Icons.location_on,
                  color: widget.shipping
                      ? Theme.of(context).accentColor
                      : Colors.grey,
                ),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Icon(
                  Icons.payment,
                  color: widget.payment
                      ? Theme.of(context).accentColor
                      : Colors.grey,
                ),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Icon(
                  Icons.check,
                  color: widget.confirm
                      ? Theme.of(context).accentColor
                      : Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
}
