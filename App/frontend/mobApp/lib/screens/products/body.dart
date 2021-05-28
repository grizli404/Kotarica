import 'package:app/components/progress_hud.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/kupovineModel.dart';
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
  List<Proizvod> proizvodiKorisnika = [];
  Korisnik korisnik;
  Body({this.assetPath, this.price, this.name, @required this.proizvod});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _rating;
  Proizvod proizvod;
  int idKorisnika;
  bool inAsyncCall = true;
  double ocenaProizvoda = 0;

  Future setupState() async {
    try {
      if (inAsyncCall == false)
        setState(() {
          inAsyncCall = true;
        });
      widget.korisnik = await Provider.of<KorisniciModel>(context)
          .dajKorisnikaZaId(widget.proizvod.idKorisnika);
      widget.proizvodiKorisnika =
          Provider.of<ProizvodiModel>(context, listen: false)
              .dajProizvodeZaKorisnika(widget.korisnik.id);

      setState(() {
        inAsyncCall = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.korisnik == null || widget.proizvodiKorisnika == null)
      setupState();
  }

  @override
  void didUpdateWidget(covariant Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    this.widget.korisnik = oldWidget.korisnik;
    this.widget.proizvodiKorisnika = oldWidget.proizvodiKorisnika;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _build(context), inAsyncCall: inAsyncCall);
  }

  Widget _build(BuildContext context) {
    if (inAsyncCall == true || widget.korisnik == null) {
      return Container();
    } else {
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

      KupovineModel kupovine = Provider.of<KupovineModel>(context);
      OceneModel ocene = Provider.of<OceneModel>(context);
      unesiOcenu(Korisnik korisnik, Proizvod proizvod, int ocena) async {
        int daLiPostojikupovina =
            await kupovine.daLiPostojiKupovinaZaOcenjivanjeProizvoda(
                korisnik.id, proizvod.idKorisnika, proizvod.id);
        if (daLiPostojikupovina != 0) {
          await ocene.oceniProizvod(
              daLiPostojikupovina, proizvod.idKorisnika, proizvod.id, ocena);
          print('uneta ocena ' + _rating.toString());
          return ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Uneli ste ocenu!")));
        } else
          return ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Niste kupili proizvod!")));
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
                //  Text(ocenaProizvoda.toString(), style: TextStyle(fontSize: 20)),
                FutureBuilder(
                  future: ocene.prosecnaOcenaZaProizvod(widget.proizvod.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('${snapshot.data}',
                          style: TextStyle(fontSize: 20));
                    } else
                      return Text('0', style: TextStyle(fontSize: 20));
                  },
                ),

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
            child: Text(
                widget.proizvod.cena.toString() +
                    ' RSD / ' +
                    widget.proizvod.jedinica,
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
                    onTap: () => buildConvo(),
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
              style:
                  TextStyle(color: Theme.of(context).hintColor, fontSize: 20),
            ),
          ),
          Rating((rating) {
            setState(() async {
              _rating = rating;
              // Korisnik k = await uzmiPodatke();
              if (korisnikInfo != null) {
                // unesi ocenu
                unesiOcenu(korisnikInfo, widget.proizvod, _rating);
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
                          'Korisnik : ${widget.korisnik.ime} ${widget.korisnik.prezime}',
                          style: TextStyle(
                              color: Theme.of(context).hintColor, fontSize: 20),
                        ),
                        onPressed: () => {
                              if (widget.korisnik != null)
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen(
                                            korisnik: widget.korisnik,
                                            proizvodi:
                                                widget.proizvodiKorisnika)))
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
  }

  void buildConvo() {
    if (korisnikInfo != null && widget.korisnik != null) {
      if (korisnikInfo.id != widget.korisnik.id)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ConversationScreen(sagovornik: widget.korisnik);
            },
          ),
        );
      else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Ne možete sebi poslati poruku"),
            duration: const Duration(milliseconds: 1500),
            width: MediaQuery.of(context).size.width *
                0.9, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    } else if (korisnikInfo == null) Navigator.of(context).pushNamed('/login');
  }

  Swiper imageSlider(context, Proizvod proizvod) {
    return new Swiper(
      autoplay: false,
      itemBuilder: (BuildContext context, int index) {
        if (proizvod.slika.isNotEmpty) {
          // for (int i = 0; i < proizvod.slika.length; i++) {
          return new Image.network(
            "https://ipfs.io/ipfs/" + widget.proizvod.slika[index],
            //  fit: BoxFit.fill,
          );
          //}
        } else {
          return new Image.asset(
            widget.assetPath,
          );
        }
        //return null;
      },
      itemCount: proizvod.slika.isNotEmpty ? proizvod.slika.length : 1,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: new SwiperPagination(
          margin: new EdgeInsets.only(left: 5.0, right: 5.0, top: 25)),
      //control: new SwiperControl(),
    );
  }
}
