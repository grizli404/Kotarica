import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/homeScreenLayout.dart';
import 'package:flutter/cupertino.dart';

import 'proizvodiModel.dart';

class Carts extends ChangeNotifier {
  List<Cart> demoCarts = [];

  void dodajProizvod(Proizvod proizvod, int n) {
    bool ind = true;
    for (int i = 0; i < demoCarts.length; i++) {
      if (demoCarts[i].product.id == proizvod.id) {
        demoCarts[i].numOfItems += n;
        ind = false;
        break;
      }
    }
    if (ind) {
      demoCarts.add(Cart(numOfItems: n, product: proizvod));
    }

    notifyListeners();
  }

  double sumTotal(List<Cart> demoCarts) {
    double total = 0;
    demoCarts.forEach((Cart cart) {
      total += cart.product.cena * cart.numOfItems;
    });
    return total;
  }

  void dodajJedanProizvodUKorpu(Proizvod proizvod) {
    bool ind = true;
    for (int i = 0; i < demoCarts.length; i++) {
      if (demoCarts[i].product.id == proizvod.id) {
        demoCarts[i].numOfItems++;
        ind = false;
        break;
      }
    }
    if (ind) {
      demoCarts.add(Cart(numOfItems: 1, product: proizvod));
    }
    notifyListeners();
  }

//Uklanja proizvod iz korpe i renovira prikaz cartIcon-a, za prosledjenu poziciju proizvoda u korpi ili tacno proizvod koji zelimo da uklonimo
  Cart removeProduct(Object index) {
    Cart cart;
    if (index is int) {
      cart = demoCarts.removeAt(index);
    } else {
      demoCarts.remove(index);
    }
    notifyListeners();
    return cart;
  }

  void insertProductAtIndex(index, Cart cart) {
    demoCarts.insert(index, cart);
    notifyListeners();
  }
}

class Cart {
  final Proizvod product;
  int numOfItems;

  Cart({@required this.product, @required this.numOfItems});
}
