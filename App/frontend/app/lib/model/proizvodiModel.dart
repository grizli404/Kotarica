import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ProizvodiModel extends ChangeNotifier {
  List<Proizvod> listaProizvoda = [];

  final String rpcUrl = "http://127.0.0.1:7545";
  final String wsUrl = "ws://127.0.0.1:7545/";

  Web3Client client;

  bool isLoading = true;
  var abiCode;
  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  ContractFunction brojProizvoda;
  ContractFunction proizvodi;
  ContractFunction dodajProizvod;
  ContractFunction dajProizvodeZaKorisnika;

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
    String abiStringFile = await rootBundle.loadString("src/abis/Proizvodi.json");
    var jsonAbi = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonAbi["abi"]);

    adresaUgovora = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    //print(adresaUgovora);
  }

  Future<void> getDeployedCotract() async {
    ugovor = DeployedContract(ContractAbi.fromJson(abiCode, "Proizvodi"), adresaUgovora);
    
    brojProizvoda = ugovor.function("brojProizvoda");
    proizvodi = ugovor.function("proizvodi");
    dodajProizvod = ugovor.function("dodajProizvod");
    dajProizvodeZaKorisnika = ugovor.function("dajProizvodeZaKorisnika");
  }

  Future<void> dajSveProizvode() async {
    var temp = await client.call(contract: ugovor, function: brojProizvoda, params: []);

    BigInt tempInt = temp[0];
    int brojP = tempInt.toInt();

    int _idKorisnika = 0;
    int _idKategorije = 0;
    int _kolicina = 0;
    int _cena = 0;
    for (var i = brojP; i >= 1; i--) {
      var proizvod = await client.call(contract: ugovor, function: proizvodi, params: [BigInt.from(i)]);
      
      tempInt = proizvod[1];
      _idKorisnika = tempInt.toInt();
      tempInt = proizvod[2];
      _idKategorije = tempInt.toInt();
      tempInt = proizvod[4];
      _kolicina = tempInt.toInt();
      tempInt = proizvod[5];
      _cena = tempInt.toInt();
      
      if(_idKorisnika > 0) {
        listaProizvoda.add(Proizvod(id: i, idKorisnika: _idKorisnika, idKategorije: _idKategorije, naziv: proizvod[3], kolicina: _kolicina, cena: _cena));
        //print(proizvod[3]);
      }
    }

    isLoading = false;
    notifyListeners();
  }
}

class Proizvod {
  int id;
  int idKorisnika;
  int idKategorije;
  String naziv;
  int kolicina;
  int cena;

  Proizvod({this.id, this.idKorisnika, this.idKategorije, this.naziv, this.kolicina, this.cena});
}

