import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/cupertino.dart';

class Cart {
  final Proizvod product;
  final int numOfItems;

  Cart({@required this.product, @required this.numOfItems});
}

List<Cart> demoCarts = [
  Cart(
      product: Proizvod(
          cena: 2,
          id: 1,
          idKategorije: 1,
          idKorisnika: 1,
          kolicina: 1,
          naziv: "asdf"),
      numOfItems: 1)
];
