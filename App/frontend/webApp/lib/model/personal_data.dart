import 'package:flutter/material.dart';

class PersonalData {
  PersonalData(
      {@required this.ime,
      @required this.kontakt,
      @required this.adresa,
      @required this.postanskiBroj,
      @required this.opis,
      @required this.privateKey});
  String ime, kontakt, adresa, postanskiBroj, opis, privateKey;
}
