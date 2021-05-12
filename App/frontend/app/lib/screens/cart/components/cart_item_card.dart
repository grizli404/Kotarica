import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    Key key,
    @required this.cart,
    this.rebuild,
  }) : super(key: key);
  final Function rebuild;
  final Cart cart;

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                    image: widget.cart.product.slika != ''
                        ? DecorationImage(
                            image: NetworkImage("https://ipfs.io/ipfs/" +
                                widget.cart.product.slika))
                        : SvgPicture.asset(
                            "assets/icons/shopping-basket.svg"))),
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cart.product.naziv,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text.rich(
                TextSpan(
                    text: "${widget.cart.product.cena} RSD",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600),
                    children: [
                      // TextSpan(
                      //   text: " x",
                      //   style: TextStyle(color: Theme.of(context).hintColor),
                      // ),
                    ]),
              ),
              IconButton(
                color: widget.cart.numOfItems > 1
                    ? (Theme.of(context).colorScheme == ColorScheme.dark()
                        ? Colors.yellow
                        : Theme.of(context).accentColor)
                    : Colors.grey,
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 16.0,
                ),
                onPressed: widget.cart.numOfItems > 1
                    ? () {
                        setState(() {
                          widget.cart.numOfItems--;
                          widget.rebuild(() {});
                        });
                      }
                    : () {},
              ),
              Text.rich(
                TextSpan(
                  text: "${widget.cart.numOfItems}",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Colors.yellow
                    : Theme.of(context).accentColor,
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 16.0,
                ),
                onPressed: () {
                  setState(() {
                    widget.cart.numOfItems++;
                    widget.rebuild(() {});
                  });
                },
              )
            ]),
          ],
        ),
        Expanded(
          child: SizedBox(),
        ),
        if (isWeb) ...[
          IconButton(
            hoverColor: Theme.of(context).primaryColor,
            tooltip: 'Izbaci iz korpe',
            icon: Icon(
              Icons.delete_outline,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () => widget.rebuild(() {
              int index = cart.demoCarts.indexOf(widget.cart);
              Cart carty = cart.removeProduct(index);
              ScaffoldMessenger.of(context)
                  .removeCurrentSnackBar(reason: SnackBarClosedReason.remove);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(
                    label: "Vrati ${carty.product.naziv} u korpu!",
                    onPressed: () => widget
                        .rebuild(() => cart.insertProductAtIndex(index, carty)),
                  ),
                  content: Text("Uklonili ste ${carty.product.naziv}"),
                  duration: const Duration(milliseconds: 5000),
                  width: MediaQuery.of(context).size.width *
                      0.9, // Width of the SnackBar.
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, // Inner padding for SnackBar content.
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            }),
          )
        ]
      ],
    );
  }
}
