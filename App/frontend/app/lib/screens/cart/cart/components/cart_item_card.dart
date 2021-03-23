import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;
  @override
  Widget build(BuildContext context) {
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
                    borderRadius: BorderRadius.circular(20)),
                child: SvgPicture.asset("assets/icons/shopping-basket.svg")),
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.product.price}",
                style: TextStyle(color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cart.numOfItems}",
                      style: TextStyle(color: kPrimaryColor)),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
