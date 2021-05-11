import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/material.dart';
import 'package:app/model/cart.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Consumer<Carts>(
      builder: (context, cart, _) {
        return Stack(children: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
          Positioned(
            right: 7,
            top: 5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
              child: Text(
                cart.demoCarts.length.toString(),
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          )
        ]);
      },
    );
  }
}
