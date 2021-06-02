import 'package:app/components/input_fields.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/main.dart';
import 'package:app/model/korisniciModel.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class UpdateProfileForm extends StatelessWidget {
  final String fName;
  final String lName;
  final String address;
  final String broj;
  KorisniciModel kModel = getKorisniciModel();

  UpdateProfileForm({
    Key key,
    @required this.fName,
    @required this.lName,
    @required this.address,
    @required this.broj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imeController = TextEditingController();
    final prezimeController = TextEditingController();
    final brojController = TextEditingController();
    final adresaController = TextEditingController();
    imeController.text = fName;
    prezimeController.text = lName;
    brojController.text = broj;
    adresaController.text = address;

    return Scaffold(
      appBar: AppBar(
        title: Text("Izmenite profil"),
      ),
      body: Container(
        child: Column(
          children: [
            InputFieldNotValidated(
              myController: imeController,
              title: "IME",
              maxLen: 40,
            ),
            InputFieldNotValidated(
              myController: prezimeController,
              title: "PREZIME",
              maxLen: 40,
            ),
            InputFieldNotValidated(
              myController: brojController,
              title: "ADRESA",
              maxLen: 15,
            ),
            InputFieldNotValidated(
              myController: adresaController,
              title: "ADRESA",
              maxLen: 100,
            ),
            RoundedButton(
              press: () async {
                print("izmeni:" +
                    " " +
                    imeController.text +
                    " " +
                    prezimeController.text +
                    " " +
                    brojController.text +
                    " " +
                    adresaController.text);
                _openLoadingDialog(context);
                await kModel.izmeniKorisnika(
                    korisnikInfo.id,
                    imeController.text,
                    prezimeController.text,
                    brojController.text,
                    adresaController.text);
                Navigator.pop(context);
                print("izmenjeno");
              }, //submit funkcija
              text: "Izmeni",
            ),
          ],
        ),
      ),
    );
  }
}

void _openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: CircularProgressIndicator(),
      );
    },
  );
}
