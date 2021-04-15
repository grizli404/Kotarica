import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/productView.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class ProductByCategory extends StatelessWidget {
  final String category;
  final List<Proizvod> listaProizvoda;

  const ProductByCategory({
    Key key,
    @required this.category,
    this.listaProizvoda,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      //     AppBar(
      //   title: Text('Proizvodi "' + category + '" kategorije'),
      //   backgroundColor: kPrimaryColor,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(36),
      //   )),
      // ),
      body: Stack(children: [
        //Text('Proizvodi ' + category + ' kategorije.'),
        ProductView(listaProizvoda: listaProizvoda),
      ]),
      drawer: ResponsiveLayout.isIphone(context) ? ListenToDrawerEvent() : null,
    );
  }
}
