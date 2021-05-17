import 'package:app/model/cart.dart';
import 'package:app/model/personal_data.dart';
import 'package:app/screens/cart/components/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class ConfirmConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: false);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        children: [
          // Divider(
          //   thickness: 3,
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Ime: "),
          //       _Vrednost(text: personalData.ime)
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Kontakt: "),
          //       _Vrednost(text: personalData.kontakt)
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Postanski broj: "),
          //       _Vrednost(text: personalData.postanskiBroj),
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       _Atribut(text: "Adresa: "),
          //       _Vrednost(text: personalData.adresa)
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
          // // Container(
          // //   height: 60,
          // //   child: Row(
          // //     children: [
          // //       _Atribut(text: "opis: "),
          // //       _Vrednost(text: personalData.opis)
          // //     ],
          // //   ),
          // // ),
          // // Divider(
          // //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          // //       ? Colors.black
          // //       : kPrimaryColor,
          // // ),
          // Container(
          //   height: 60,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       _Atribut(text: "Privatni kljuc: "),
          //       _Vrednost(
          //           text:
          //               "${personalData.privateKey.substring(0, 4) + personalData.privateKey.replaceRange(0, personalData.privateKey.length, '*' * (personalData.privateKey.length - 4))}")
          //     ],
          //   ),
          // ),
          // Divider(
          //   thickness: 3,
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),

          for (Cart item in cart.demoCarts) ...{
            CheckoutItemCard(
              cart: item,
            ),
            SizedBox(
              height: 10,
            ),
          },
          SizedBox(
            height: 10,
          ),
          _Atribut(
            text: "Ukupno: ${cart.sumTotal(cart.demoCarts)} RSD",
          ),
          // Divider(
          //   thickness: 3,
          //   color: Theme.of(context).colorScheme == ColorScheme.dark()
          //       ? Colors.black
          //       : kPrimaryColor,
          // ),
        ],
      ),
    );
  }
}

class _Atribut extends StatelessWidget {
  _Atribut({@required this.text});
  final text;
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      maxLines: 2,
    );
  }
}

class _Vrednost extends StatelessWidget {
  _Vrednost({@required this.text});

  final text;
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text != '' ? "${text}" : '-',
        style: TextStyle(
          fontSize: 16,
        ),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

class CheckoutItemCard extends StatelessWidget {
  const CheckoutItemCard({
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
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    image: cart.product.slika != ''
                        ? DecorationImage(
                            image: NetworkImage(
                                "https://ipfs.io/ipfs/" + cart.product.slika))
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
              cart.product.naziv,
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
                    text: "${cart.product.cena} RSD x ${cart.numOfItems}",
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
            ]),
          ],
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
