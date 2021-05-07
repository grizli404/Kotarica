import 'package:app/model/korisniciModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Korisnik korisnik;

  const ProfileScreen({Key key, this.korisnik}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilna Strana"),
      ),
      body: Container(
          child: Column(
        children: [
          Text("ime: " + korisnik.ime),
          Text("prezime: " + korisnik.prezime),
          Text("adresa: " + korisnik.adresa)
        ],
      )),
    );
  }
}
