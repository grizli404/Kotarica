import 'package:app/components/product_card.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/productView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ProfileScreen extends StatelessWidget {
  final Korisnik korisnik;
  final List<Proizvod> proizvodi;
  List<Container> kartice = [];

  ProfileScreen({Key key, this.korisnik, this.proizvodi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    for (Proizvod proizvod in proizvodi) {
      kartice.add(Container(
        height: 250,
        child: new ProductCard(
          context: "",
          added: true,
          isFavorite: false,
          name: proizvod.naziv,
          price: proizvod.cena.toString(),
          imgPath: "assets/images/cookiechoco.jpg",
          proizvod: proizvod,
        ),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(korisnik.prezime + " " + korisnik.ime),
      ),
      body: SingleChildScrollView(
        // child: Container(
        //   margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                Container(
                  width: 400,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/defaultProfilePhoto.png"),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Ime  ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                korisnik.ime,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Prezime  ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                korisnik.prezime,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Adresa  ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                korisnik.adresa,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Broj telefona  ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                korisnik.brojTelefona,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Email  ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                korisnik.mail,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
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
              ],
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            Container(
              child: Text(
                "Proizvodi korisnika " + korisnik.ime + " " + korisnik.prezime,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
              ),
            ),
            !ResponsiveLayout.isIphone(context)
                ? Wrap(children: kartice)
                : ProductView(listaProizvoda: proizvodi),
          ],
        ),
      ),
      //  ),
    );
  }
}
