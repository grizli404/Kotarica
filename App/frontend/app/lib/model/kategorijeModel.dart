import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

List<Kategorija> listaKategorija = [];

class KategorijeModel extends ChangeNotifier {
  
  List<Kategorija> kategorije = [];

  bool isLoading = true;

  KategorijeModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    await dajSveKategorije();
    dajKategorije();
  }

  List<Kategorija> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Kategorija>((json) => Kategorija.fromJson(json)).toList();
  }

  //Iz jsona cita sve kategorije
  Future<void> dajSveKategorije() async {
    String abiStringFile =
        await rootBundle.loadString("assets/kategorije.json");
    //var jsonAbi = jsonDecode(abiStringFile);

    listaKategorija = parseJson(abiStringFile);

    isLoading = false;
    notifyListeners();
  }

  //U listu 'kategorije' smesta sve kategorije
  void dajKategorije() {
    kategorije.clear();
    for (var i = 0; i < listaKategorija.length; i++) {
      if (listaKategorija[i].idRoditelja == 0) {
        kategorije.add(listaKategorija[i]);
      }
    }
  }

  //F-ja vraca potkategorije trazene kategorije
  List<Kategorija> dajPotkategorije(int _roditeljKategorija) {
    List<Kategorija> potkategorije = [];
    for (var i = 0; i < listaKategorija.length; i++) {
      if (listaKategorija[i].idRoditelja == _roditeljKategorija) {
        potkategorije.add(listaKategorija[i]);
      }
    }

    return potkategorije;
  }
}

class Kategorija {
  int id;
  int idRoditelja;
  String naziv;

  Kategorija({this.id, this.idRoditelja, this.naziv});

  factory Kategorija.fromJson(Map<String, dynamic> json) {
    return new Kategorija(
      id: json['id'] as int,
      idRoditelja: json['idRoditelja'] as int,
      naziv: json['kategorija'] as String,
    );
  }
}
