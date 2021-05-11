import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/material.dart';
import 'package:app/model/cart.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({
    Key key,
  }) : super(key: key);

  @override
  CartIconState createState() => CartIconState();
}

class CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
        icon: Icon(
          Icons.shopping_cart_outlined,
        ),
        onPressed: () {
          setCartIcon();
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
            demoCarts.length.toString(),
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
      )
    ]);
  }

  void setCartIcon() {
    setState(() {});
  }
}
