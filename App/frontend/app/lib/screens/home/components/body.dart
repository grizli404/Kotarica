<<<<<<< HEAD
import 'package:app/screens/home/components/productView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//import '../../../constants.dart';
import 'headerWithSearchBox.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeOf(context).size;
    return Container(
      //height: constraints.maxHeight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithSearchBox(size: size),
            //SizedBox(height: kDefaultPadding),
            ProductView(),
          ],
        ),
=======
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
>>>>>>> 2ef4c09f107e2e28241f6bbd5d22ff5e1f235d19
      ),
    );
  }
}
