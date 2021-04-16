import 'dart:io';

import 'package:app/components/input_fields.dart';
import 'package:app/components/rad_sa_slikama.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  final String korisnik;

  const AddProduct({
    Key key,
    this.korisnik,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String slika = null;
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
                          image: AssetImage(
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
                  var _image = File(file.path);
                  var res = await uploadImage(_image);
                  print(res);
                  slika = res;
                },
              ),
              InputFieldNotValidated(field: " ", title: "Naziv"),
              InputFieldNotValidated(field: " ", title: "Kolicina"),
              InputFieldNotValidated(field: " ", title: "Cena"),
              InputFieldNotValidated(field: " ", title: "Opis"),
              InputFieldNotValidated(
                  field: " ", title: "Kategorija (comboBox)"),
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
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
