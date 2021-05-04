import 'dart:convert';

import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'ether_setup.dart';

class Notification {
  final String message;
  final Proizvod proizvod;
  final int id;

  Notification({this.proizvod, @required this.message, @required this.id});
}

Proizvod demoProizvod = Proizvod(
    cena: 100,
    id: 10,
    idKategorije: 1,
    idKorisnika: 1,
    kolicina: 10,
    naziv: "jaja-test");

List<Notification> notificationList = [
  Notification(message: "Narudzbina1", id: 1, proizvod: demoProizvod),
  Notification(message: "Narudzbina2", id: 1),
];

void dismissAllNotifications() {
  notificationList.clear();
  //remove from block or cookie implementation
}


class NotifikacijeModel extends ChangeNotifier{

  Web3Client client;

  var abiCode;

  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  Credentials credentials;
  EthereumAddress nasaAdresa;

  ContractFunction _brojNotifikacija;
  ContractFunction _notifikacije;
  ContractFunction _dodajNotifikaciju;

  NotifikacijeModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedCotract();
  }

  Future<void> getAbi() async {
    
    /**************************  WEB  ********************************** */
    // String abiStringFile = await rootBundle.loadString("assets/src/Notification.json");
    // var jsonAbi = jsonDecode(abiStringFile);
   /**************************  WEB  ********************************** */

    /**************************  MOB  ********************************** */
    final response =
        await http.get(Uri.http('147.91.204.116:11091', 'Notification.json'));
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
        ContractAbi.fromJson(abiCode, "Notifications"), adresaUgovora);

      _brojNotifikacija = ugovor.function("brojNotifikacija");
      _notifikacije = ugovor.function("notifikacije");
      _dodajNotifikaciju = ugovor.function("dodajNotifikaciju");
  }

  Future<void> dodajNotifikaciju(int idKorisnika, int idProizvoda, String poruka) async {
    await client.sendTransaction(
      credentials,
      Transaction.callContract(
        maxGas: 6721975,
        contract: ugovor,
        function: _dodajNotifikaciju,
        parameters: [BigInt.from(idKorisnika), BigInt.from(idProizvoda), poruka]
      )
    );
  }

}
