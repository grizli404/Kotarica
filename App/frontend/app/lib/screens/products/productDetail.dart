import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class ProductDetail extends StatelessWidget {
  final assetPath, price, name;

  ProductDetail({this.assetPath, this.price, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: ListenToDrawerEvent(),
      body: Body(
        assetPath: assetPath,
        price: price,
        name: name,
      ),
    );
  }
}
