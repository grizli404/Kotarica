//import 'dart:html';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/product_card.dart';
import 'package:app/components/star_display.dart';
import 'package:app/screens/profile/update_profile.dart';
import 'package:app/main.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  String fName = "";
  String lName = "";
  String address = "";
  int reputationScore = 0;
  String profilePhoto;
  int id;
  List<Proizvod> proizvodi = [];
  List<Container> proizvodiKartice = [];

  MyProfileScreen() {
    if (korisnikInfo != null) {
      this.fName = korisnikInfo.ime;
      this.lName = korisnikInfo.prezime;
      this.address = korisnikInfo.adresa;
      this.id = korisnikInfo.id;
      this.reputationScore = 1;
      proizvodi = proizvodiModel.dajProizvodeZaKorisnika(this.id);
      print("Ime:" + this.fName + " id:" + this.id.toString());
      print("Broj proizvoda:" + proizvodi.length.toString());
      for (Proizvod proizvod in proizvodi) {
        print("Proizvod: " + proizvod.naziv);
        proizvodiKartice.add(Container(
            height: 290,
            child: ProductCard(
              added: true,
              context: "",
              isFavorite: false,
              name: proizvod.naziv,
              price: proizvod.cena.toString(),
              proizvod: proizvod,
              imgPath: proizvod.slika[0],
            )));
      }
    } else {
      print("Nije ulogovan korisnik");
      //na login.
    }
  }

  @override
  Widget build(BuildContext context) {
    if (korisnikInfo != null) print(korisnikInfo.ime);

    Size size = MediaQuery.maybeOf(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //   bottom: Radius.circular(36),
        // )),
      ),
      body: ProfileBody(
        proizvodiKartice: proizvodiKartice,
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
  final List<Container> proizvodiKartice;
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
    this.proizvodiKartice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size.width < 550) {
      return ThinProfileBody(
        proizvodiKartice: proizvodiKartice,
        id: id,
        address: address,
        fName: fName,
        lName: lName,
        reputationScore: reputationScore,
      );
    } else {
      return WideProfileBody(
        proizvoidKartice: proizvodiKartice,
        address: address,
        fName: fName,
        lName: lName,
        reputationScore: reputationScore,
      );
    }
  }
}

class ThinProfileBody extends StatelessWidget {
  final List<Container> proizvodiKartice;
  final fName;
  final lName;
  final address;
  final reputationScore;
  final int id;

  ThinProfileBody({
    Key key,
    this.id,
    this.fName,
    this.lName,
    this.address,
    this.reputationScore,
    this.proizvodiKartice,
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
                    // await pickImage(false);
                    // int i;
                    // i = await korisniciModel.dodajSliku(korisnikInfo.id, slika);
                    // print("Zavrsio :" + i.toString());
                  },
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
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
            Column(
              children: [
                Text(
                  "Proizvodi:",
                  style: TextStyle(fontSize: 32, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[850],
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
                    child: Center(
                      child: Wrap(
                        children: proizvodiKartice,
                      ),
                    ),
                  ),
                ),
              ],
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
  final List<Container> proizvoidKartice;
  const WideProfileBody({
    Key key,
    this.fName,
    this.lName,
    this.address,
    this.reputationScore,
    this.proizvoidKartice,
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
          ),
        ),
        Column(
          children: [
            Text(
              "Proizvodi:",
              style: TextStyle(fontSize: 32, color: kPrimaryColor),
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration:
                  BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
                BoxShadow(
                  color: Colors.grey[850],
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ]),
              constraints: BoxConstraints(
                maxWidth: size.width - 360,
                minWidth: size.width - 370,
              ),
              height: size.height - 140,
              child: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    children: proizvoidKartice,
                  ),
                ),
              ),
            ),
          ],
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
              color: Theme.of(context).primaryColor,
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey[850],
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).cardColor,
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
                broj: korisnikInfo.brojTelefona,
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
