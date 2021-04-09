import 'package:app/components/responsive_layout.dart';
import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/products/productDetail.dart';
import 'package:flutter/material.dart';

import 'number_selector.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.name,
    @required this.price,
    @required this.imgPath,
    @required this.added,
    @required this.isFavorite,
    @required this.context,
    this.proizvod,
  }) : super(key: key);

  final String name;
  final String price;
  final String imgPath;
  final bool added;
  final bool isFavorite;
  final context;
  final Proizvod proizvod;

  @override
  Widget build(BuildContext context) {
    NumberSelector numberSelector = new NumberSelector();
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductDetail(
                      proizvod: proizvod,
                      assetPath: imgPath,
                      name: name,
                      price: price,
                    );
                  },
                ),
              );
            },
            child: Container(
                width: 150,
                height: ResponsiveLayout.isIphone(context) ? 200 : 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 2, color: Theme.of(context).dividerColor),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Theme.of(context).cardColor),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              isFavorite
                                  ? Icon(Icons.favorite, color: kPrimaryColor)
                                  : Icon(Icons.favorite_border,
                                      color: Theme.of(context).iconTheme.color)
                            ])),
                    Hero(
                        tag: imgPath,
                        child: Container(
                            height: 75.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.contain)))),
                    SizedBox(height: 7.0),
                    Text(price,
                        style: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Text(name,
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    // Padding(
                    //     padding: EdgeInsets.only(bottom: 5.0),
                    //     child:
                    //         Container(color: Color(0xFFEBEBEB), height: 1.0)),
                    NumberSelector(
                      proizvod: proizvod,
                    ),
                  ],
                ))));
  }
}
