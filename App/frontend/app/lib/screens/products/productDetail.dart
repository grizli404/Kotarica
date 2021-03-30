import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:flutter/material.dart';

import '../../model/proizvodiModel.dart';
import 'body.dart';

class ProductDetail extends StatelessWidget {
  final assetPath, price, name;
  final Proizvod proizvod;

  ProductDetail(
      {this.assetPath, this.price, this.name, @required this.proizvod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: ListenToDrawerEvent(),
      body: Body(
        proizvod: proizvod,
        assetPath: assetPath,
        price: price,
        name: name,
      ),
    );
  }
}
