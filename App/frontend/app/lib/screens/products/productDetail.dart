import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/responsive_layout.dart';
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
      appBar: CustomAppBar(),
      drawer: ResponsiveLayout.isIphone(context) ? ListenToDrawerEvent() : null,
      bottomNavigationBar: !isWeb ? NavigationBarWidget() : null,
      body: ResponsiveLayout(
        iphone: Body(
          assetPath: assetPath,
          price: price,
          name: name,
          proizvod: proizvod,
        ),
        ipad: Row(
          children: [
            Expanded(
              flex: _size.width > 1200 && _size.width < 1340 ? 2 : 4,
              child: ListenToDrawerEvent(),
            ),
            Expanded(
              child: Body(
                assetPath: assetPath,
                price: price,
                name: name,
                proizvod: proizvod,
              ),
              flex: _size.width > 1200 && _size.width < 1340 ? 8 : 10,
            )
          ],
        ),
        macbook: Row(
          children: [
            //   Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
            Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: ListenToDrawerEvent(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: Body(
                assetPath: assetPath,
                price: price,
                name: name,
                proizvod: proizvod,
              ),
            ),
            //  Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
          ],
        ),
      ),
    );
  }
}
