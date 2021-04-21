import 'dart:io';

import 'package:app/components/input_fields.dart';
import 'package:app/components/rad_sa_slikama.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

String slika = "0";

class AddProduct extends StatefulWidget {
  final String korisnik;

  const AddProduct({
    Key key,
    this.korisnik,
  }) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    ValueChanged<String> naziv;
    ValueChanged<String> kolicina;
    ValueChanged<String> cena;
    ValueChanged<String> opis;
    ValueChanged<String> kategorija;
    Size size = MediaQuery.maybeOf(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodavanje proizvoda"),
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(36),
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
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
                          image: slika != "0"
                              ? NetworkImage("https://ipfs.io/ipfs/" + slika)
                              : AssetImage(
                                  "assets/images/defaultProductPhoto.jpg"))),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                focusColor: kPrimaryColor,
                hoverColor: kPrimaryColorHover,
                onPressed: () async {
                  var file =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  print("Loading image...");
                  var _image = File(file.path);
                  print("Uploading image image...");
                  SnackBar(
                    content: Text("Loading image..."),
                  );
                  var res = await uploadImage(_image);
                  print("image: " + res);
                  slika = res;
                  setState(() {});
                },
              ),
              InputFieldNotValidated(field: naziv, title: "Naziv"),
              InputFieldNotValidated(field: kolicina, title: "Kolicina"),
              InputFieldNotValidated(field: cena, title: "Cena"),
              InputFieldNotValidated(field: opis, title: "Opis"),
              InputFieldNotValidated(
                  field: kategorija, title: "Kategorija comboBox"),
              RaisedButton(
                child: Text(
                  "Postavi proizvod",
                  style: TextStyle(color: Colors.white),
                ),
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: (size.width / 2) - 85),
                onPressed: () {
                  ProizvodiModel().dodajProizvod(
                      1,
                      int.parse(kategorija.toString()),
                      naziv.toString(),
                      int.parse(kolicina.toString()),
                      int.parse(cena.toString()),
                      slika);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
