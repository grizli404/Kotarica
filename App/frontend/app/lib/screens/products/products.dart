import 'package:flutter/material.dart';
import 'package:app/components/product_card.dart';

class ProductList extends StatelessWidget {
  String imeProizvodjaca;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produkti proizvodjaca " + imeProizvodjaca),
      ),
    );
  }
}
