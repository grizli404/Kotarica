import 'package:flutter/material.dart';
import 'package:app/components/product_card.dart';

class ProductList extends StatelessWidget {
  final String imeProizvodjaca;

  const ProductList({
    Key key,
    @required this.imeProizvodjaca,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produkti proizvodjaca " + imeProizvodjaca),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Row(
          children: [
            ProductCard(
                name: "proizvod",
                price: "100din",
                imgPath: "assets/images/cookiechoco.jpg",
                added: true,
                isFavorite: false,
                context: "context"),
            ProductCard(
                name: "proizvod",
                price: "100din",
                imgPath: "assets/images/cookiechoco.jpg",
                added: true,
                isFavorite: false,
                context: "context"),
            ProductCard(
                name: "proizvod",
                price: "100din",
                imgPath: "assets/images/cookiechoco.jpg",
                added: true,
                isFavorite: false,
                context: "context"),
            ProductCard(
                name: "proizvod",
                price: "100din",
                imgPath: "assets/images/cookiechoco.jpg",
                added: true,
                isFavorite: false,
                context: "context"),
          ],
        ),
      ),
    );
  }
}
