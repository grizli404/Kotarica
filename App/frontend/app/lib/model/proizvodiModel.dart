import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'ether_setup.dart';

class ProizvodiModel extends ChangeNotifier {
  List<Proizvod> listaProizvoda = [];

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
    //await dodajProizvod(1, 1, "Ovca", 5, 25000, "hashslike");
    await dajSveProizvode();
    }

  Future<void> getAbi() async {
    /**************************  WEB  ********************************** */
    // String abiStringFile =
    //     await rootBundle.loadString("assets/src/Proizvodi.json");
    // var jsonAbi = jsonDecode(abiStringFile);
    /**************************  WEB  ********************************** */

    /**************************  MOB  ********************************** */
    final response =
        await http.get(Uri.http('147.91.204.116:11091', 'Proizvodi.json'));
    var jsonAbi;
    if (response.statusCode == 200) {
      jsonAbi = jsonDecode(response.body);
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
  }

  Future<void> dodajProizvod(int _idKorisnika, int _idKategorije, String _naziv, int _kolicina, int _cena, String _slika) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: _dodajProizvod,
            parameters: [
              BigInt.from(_idKorisnika),
              BigInt.from(_idKategorije),
              _naziv,
              BigInt.from(_kolicina),
              BigInt.from(_cena),
              _slika
            ]));
  }

  Future<void> dajSveProizvode() async {
    var temp = await client
        .call(contract: ugovor, function: brojProizvoda, params: []);

    BigInt tempInt = temp[0];
    int brojP = tempInt.toInt();

    int _idKorisnika = 0;
    int _idKategorije = 0;
    int _kolicina = 0;
    int _cena = 0;

    listaProizvoda.clear();

    for (var i = brojP; i >= 1; i--) {
      var proizvod = await client.call(
          contract: ugovor, function: proizvodi, params: [BigInt.from(i)]);

      tempInt = proizvod[1];
      _idKorisnika = tempInt.toInt();
      tempInt = proizvod[2];
      _idKategorije = tempInt.toInt();
      tempInt = proizvod[4];
      _kolicina = tempInt.toInt();
      tempInt = proizvod[5];
      _cena = tempInt.toInt();

      if (_idKorisnika > 0) {
        listaProizvoda.add(Proizvod(
            id: i,
            idKorisnika: _idKorisnika,
            idKategorije: _idKategorije,
            naziv: proizvod[3],
            kolicina: _kolicina,
            cena: _cena));
        //print(proizvod[3]);
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
    /*
    List<dynamic> idPr = await client.call(contract: ugovor, function: proizvodiKorisnika, params: [BigInt.from(idKorisnika)]);
    print(idPr[0][2]);

    if(idPr[0].length > 0) { //Ako taj korisnik ima neki proizvd
      BigInt big;
      int _idKat;
      int _kol;
      int _cena;
      proizvodiKor.clear();
      for (var i = 0; i < idPr[0].length; i++) {
        var proizvod = await client.call(contract: ugovor, function: proizvodi, params: [BigInt.from(idPr[0][i])]);

        big = proizvod[2];
        _idKat = big.toInt();
        big = proizvod[4];
        _kol = big.toInt();
        big = proizvod[5];
        _cena = big.toInt();

        proizvodiKor.add(
          Proizvod(
            id: idPr[i],
            idKorisnika: idKorisnika,
            idKategorije: _idKat,
            naziv: proizvod[3],
            kolicina: _kol,
            cena: _cena
          )
        );

        print(proizvod[3]);
      } //Dodali smo sve proizvode datog korisnika u listu
    }
    */
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

  List<Proizvod> search(String input) {
    List<Proizvod> result;
    result.clear();

    return result;
  }
}

class Proizvod {
  int id;
  int idKorisnika;
  int idKategorije;
  String naziv;
  int kolicina;
  int cena;
  String slika;

  Proizvod(
      {this.id,
      this.idKorisnika,
      this.idKategorije,
      this.naziv,
      this.kolicina,
      this.cena,
      this.slika});
}
