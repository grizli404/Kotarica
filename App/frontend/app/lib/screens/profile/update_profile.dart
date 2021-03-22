import 'package:app/components/input_fields.dart';
import 'package:app/components/rounded_button.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class UpdateProfileForm extends StatelessWidget {
  final String fName;
  final String lName;
  final String address;

  const UpdateProfileForm({
    Key key,
    @required this.fName,
    @required this.lName,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Izmenite profil"),
      ),
      body: Container(
        child: Column(
          children: [
            InputFieldNotValidated(
              field: fName,
              title: "IME",
            ),
            InputFieldNotValidated(
              field: lName,
              title: "PREZIME",
            ),
            InputFieldNotValidated(
              field: address,
              title: "ADRESA",
            ),
            RoundedButton(
              press: () {}, //submit funkcija
              text: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}
