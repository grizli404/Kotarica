import 'package:app/components/product_card.dart';
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
    ProizvodiModel proizvodi = Provider.of<ProizvodiModel>(context);
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

        //   SizedBox(height: 15.0)
        //   ],
        //   ),
        //
      ),
    );
  }
}
