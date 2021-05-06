import 'package:app/model/korisniciModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final int korisnikId;
  KorisniciModel kModel;
  ProfileScreen({Key key, this.korisnikId}) {
    kModel = new KorisniciModel();
    print("Instanciran Korisnik Model");
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState(kModel, korisnikId);
}

class _ProfileScreenState extends State<ProfileScreen> {
  KorisniciModel kModel;
  Korisnik korisnik;
  int korisnikId;

  _ProfileScreenState(KorisniciModel kModel, int korisnikId) {
    this.kModel = kModel;
    this.korisnikId = korisnikId;
    print("Prosledjen KorisnikModel");
  }

  void getKorisnik() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilna strana korisnika"),
      ),
      body: Container(
        child: FutureBuilder(
          future: kModel.dajKorisnikaZaId(korisnikId),
          builder: (context, AsyncSnapshot<Korisnik> snapshot) {
            Korisnik kor = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done) {
              return Text("Ucitao " + snapshot.hasData.toString());
            } else {
              return Text("Nije jos ucitao");
            }
          },
        ),
      ),
    );
  }
}
