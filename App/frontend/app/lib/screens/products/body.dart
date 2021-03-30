import 'package:app/screens/home/homeScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../model/cart.dart';
import '../../model/proizvodiModel.dart';
import 'components/rating.dart';

class Body extends StatefulWidget {
  final assetPath, price, name;
  final Proizvod proizvod;

  Body({this.assetPath, this.price, this.name, @required this.proizvod});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _rating;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
        ),
        SizedBox(height: 15.0),
        Hero(
            tag: widget.assetPath,
            child: Image.asset(widget.assetPath,
                height: 200.0, width: 150.0, fit: BoxFit.contain)),
        SizedBox(height: 20.0),
        Center(
          child: Text(widget.name,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(widget.price,
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text('Opis Opis Opis Opis Opis Opis Opis Opis Opis',
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
                    dodajJedanProizvodUKorpu(widget.proizvod);
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kPrimaryColor),
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
                          return null;
                        },
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kPrimaryColor),
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
            style: TextStyle(color: Color(0xFF575E67), fontSize: 20),
          ),
        ),
        Rating((rating) {
          setState(() {
            _rating = rating;
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
                  Text(
                    'Korisnik: Ime',
                    style: TextStyle(color: Color(0xFF575E67), fontSize: 20),
                  ),
                ]),
                TableRow(
                  children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Color(0xFF575E67),
                          ),
                          text: 'Svi proizvodi >>',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return null;
                                  },
                                ),
                              );
                            }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
