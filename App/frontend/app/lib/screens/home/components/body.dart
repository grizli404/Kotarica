import 'package:app/screens/home/components/productContainer.dart';
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
        //padding: EdgeInsets.symmetric(horizontal: 200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HeaderWithSearchBox(size: size),
            //SizedBox(height: kDefaultPadding),
            //ProductView(),
            ProductContainer(naziv: 'Najnoviji proizvodi'),
            ProductContainer(naziv: 'Popularni proizvodi'),
            ProductContainer(naziv: 'Preporuka'),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }
}
