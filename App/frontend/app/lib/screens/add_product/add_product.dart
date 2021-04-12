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
      body: Container(
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () async {
                var file =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                var _image = File(file.path);
                var res = await uploadImage(_image);
                print(res);
                slika = res;
              },
              child: Icon(Icons.add),
            ),
            InputFieldNotValidated(field: " ", title: "Naziv"),
            InputFieldNotValidated(field: " ", title: "Kolicina"),
            InputFieldNotValidated(field: " ", title: "Cena"),
            InputFieldNotValidated(field: " ", title: "Opis"),
            InputFieldNotValidated(field: " ", title: "Kategorija (comboBox)"),
            RaisedButton(
              child: Text(
                "Postavi proizvod",
                style: TextStyle(color: Colors.white),
              ),
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: (size.width / 2) - 85),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
