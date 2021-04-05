import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ProizvodiModel extends ChangeNotifier {
  List<Proizvod> listaProizvoda = [];

  final String rpcUrl = "http://192.168.1.107:7545";
  final String wsUrl = "ws://192.168.1.107:7545/";

  Web3Client client;

  bool isLoading = true;
  var abiCode;
  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  ContractFunction brojProizvoda;
  ContractFunction proizvodi;
  ContractFunction dodajProizvod;
  ContractFunction proizvodiKorisnika;

  ProizvodiModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getDeployedCotract();
    await dajSveProizvode();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/Proizvodi.json");
    var jsonAbi = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonAbi["abi"]);

    adresaUgovora =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    //print(adresaUgovora);
  }

  Future<void> getDeployedCotract() async {
    ugovor = DeployedContract(
        ContractAbi.fromJson(abiCode, "Proizvodi"), adresaUgovora);

    brojProizvoda = ugovor.function("brojProizvoda");
    proizvodi = ugovor.function("proizvodi");
    dodajProizvod = ugovor.function("dodajProizvod");
    proizvodiKorisnika = ugovor.function("dajProizvodeZaKorisnika");
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
}

class Proizvod {
  int id;
  int idKorisnika;
  int idKategorije;
  String naziv;
  int kolicina;
  int cena;

  Proizvod(
      {this.id,
      this.idKorisnika,
      this.idKategorije,
      this.naziv,
      this.kolicina,
      this.cena});
}
