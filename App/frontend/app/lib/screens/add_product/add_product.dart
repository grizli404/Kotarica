import 'package:app/components/input_fields.dart';

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
            InputFieldNotValidated(field: " ", title: "Naziv"),
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
