import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/products/productDetail.dart';
import 'package:flutter/material.dart';

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
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite, color: kPrimaryColor)
                                : Icon(Icons.favorite_border,
                                    color: kPrimaryColor)
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
                          color: kPrimaryColor,
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //if (!added) ...[
                          Icon(Icons.shopping_basket,
                              color: kPrimaryColor, size: 12.0),
                          MaterialButton(
                            onPressed: () {
                              dodajJedanProizvodUKorpu(proizvod);
                            },
                            child: Text('Dodati u korpu',
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    color: kPrimaryColor,
                                    fontSize: 14.0)),
                          ),
                          //  ],
                          // if (added) ...[

                          // ]
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.remove_circle_outline,
                              color: kPrimaryColor, size: 12.0),
                          Text('3',
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                          Icon(Icons.add_circle_outline,
                              color: kPrimaryColor, size: 12.0),
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
