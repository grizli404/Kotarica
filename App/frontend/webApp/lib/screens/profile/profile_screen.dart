import 'package:app/components/product_card.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/conversation/conversation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../main.dart';

class ProfileScreen extends StatelessWidget {
  final Korisnik korisnik;
  final List<Proizvod> proizvodi;
  List<Container> kartice = [];
  ProfileScreen({Key key, this.korisnik, this.proizvodi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    for (Proizvod proizvod in proizvodi) {
      kartice.add(Container(
        height: 290,
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
    print(korisnik.slika);
    return Scaffold(
      appBar: AppBar(
        title: Text(korisnik.prezime + " " + korisnik.ime),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                            color: kPrimaryColor,
                          ),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: korisnik.slika != null
                                    ? NetworkImage("https://ipfs.io/ipfs/" +
                                        korisnik.slika)
                                    : AssetImage(
                                        "assets/images/defaultProfilePhoto.png"),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Ime  ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kPrimaryColor,
                                    ),
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
                                        fontSize: 16, color: kPrimaryColor),
                                  ),
                                  Text(
                                    korisnik.prezime,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "Adresa  ",
                                    style: TextStyle(
                                        fontSize: 16, color: kPrimaryColor),
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
                                        fontSize: 16, color: kPrimaryColor),
                                  ),
                                  Text(
                                    korisnik.brojTelefona,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "Email  ",
                                    style: TextStyle(
                                        fontSize: 16, color: kPrimaryColor),
                                  ),
                                  Text(
                                    korisnik.mail,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ResponsiveLayout.isIphone(context)
                        ? MediaQuery.of(context).size.width * 0.4
                        : MediaQuery.of(context).size.width * 0.3,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Theme.of(context).primaryColor),
                    child: InkWell(
                      // posalji poruku
                      onTap: () => {
                        if (korisnikInfo != null && korisnik != null)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ConversationScreen(
                                      sagovornik: korisnik);
                                },
                              ),
                            )
                          }
                        else
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Morate biti ulogovani da biste poslali poruku!"),
                              duration: const Duration(milliseconds: 2000),
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
                          )
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
                                  Icon(Icons.chat_outlined,
                                      color: Colors.white),
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
                  ),
                ],
              ),
              Divider(
                color: kPrimaryColor,
              ),
              Container(
                child: Text(
                  "Proizvodi korisnika " +
                      korisnik.ime +
                      " " +
                      korisnik.prezime,
                  style: TextStyle(color: kPrimaryColor, fontSize: 20),
                ),
              ),
              Wrap(children: kartice),
            ],
          ),
        ),
      ),
    );
  }
}
