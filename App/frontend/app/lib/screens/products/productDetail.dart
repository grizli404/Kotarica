import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/screens/products/productDetailLayout.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/proizvodiModel.dart';
import 'body.dart';

class ProductDetail extends StatelessWidget {
  final assetPath, price, name;
  final Proizvod proizvod;

  ProductDetail(
      {this.assetPath, this.price, this.name, @required this.proizvod});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        iphone: ProductDetailLayout(
            proizvod: proizvod, assetPath: assetPath, price: price, name: name),
        ipad: Row(
          children: [
            Expanded(
              // flex: 1000,
              child: ListenToDrawerEvent(),
            ),
            Expanded(
              flex: _size.width > 1200 && _size.width < 1340 ? 6 : 3,
              child: ProductDetailLayout(
                  proizvod: proizvod,
                  assetPath: assetPath,
                  price: price,
                  name: name),
            ),
          ],
        ),
        macbook: Row(
          children: [
            //   Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
            Expanded(
              // flex: _size.width > 1340 ? 1 : 100,
              child: ListenToDrawerEvent(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 6 : 3,
              child: ProductDetailLayout(
                  proizvod: proizvod,
                  assetPath: assetPath,
                  price: price,
                  name: name),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 130.0),
            // ),
          ],
        ),
      ),
    );
  }
}
