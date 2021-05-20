import 'dart:convert';

import 'package:app/screens/add_product/add_product.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'ether_setup.dart';

class ProizvodiModel extends ChangeNotifier {
  List<Proizvod> listaProizvoda = [];

  List<String> split(Pattern pattern){}

  Web3Client client;

  bool isLoading = true;
  var abiCode;
  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  Credentials credentials;
  EthereumAddress nasaAdresa;

  ContractFunction brojProizvoda;
  ContractFunction proizvodi;
  ContractFunction _dodajProizvod;
  ContractFunction proizvodiKorisnika;
  ContractFunction _smanjiPrilikomKupovine;

  ContractEvent _smanji;

  ProizvodiModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedCotract();

    await dajSveProizvode();

    print("Dosao sam dovde");
    //await smanjiPrilikomKupovine(1, 1);
    print("zavrsio sam");

    notifyListeners();
  }

  Future<void> getAbi() async {
    /**************************  WEB  ********************************** */
    // String abiStringFile =
    //     await rootBundle.loadString("src/abis/Proizvodi.json");
    // var jsonAbi = jsonDecode(abiStringFile);
    /**************************  WEB  ********************************** */

    /**************************  MOB  ********************************** */
    final response =
        await http.get(Uri.http('147.91.204.116:11091', 'Proizvodi.json'));
    var jsonAbi;
    if (response.statusCode == 200) {
      jsonAbi = jsonDecode(response.body);
      print(jsonAbi["networks"]["5777"]["address"]);
    } else {
      throw Exception('Failed to load data from server');
    }
    /**************************  MOB  ********************************** */

    abiCode = jsonEncode(jsonAbi["abi"]);

    adresaUgovora =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    //print(adresaUgovora);
  }

  Future<void> getCredentials() async {
    //ovde smo dobili nasu javnu adresu uz pomocom privatnog kljuca
    credentials = await client.credentialsFromPrivateKey(privatniKljuc);
    nasaAdresa = await credentials.extractAddress();
  }

  Future<void> getDeployedCotract() async {
    ugovor = DeployedContract(
        ContractAbi.fromJson(abiCode, "Proizvodi"), adresaUgovora);

    brojProizvoda = ugovor.function("brojProizvoda");
    proizvodi = ugovor.function("proizvodi");
    _dodajProizvod = ugovor.function("dodajProizvod");
    proizvodiKorisnika = ugovor.function("dajProizvodeZaKorisnika");
    _smanjiPrilikomKupovine = ugovor.function("smanjiPrilikomKupovine");
    //Event
    _smanji = ugovor.event("smanji");
  }

  Future<void> dodajProizvod(int _idKorisnika, int _idKategorija, int _idPotkategorije, String _naziv,
      int _kolicina, String jedinica, int _cena, List<String> _slike, String _opis) async {

    String _idKategorije = _idKategorija.toString() + "|" + _idPotkategorije.toString();
    String cenaJedinica = _cena.toString() + "|" + jedinica;
    String _slika = "";

    for (var i = 0; i < _slike.length; i++) {
      slika += _slike[i] + "|";
    }

    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: _dodajProizvod,
            parameters: [
              BigInt.from(_idKorisnika),
              _idKategorije,
              _naziv,
              BigInt.from(_kolicina),
              cenaJedinica,
              _slika,
              _opis
            ]));
  }

  Future<void> dajSveProizvode() async {
    var temp = await client
        .call(contract: ugovor, function: brojProizvoda, params: []);

    BigInt tempInt = temp[0];
    int brojP = tempInt.toInt();

    int _idKorisnika = 0;
    int _kolicina = 0;

    listaProizvoda.clear();

    for (var i = brojP; i >= 1; i--) {
      var proizvod = await client.call(
          contract: ugovor, function: proizvodi, params: [BigInt.from(i)]);

      tempInt = proizvod[1];
      _idKorisnika = tempInt.toInt();

      var kategorija_potkategorija = proizvod[2];
      kategorija_potkategorija = kategorija_potkategorija.toString();
      kategorija_potkategorija = kategorija_potkategorija.split("|");
      int kat = int.parse(kategorija_potkategorija[0]);
      int potk = int.parse(kategorija_potkategorija[1]);

      tempInt = proizvod[4];
      _kolicina = tempInt.toInt();

      var cena_jedinica = proizvod[5];
      cena_jedinica = cena_jedinica.toString();
      cena_jedinica = cena_jedinica.split("|");
      int cena = int.parse(cena_jedinica[0]);

      List<String> s = [""];
      var slike = proizvod[6];
      for (var i = 0; i < slike.length; i++) {
        s.add(slike[i]);
      }

      if (_idKorisnika > 0) {
        listaProizvoda.add(Proizvod(
            id: i,
            idKorisnika: _idKorisnika,
            idKategorije: kat,
            idPotkategorije: potk,
            naziv: proizvod[3],
            kolicina: _kolicina,
            jedinica: cena_jedinica[1],
            cena: cena,
            slika: s,
            opis: proizvod[7]));
      }
    }

    isLoading = false;
    notifyListeners();
  }

  List<Proizvod> dajProizvodeZaKorisnika(int _idKorisnika) {
    List<Proizvod> proizvodiKor = [];

    if (listaProizvoda.length > 0) {
      for (var i = 0; i < listaProizvoda.length; i++) {
        if (listaProizvoda[i].idKorisnika == _idKorisnika) {
          proizvodiKor.add(listaProizvoda[i]);
        }
      }
    }
    return proizvodiKor;
  }

  List<Proizvod> dajProizvodeZaKategoriju(int _idKategorije) {
    List<Proizvod> proizvodiKat = [];

    if (listaProizvoda.length > 0) {
      for (var i = 0; i < listaProizvoda.length; i++) {
        if (listaProizvoda[i].idKategorije == _idKategorije) {
          proizvodiKat.add(listaProizvoda[i]);
          print(proizvodiKat[proizvodiKat.length - 1].naziv);
        }
      }
    }
    return proizvodiKat;
  }

  List<Proizvod> dajProizvodeZaPotkategoriju(int _idKategorije) {
    List<Proizvod> proizvodiKat = [];

    if (listaProizvoda.length > 0) {
      for (var i = 0; i < listaProizvoda.length; i++) {
        if (listaProizvoda[i].idPotkategorije == _idKategorije) {
          proizvodiKat.add(listaProizvoda[i]);
          print(proizvodiKat[proizvodiKat.length - 1].naziv);
        }
      }
    }
    return proizvodiKat;
  }

  List<Proizvod> search(String input) {
    List<Proizvod> result;
    result.clear();

    return result;
  }

  //Funkcija koja vraca proizvod za zadati id
  //Ovo je potrebno za lajkovane proizvode
  Proizvod dajProizvodZaId(int _idProizvoda) {
    Proizvod p = Proizvod(
        id: 0,
        idKorisnika: 0,
        idKategorije: 0,
        naziv: "",
        kolicina: 0,
        jedinica: "",
        cena: 0,
        slika: [],
        opis: "");

    if (_idProizvoda > 0) {
      for (var i = 0; i < listaProizvoda.length; i++) {
        if (listaProizvoda[i].id == _idProizvoda) {
          p = listaProizvoda[i];
          break;
        }
      }
    }
    return p;
  }

  Future<bool> smanjiPrilikomKupovine(int _idProizoda, int _kolicina) async {
    var povratna = await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: _smanjiPrilikomKupovine,
            parameters: [
              BigInt.from(_idProizoda),
              BigInt.from(_kolicina),
            ]));

    print(povratna.hashCode);
  }

}

class Proizvod {
  int id;
  int idKorisnika;
  int idKategorije;
  int idPotkategorije;
  String naziv;
  int kolicina;
  String jedinica;
  int cena;
  List<String> slika;
  String opis;

  Proizvod(
      {this.id,
      this.idKorisnika,
      this.idKategorije,
      this.idPotkategorije,
      this.naziv,
      this.kolicina,
      this.jedinica,
      this.cena,
      this.slika,
      this.opis});
}
