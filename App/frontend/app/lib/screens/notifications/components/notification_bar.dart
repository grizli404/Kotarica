import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/proizvodiModel.dart';

class NotificationBar extends StatelessWidget {
  final String message;
  final Proizvod proizvod;

  const NotificationBar({Key key, @required this.message, this.proizvod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (proizvod == null) {
      return NotificationWithoutProduct(message: message);
    } else {
      return NotificationWithProduct(
        message: message,
        proizvod: proizvod,
      );
    }
  }
}

class NotificationWithProduct extends StatelessWidget {
  final String message;
  final Proizvod proizvod;

  const NotificationWithProduct(
      {Key key, @required this.message, @required this.proizvod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 22),
              ),
              Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/cookiechoco.jpg"),
                          fit: BoxFit.contain)))
            ],
          ),
          SizedBox(height: 10.0),
          Divider(
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}

class NotificationWithoutProduct extends StatelessWidget {
  final String message;

  const NotificationWithoutProduct({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Divider(
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}
