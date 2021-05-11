//import 'dart:html';
import 'dart:io';

import 'package:app/components/navigationBar.dart';
import 'package:app/components/product_card.dart';
import 'package:app/components/rad_sa_slikama.dart';
import 'package:app/components/star_display.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/screens/add_product/add_product.dart';
import 'package:app/screens/notifications/notification_screen.dart';
import 'package:app/screens/products/products.dart';
import 'package:app/screens/profile/profile_screen.dart';
import 'package:app/screens/profile/update_profile.dart';
import 'package:app/main.dart';
import 'package:app/theme/themeProvider.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  String fName = "";
  String lName = "";
  String address = "";
  int reputationScore = 0;
  String profilePhoto;
  int id;

  @override
  Widget build(BuildContext context) {
    if (korisnikInfo != null) print(korisnikInfo.ime);

    this.fName = korisnikInfo.ime;
    this.lName = korisnikInfo.prezime;
    this.address = korisnikInfo.adresa;
    this.id = korisnikInfo.id;
    this.reputationScore = 1; //funkcija

    Size size = MediaQuery.maybeOf(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //   bottom: Radius.circular(36),
        // )),
      ),
      body: ProfileBody(
        size: size,
        id: id,
        fName: fName,
        address: address,
        lName: lName,
        reputationScore: reputationScore,
      ),
      bottomNavigationBar: !isWeb ? NavigationBarWidget() : null,
    );
  }
}

class ProfileBody extends StatelessWidget {
  final fName;
  final lName;
  final address;
  final reputationScore;
  final Size size;
  final int id;

  const ProfileBody({
    Key key,
    this.id,
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
        id: id,
        address: address,
        fName: fName,
        lName: lName,
        reputationScore: reputationScore,
      );
    } else {
      return WideProfileBody(
        address: address,
        fName: fName,
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
  final int id;

  const ThinProfileBody({
    Key key,
    this.id,
    this.fName,
    this.lName,
    this.address,
    this.reputationScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String slika;
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
                        // IconButton(
                        //   icon: Icon(Icons.notifications_active),
                        //   focusColor: kPrimaryColor,
                        //   hoverColor: kPrimaryColorHover,
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) {
                        //         return NotificationScreen();
                        //       }),
                        //     );
                        //   },
                        // )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          focusColor: kPrimaryColor,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddProduct();
                            }));
                          },
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
                                    "assets/images/defaultProfilePhoto.png"),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_photo_alternate_outlined),
                          onPressed: () async {
                            var file = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            print("Loading image...");
                            var _image = File(file.path);
                            print("Uploading image image...");
                            SnackBar(
                              content: Text("Loading image..."),
                            );
                            var res = await uploadImage(_image);
                            print("image: " + res);
                            slika = res;
                            KorisniciModel k = new KorisniciModel();
                            k.dodajSliku(id, slika);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyProfileScreen();
                                },
                              ),
                            );
                          },
                        )
                      ],
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
                    StarDisplayWidget(
                        filledStar: Icon(Icons.star),
                        unfilledStar: Icon(Icons.star_border),
                        value: reputationScore),
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
    return Container(
        child: Row(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
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
                                "assets/images/defaultProfilePhoto.png"),
                          ),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.add_photo_alternate_outlined),
                    //   onPressed: () async {
                    //     var file = await ImagePicker()
                    //         .getImage(source: ImageSource.gallery);
                    //     print("Loading image...");
                    //     var _image = File(file.path);
                    //     print("Uploading image image...");
                    //     SnackBar(
                    //       content: Text("Loading image..."),
                    //     );
                    //     var res = await uploadImage(_image);
                    //     print("image: " + res);
                    //     slika = res;
                    //     KorisniciModel k = new KorisniciModel();
                    //     k.dodajSliku(id, slika);
                    //     Navigator.pop(context);
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return MyProfileScreen();
                    //         },
                    //       ),
                    //     );
                    //   },
                    // )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ime i prezime",
                        style: TextStyle(fontSize: 32, color: kPrimaryColor),
                      ),
                      Text(fName + " " + lName,
                          style: TextStyle(fontSize: 26, color: Colors.grey)),
                      Divider(
                        color: kPrimaryColor,
                      ),
                      Text(
                        "Adresa",
                        style: TextStyle(fontSize: 32, color: kPrimaryColor),
                      ),
                      Text(address,
                          style: TextStyle(fontSize: 26, color: Colors.grey)),
                      Divider(
                        color: kPrimaryColor,
                      ),
                      Text(
                        "Reputacija",
                        style: TextStyle(fontSize: 32, color: kPrimaryColor),
                      ),
                      StarDisplayWidget(
                          filledStar: Icon(Icons.star),
                          unfilledStar: Icon(Icons.star_border),
                          value: reputationScore),
                      Divider(
                        color: kPrimaryColor,
                      ),
                      ProfileButton(
                        fName: fName,
                        lName: lName,
                        address: address,
                      )
                    ],
                  ),
                )
              ],
            )),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.grey.shade900, boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
          constraints: BoxConstraints(
            maxWidth: size.width - 360,
            minWidth: size.width - 370,
          ),
          height: size.height - 40,
          child: SingleChildScrollView(
            child: Wrap(
              children: testScroll,
            ),
          ),
        )
      ],
    ));
  }
}

class ProfileButton extends StatelessWidget {
  final String fName;
  final String lName;
  final String address;

  const ProfileButton({Key key, this.fName, this.lName, this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        height: 35,
        width: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              color: kPrimaryColor,
            ),
            Text(
              "Izmeni Profil",
              style: TextStyle(
                fontSize: 22,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[900],
        ),
      ),
      onTap: () {
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
    );
  }
}

List<ProductCard> testScroll = [
  ProductCard(
      name: "Jabuke",
      price: "100",
      imgPath: "assets/images/cookiechoco.jpg",
      added: true,
      isFavorite: false,
      context: ""),
  ProductCard(
      name: "Kruske",
      price: "100",
      imgPath: "assets/images/cookiechoco.jpg",
      added: true,
      isFavorite: false,
      context: ""),
  ProductCard(
      name: "Sljive",
      price: "100",
      imgPath: "assets/images/cookiechoco.jpg",
      added: true,
      isFavorite: false,
      context: ""),
];
