import 'package:app/components/product_card.dart';
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
          children: List.generate(
            5,
            (index) {
              return ProductCard(
                  name: 'Proizvod 1',
                  price: '150din',
                  imgPath: 'assets/images/cookiechoco.jpg',
                  added: false,
                  isFavorite: false,
                  context: context);
            },
          ),
        ),

        //   SizedBox(height: 15.0)
        //   ],
        //   ),
        //
      ),
    );
  }
}
