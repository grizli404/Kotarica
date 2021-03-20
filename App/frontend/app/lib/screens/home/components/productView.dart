import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //backgroundColor: Color(0xFFFCFAF8),
      //child: ListView(
      // children: <Widget>[
      //    SizedBox(height: 15.0),
      //child: Container(
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.all(10.0),
      //margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      width: MediaQuery.of(context).size.width - 30.0,
      height: MediaQuery.of(context).size.height - 100.0,
      child: Container(
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: (MediaQuery.of(context).size.width / 180.0).round(),
          primary: false,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.8,
          children: <Widget>[
            _buildCard('Proizvod 1', '150din', 'assets/images/cookiechoco.jpg',
                false, false, context),
            _buildCard('Proizvod 1', '150din', 'assets/images/cookiechoco.jpg',
                false, true, context),
            _buildCard('Proizvod 1', '150din', 'assets/images/cookiechoco.jpg',
                false, false, context),
            _buildCard('Proizvod 1', '150din', 'assets/images/cookiechoco.jpg',
                false, false, context),
            _buildCard('Proizvod 1', '150din', 'assets/images/cookiechoco.jpg',
                false, false, context),
          ],
        ),

        //   SizedBox(height: 15.0)
        //   ],
        //   ),
        //
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {},
            child: Container(
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
                          Text('Dodati u korpu',
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  color: kPrimaryColor,
                                  fontSize: 14.0))
                          //  ],
                          // if (added) ...[
                          //   Icon(Icons.remove_circle_outline,
                          //       color: kPrimaryColor, size: 12.0),
                          //   Text('3',
                          //       style: TextStyle(
                          //           fontFamily: 'Varela',
                          //           color: kPrimaryColor,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 12.0)),
                          //   Icon(Icons.add_circle_outline,
                          //       color: kPrimaryColor, size: 12.0),
                          // ]
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
