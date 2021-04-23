//import 'dart:html';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/product_card.dart';
import 'package:app/screens/add_product/add_product.dart';
import 'package:app/screens/notifications/notification_screen.dart';
import 'package:app/screens/products/products.dart';
import 'package:app/screens/profile/update_profile.dart';
import 'package:flutter/gestures.dart';

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
      body: ProfileBody(
        size: size,
        fName: fName,
        address: address,
        lName: lName,
        reputationScore: reputationScore,
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final fName;
  final lName;
  final address;
  final reputationScore;
  final Size size;

  const ProfileBody({
    Key key,
    this.fName,
    this.lName,
    this.address,
    this.reputationScore,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size.width < 550) {
      return ThinProfileBody(
        address: address,
        fName: "Thin",
        lName: lName,
        reputationScore: reputationScore,
      );
    } else if (size.width < 850) {
      return MediumProfileBody(
        address: address,
        fName: "Medium",
        lName: lName,
        reputationScore: reputationScore,
      );
    } else {
      return WideProfileBody(
        address: address,
        fName: "Wide",
        lName: lName,
        reputationScore: reputationScore,
      );
    }
  }
}

class ThinProfileBody extends StatelessWidget {
  final fName;
  final lName;
  final address;
  final reputationScore;

  const ThinProfileBody({
    Key key,
    this.fName,
    this.lName,
    this.address,
    this.reputationScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeOf(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          focusColor: kPrimaryColor,
                          hoverColor: kPrimaryColorHover,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddProduct();
                            }));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications_active),
                          focusColor: kPrimaryColor,
                          hoverColor: kPrimaryColorHover,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return NotificationScreen();
                              }),
                            );
                          },
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
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
                                image: AssetImage(
                                    "assets/images/defaultProfilePhoto.png"))),
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
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.0),
                        Container(
                            child: Text("DESCRIPTION",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  letterSpacing: 2.0,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Container(
                          child: Text("???"),
                        ),
                      ],
                    )),
                    SizedBox(height: 50.0),
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

class MediumProfileBody extends StatelessWidget {
  final fName;
  final lName;
  final address;
  final reputationScore;

  const MediumProfileBody({
    Key key,
    this.fName,
    this.lName,
    this.address,
    this.reputationScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeOf(context).size;
    return SingleChildScrollView(
      child: Padding(
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
                    FloatingActionButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddProduct();
                      }));
                    }),
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
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    Container(
                        child: Text("DESCRIPTION",
                            style: TextStyle(
                              color: kPrimaryColor,
                              letterSpacing: 2.0,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ))),
                    Container(
                      child: Text("???"),
                    ),
                  ],
                )),
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

class WideProfileBody extends StatelessWidget {
  final fName;
  final lName;
  final address;
  final reputationScore;

  const WideProfileBody({
    Key key,
    this.fName,
    this.lName,
    this.address,
    this.reputationScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeOf(context).size;
    return SingleChildScrollView(
      child: Padding(
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NotificationScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    FloatingActionButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddProduct();
                      }));
                    }),
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
                ),
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    Container(
                        child: Text("DESCRIPTION",
                            style: TextStyle(
                              color: kPrimaryColor,
                              letterSpacing: 2.0,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ))),
                    Container(
                      child: Text("???"),
                    ),
                  ],
                )),
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
