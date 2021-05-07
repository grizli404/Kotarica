import 'package:app/components/responsive_layout.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ProfileScreen extends StatelessWidget {
  final Korisnik korisnik;

  const ProfileScreen({Key key, this.korisnik}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(korisnik.ime + " " + korisnik.prezime),
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
                            Row(
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
                            Row(
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
                color: kPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
