import 'package:app/components/responsive_layout.dart';
import 'package:app/constants.dart';
import 'package:app/main.dart';
import 'package:app/model/listaZeljaModel.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/products/productDetail.dart';
import 'package:flutter/material.dart';

import '../model/listaZeljaModel.dart';
import 'number_selector.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key key,
    @required this.name,
    @required this.price,
    @required this.imgPath,
    @required this.added,
    @required this.isFavorite,
    @required this.context,
    this.proizvod,
  }) {
    this.lzModel = new ListaZeljaModel();
  }

  ListaZeljaModel lzModel;
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
                      //  name: name,
                      //   price: price,
                    );
                  },
                ),
              );
            },
            child: Container(
                width: ResponsiveLayout.isIphone(context) ? 180 : 180,
             //   height: ResponsiveLayout.isIphone(context) ? 210 : 250,
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
                                  : IconButton(
                                      icon: Icon(Icons.favorite_border,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color),
                                      onPressed: () async {
                                        if (korisnikInfo != null) {
                                          print("Stavljen u omiljene");
                                          await lzModel.lajkovanje(
                                              korisnikInfo.id, proizvod.id);
                                          print("Proso");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Proizvod dodat u omiljene"),
                                          ));
                                        } else {
                                          print("Niste ulogovani");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text("Niste prijavljeni"),
                                          ));
                                        }
                                      })
                            ])),
                    Hero(
                        tag: imgPath,
                        child: Container(
                          height: 75.0,
                          width: 75.0,
                          //  decoration: BoxDecoration(
                          //      image: DecorationImage(
                          child: proizvod.slika.isNotEmpty
                              ? Image.network(
                                  "http://147.91.204.116:11099/ipfs/" +
                                      proizvod.slika.first,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : Image.asset(imgPath),
                        )),
                    SizedBox(height: 7.0),
                    Text(price + ' RSD',
                        style: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Text(name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
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
