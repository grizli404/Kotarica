import 'package:app/components/customAppBar.dart';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/body.dart';
import 'package:flutter/material.dart';

import '../../components/drawer.dart';

class ProductCategoryLayout extends StatelessWidget {
  String category;
  List<Proizvod> listaProizvoda;
  int potkategorijaId;
  int categoryId;
  ProductCategoryLayout(
      {this.category,
      this.listaProizvoda,
      this.categoryId,
      this.potkategorijaId});
  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isIphone(context)) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Body(
          category: category,
          proizvodi: listaProizvoda,
          categoryId: categoryId,
          potkategorijaId: potkategorijaId,
        ),
        drawer: ListenToDrawerEvent(),
        extendBody: true,
        bottomNavigationBar: !isWeb ? NavigationBarWidget() : null,
      );
    } else {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Body(
          category: category,
          proizvodi: listaProizvoda,
          categoryId: categoryId,
          potkategorijaId: potkategorijaId,
        ),
      );
    }
  }
}
