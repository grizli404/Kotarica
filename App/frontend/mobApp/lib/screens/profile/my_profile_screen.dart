//import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as http;
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
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () async {
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
                        image:
                            AssetImage("assets/images/defaultProfilePhoto.png"),
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
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration:
                  BoxDecoration(color: Colors.grey.shade900, boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ]),
              constraints: BoxConstraints(
                maxWidth: size.width - 10,
                minWidth: size.width - 20,
              ),
              height: size.height - 40,
              child: SingleChildScrollView(
                  // child: Center(
                  //   child: Wrap(
                  //     children: testScroll,
                  //   ),
                  // ),
                  ),
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
              // child: Center(
              //   child: Wrap(
              //     children: testScroll,
              //   ),
              // ),
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

List<Container> testScroll = [
  Container(
    height: 290,
    child: ProductCard(
        name: "Jabuke",
        price: "100",
        imgPath: "assets/images/cookiechoco.jpg",
        added: true,
        isFavorite: false,
        context: ""),
  ),
  Container(
    height: 290,
    child: ProductCard(
        name: "Kruske",
        price: "100",
        imgPath: "assets/images/cookiechoco.jpg",
        added: true,
        isFavorite: false,
        context: ""),
  ),
  Container(
    height: 290,
    child: ProductCard(
        name: "Sljive",
        price: "100",
        imgPath: "assets/images/cookiechoco.jpg",
        added: true,
        isFavorite: false,
        context: ""),
  ),
];
