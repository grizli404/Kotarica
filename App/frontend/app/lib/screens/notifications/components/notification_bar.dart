import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/proizvodiModel.dart';

class NotificationBar extends StatelessWidget {
  final String message;
  final Proizvod proizvod;

  const NotificationBar({Key key, this.message, this.proizvod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            message,
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
