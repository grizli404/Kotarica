import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/oceneModel.dart';
import 'package:app/screens/conversation/conversation_screen.dart';
import 'package:app/screens/profile/profile_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';
import '../../model/proizvodiModel.dart';
import 'components/rating.dart';

class Body extends StatefulWidget {
  final assetPath, price, name;
  final Proizvod proizvod;
  KorisniciModel kModel;
  ProizvodiModel pModel;
  List<Proizvod> proizvodiKorisnika;
  Korisnik korisnik;
  Body({this.assetPath, this.price, this.name, @required this.proizvod});

  @override
  _BodyState createState() => _BodyState(proizvod);
}

class _BodyState extends State<Body> {
  int _rating;
  Proizvod proizvod;

  _BodyState(Proizvod proizvod) {
    this.proizvod = proizvod;
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: true);
    //KorisniciModel k = Provider.of<KorisniciModel>(context);
    // Future<Korisnik> uzmiPodatke() async {
    //   var token = await FlutterSession().get('email');
    //   print("token " + token);
    //   if (token != '') {
    //     // print(token);
    //     Korisnik korisnik = await k.vratiKorisnikaMail(token);

    //     print("korisnik " + korisnik.ime);
    //     return korisnik;
    //   } else
    //     return null;
    // }

    OceneModel ocene = Provider.of<OceneModel>(context);
    unesiOcenu(Korisnik korisnik, Proizvod proizvod, int ocena) async {
      await ocene.oceniProizvod(korisnik.id, proizvod.idKategorije, proizvod.id,
          ocena, "komentar...");
    }

    return ListView(
      children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 25),
          child: Row(
            children: [
              Text('5', style: TextStyle(fontSize: 20)),
              Icon(
                Icons.star,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
        SizedBox(height: 15.0),
        Hero(
          tag: widget.proizvod.slika,
          child: Container(
              width: 150,
              constraints: BoxConstraints.expand(height: 200),
              child: imageSlider(context, widget.proizvod)),

          // height: 200,
          // child: Image(
          //   image:

          //    widget.proizvod.slika != ''
          //       ? NetworkImage(
          //           "https://ipfs.io/ipfs/" + widget.proizvod.slika)
          //       : AssetImage(
          //           widget.assetPath,

          //           // height: 200.0, width: 150.0, fit: BoxFit.contain
          //         ),
          // ),
          //   )

          //  Image.asset(widget.assetPath,
          //     height: 200.0, width: 150.0, fit: BoxFit.contain)
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text(widget.proizvod.naziv,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor)),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(widget.proizvod.cena.toString(),
              style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(widget.proizvod.opis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  // dodaj u korpu
                  onTap: () {
                    cart.dodajJedanProizvodUKorpu(widget.proizvod);

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Dodat 1 proizvod u korpu"),
                        duration: const Duration(milliseconds: 1500),
                        width: MediaQuery.of(context).size.width *
                            0.9, // Width of the SnackBar.
                        padding: const EdgeInsets.symmetric(
                          horizontal:
                              8.0, // Inner padding for SnackBar content.
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      width: ResponsiveLayout.isIphone(context)
                          ? MediaQuery.of(context).size.width * 0.4
                          : MediaQuery.of(context).size.width * 0.3,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Theme.of(context).primaryColor),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_basket,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Dodaj u korpu',
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                InkWell(
                  // posalji poruku
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ConversationScreen();
                        },
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      width: ResponsiveLayout.isIphone(context)
                          ? MediaQuery.of(context).size.width * 0.4
                          : MediaQuery.of(context).size.width * 0.3,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Theme.of(context).primaryColor),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_outlined, color: Colors.white),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Pošalji poruku',
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            'Ocenite proizvod: ',
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 20),
          ),
        ),
        Rating((rating) {
          setState(() async {
            _rating = rating;
            // Korisnik k = await uzmiPodatke();
            if (korisnikInfo != null) {
              // unesi ocenu
              unesiOcenu(korisnikInfo, widget.proizvod, _rating);
              print('uneta ocena ' + _rating.toString());
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Uneli ste ocenu!")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Morate biti prijavljeni da biste ocenili proizvod!")));
            }
          });
        }, 5),
        SizedBox(height: 30),
        Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Table(
              //defaultColumnWidth: FixedColumnWidth(15.0),
              border: TableBorder.all(color: Colors.grey),
              columnWidths: {0: FractionColumnWidth(.75)},
              children: [
                TableRow(children: [
                  TextButton(
                      child: Text(
                        'Korisnik: Mika Mikić',
                        style: TextStyle(
                            color: Theme.of(context).hintColor, fontSize: 20),
                      ),
                      onPressed: () async {
                        await setValues();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                    korisnik: widget.korisnik,
                                    proizvodi: widget.proizvodiKorisnika)));
                      }),
                ]),
                // TableRow(
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //           style: TextStyle(
                //             fontWeight: FontWeight.w500,
                //             fontStyle: FontStyle.italic,
                //             fontSize: 20,
                //             color: Theme.of(context).hintColor,
                //           ),
                //           text: 'Svi proizvodi >>',
                //           recognizer: TapGestureRecognizer()
                //             ..onTap = () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                   builder: (context) {
                //                     return null;
                //                   },
                //                 ),
                //               );
                //             }),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> setValues() async {
    widget.kModel = getKorisniciModel();
    widget.pModel = getProizvodiModel();
    widget.korisnik =
        await widget.kModel.dajKorisnikaZaId(widget.proizvod.idKorisnika);
    widget.proizvodiKorisnika =
        widget.pModel.dajProizvodeZaKorisnika(widget.proizvod.idKorisnika);
  }

  Swiper imageSlider(context, Proizvod proizvod) {
    return new Swiper(
      autoplay: false,
      itemBuilder: (BuildContext context, int index) {
        return proizvod.slika != ''
            ? new Image.network(
                "https://ipfs.io/ipfs/" + widget.proizvod.slika,
                //  fit: BoxFit.fill,
              )
            : new AssetImage(
                widget.assetPath,
              );
      },
      itemCount: 3,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: new SwiperPagination(
          margin: new EdgeInsets.only(left: 5.0, right: 5.0, top: 25)),
      //control: new SwiperControl(),
    );
  }
}
