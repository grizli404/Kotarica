import 'dart:async';
import 'dart:convert';

import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'ether_setup.dart';


Proizvod demoProizvod = Proizvod(
    cena: 100,
    id: 10,
    idKategorije: 1,
    idKorisnika: 1,
    kolicina: 10,
    naziv: "jaja-test");

List<Notification> notificationList = [
  // Notification(message: "Narudzbina1", id: 1, proizvod: demoProizvod),
  // Notification(message: "Narudzbina2", id: 1),
];

void dismissAllNotifications() {
  notificationList.clear();
  //remove from block or cookie implementation
}


class NotifikacijeModel extends ChangeNotifier{

  List<Notification> listaSvihNotifikacija;

  Web3Client client;

  var abiCode;

  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  Credentials credentials;
  EthereumAddress nasaAdresa;

  ContractFunction _brojPorudzbina;
  ContractFunction _notifikacije;
  ContractFunction _dodajNotifikacije;

  NotifikacijeModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client("http://192.168.0.24:7545", http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect("ws://192.168.0.24:7545/").cast<String>();
    });

    
    await getAbi();
    await getCredentials();
    await getDeployedCotract();

    await dajSveNotifikacije();

  }

  Future<void> getAbi() async {
    /**************************  WEB  ********************************** */
    String abiStringFile = await rootBundle.loadString("src/abis/Notifications.json");
    var jsonAbi = jsonDecode(abiStringFile);
   /**************************  WEB  ********************************** */

    /**************************  MOB  ********************************** */
    // final response =
    //     await http.get(Uri.http('147.91.204.116:11091', 'Notification.json'));
    // var jsonAbi;
    // if (response.statusCode == 200) {
    //   jsonAbi = jsonDecode(response.body);
    // } else {
    //   throw Exception('Failed to load data from server');
    // }
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
        ContractAbi.fromJson(abiCode, "Notifications"), adresaUgovora);

      _brojPorudzbina = ugovor.function("brojPorudzbina");
      _notifikacije = ugovor.function("notifikacije");
      _dodajNotifikacije = ugovor.function("dodajNotifikaciju");
  }

  Future<void> dodajNotifikacije(int idKorisnika, int idProizvoda, String nazivProizvoda,
                                  int kolicina, String ime, String telefon, String adresa) async {
    await client.sendTransaction(
      credentials,
      Transaction.callContract(
        maxGas: 6721975,
        contract: ugovor,
        function: _dodajNotifikacije,
        parameters: [
          BigInt.from(idKorisnika),
          BigInt.from(idProizvoda),
          nazivProizvoda,
          BigInt.from(kolicina),
          ime,
          telefon,
          adresa
        ]));

  }

  Future<void> dajSveNotifikacije() async {
    var temp = await client
      .call(contract: ugovor, function: _brojPorudzbina, params: []);

    BigInt tempInt = temp[0];
    int ukupno = tempInt.toInt();
    int _idKorisnika = 0;
    int _idProizvoda = 0;
    int _kolicina = 0;

    listaSvihNotifikacija.clear();

    for (var i = 1; i <= ukupno; i--) {
      var notifikacija = await client.call(
          contract: ugovor, function: _notifikacije, params: [BigInt.from(i)]);

      tempInt = notifikacija[1];
      _idKorisnika = tempInt.toInt();

      tempInt = notifikacija[2];
      _idProizvoda = tempInt.toInt();

      tempInt = notifikacija[4];
      _kolicina = tempInt.toInt();

      listaSvihNotifikacija.add(Notification(
        idKorisnika: _idKorisnika,
        idProizvoda: _idProizvoda,
        nazivProizoda: notifikacija[3],
        kolicina: _kolicina,
        ime: notifikacija[5],
        telefon: notifikacija[6],
        adresa: notifikacija[7]
      ));
    }

  }

  List<Notification> dajNotifikacijeZaKorisnika(int _idKorisnika) {
    List<Notification> notif = [];

    if (listaSvihNotifikacija.length > 0) {
      for (var i = 0; i < listaSvihNotifikacija.length; i++) {
        if (listaSvihNotifikacija[i].idKorisnika == _idKorisnika) {
          notif.add(listaSvihNotifikacija[i]);
        }
      }
    }
    return notif;
  }

}

class Notification {

  int idKorisnika;
  int idProizvoda;
  String nazivProizoda;
  int kolicina;
  String ime;
  String telefon;
  String adresa;

  Notification({
    this.idKorisnika,
    this.idProizvoda,
    this.nazivProizoda,
    this.kolicina,
    this.ime,
    this.telefon,
    this.adresa
    });
}
