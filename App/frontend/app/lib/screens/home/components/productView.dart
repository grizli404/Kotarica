import 'package:app/components/product_card.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/constants.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({this.listaProizvoda});
  final List<Proizvod> listaProizvoda;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height - 100.0,
        child: Stack(children: [
          GridView.count(
            //  physics: NeverScrollableScrollPhysics(),
            crossAxisCount: ResponsiveLayout.isIphone(context)
                ? 2
                : (MediaQuery.of(context).size.width / 250).round(),
            //primary: false,
            // crossAxisSpacing: 5.0,
            //  mainAxisSpacing: 10.0,
            childAspectRatio: ResponsiveLayout.isIphone(context) ? 0.7 : 0.8,
            children: List.generate(
              listaProizvoda.length,
              (index) {
                return ProductCard(
                    name: listaProizvoda[index].naziv,
                    price: listaProizvoda[index].cena.toString(),
                    imgPath: 'assets/images/cookiechoco.jpg',
                    added: false,
                    isFavorite: false,
                    context: context,
                    proizvod: listaProizvoda[index]);
              },
            ),
          ),
        ]));
  }
}
