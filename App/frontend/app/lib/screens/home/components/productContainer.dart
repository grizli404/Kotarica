import 'package:app/components/product_card.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class ProductContainer extends StatelessWidget {
  String naziv;

  ProductContainer({@required this.naziv});

  @override
  Widget build(BuildContext context) {
    ProizvodiModel proizvodi = Provider.of<ProizvodiModel>(context);
    return Container(
      height: 350,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: labelContainer(naziv.toString()),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: appsContainer(proizvodi, context),
          ),
        ],
      ),
    );
  }
}

Widget labelContainer(String labelVal) {
  return Container(
    height: 30.0,
    child: Row(
      mainAxisAlignment:
          isWeb ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (isWeb) ...[
          Expanded(
              child: Divider(
            height: 5,
            thickness: 4,
          )),
          Text(
            '     ' + labelVal + '      ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0),
          ),
          Expanded(
              child: Divider(
            height: 5,
            thickness: 4,
          ))
        ] else if (!isWeb) ...[
          Text(
            labelVal,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
        ]
      ],
    ),
  );
}

Widget appsContainer(ProizvodiModel proizvodi, BuildContext context) {
  return Container(
    height: ResponsiveLayout.isIphone(context) ? 290 : 250.0,
    //200.0,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: proizvodi.listaProizvoda.length,
      itemBuilder: (context, index) {
        return ProductCard(
            name: proizvodi.listaProizvoda[index].naziv,
            price: proizvodi.listaProizvoda[index].cena.toString(),
            imgPath: 'assets/images/cookiechoco.jpg',
            added: false,
            isFavorite: false,
            context: context,
            proizvod: proizvodi.listaProizvoda[index]);
      },
    ),
  );
}
