import 'dart:html';
import 'package:app/components/product_card.dart';
import 'package:app/screens/products/products.dart';
import 'package:app/screens/profile/update_profile.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  final fName;
  final lName;
  final address;
  final reputationScore;

  const MyProfileScreen({
    Key key,
    this.fName = "Carl",
    this.lName = "Johnson",
    this.address = "Grove Street",
    this.reputationScore = "NA",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeOf(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(36),
        )),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://i.imgur.com/BoN9kdC.png"))),
                      ),
                    ),
                    RaisedButton(
                      color: kPrimaryColor,
                      child: Text(
                        "Izmeniti profil",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdateProfileForm(
                                fName: fName,
                                lName: lName,
                                address: address,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      "IME",
                      style: TextStyle(
                        color: kPrimaryColor,
                        letterSpacing: 2.0,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      fName,
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2.0,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "PREZIME",
                      style: TextStyle(
                        color: kPrimaryColor,
                        letterSpacing: 2.0,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      lName,
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2.0,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "ADRESA",
                      style: TextStyle(
                        color: kPrimaryColor,
                        letterSpacing: 2.0,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      address,
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2.0,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "REPUTACIJA",
                      style: TextStyle(
                        color: kPrimaryColor,
                        letterSpacing: 2.0,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      // star system
                      reputationScore,
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2.0,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                )
              ],
            ),
            Row(
              children: [
                ProductCard(
                    name: "proizvod",
                    price: "100din",
                    imgPath: "assets/images/cookiechoco.jpg",
                    added: true,
                    isFavorite: false,
                    context: "context"),
                ProductCard(
                    name: "proizvod",
                    price: "100din",
                    imgPath: "assets/images/cookiechoco.jpg",
                    added: true,
                    isFavorite: false,
                    context: "context"),
                ProductCard(
                    name: "proizvod",
                    price: "100din",
                    imgPath: "assets/images/cookiechoco.jpg",
                    added: true,
                    isFavorite: false,
                    context: "context"),
              ],
            ),
            SizedBox(height: 30.0),
            RaisedButton(
              child: Text(
                "Prikazi sve produkte",
                style: TextStyle(color: Colors.white),
              ),
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: (size.width / 2) - 85),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductList(
                        imeProizvodjaca: fName,
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
