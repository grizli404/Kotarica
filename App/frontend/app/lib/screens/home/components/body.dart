import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'headerWithSearchBox.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeOf(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
