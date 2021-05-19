import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/proizvodiModel.dart';
import 'body.dart';

class ProductDetailLayout extends StatelessWidget {
  final assetPath, price, name;
  final Proizvod proizvod;

  ProductDetailLayout(
      {this.assetPath, this.price, this.name, @required this.proizvod});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: ResponsiveLayout.isIphone(context) ? ListenToDrawerEvent() : null,
      bottomNavigationBar: !isWeb ? NavigationBarWidget() : null,
      extendBody: true,
      body: Body(
        assetPath: assetPath,
        // price: price,
        //  name: name,
        proizvod: proizvod,
      ),
    );
  }
}
