import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import 'ether_setup.dart';

class ListaZeljaModel extends ChangeNotifier {
  List<int> listaLajkovanihProizvoda = [];

  var abiCode;
  EthereumAddress adresaUgovora;

  Credentials credentials;
  EthereumAddress nasaAdresa;

  DeployedContract ugovor;

  ContractFunction _lajkovanje;
  ContractFunction _dislajkovanje;
  ContractFunction _dajLajkove;

  Web3Client client;

  ListaZeljaModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedCotract();

    // await dislajkovanje(3, 6);

    // await dajLajkove(3);
  }

  Future<void> getAbi() async {
    /**************************  WEB  ********************************** */
    // String abiStringFile =
    //     await rootBundle.loadString("assets/src/ListaZelja.json");

    // var jsonAbi = jsonDecode(abiStringFile);
    /**************************  WEB  ********************************** */

    /**************************  MOB  ********************************** */
    final response =
        await http.get(Uri.http('147.91.204.116:11091', 'ListaZelja.json'));
    var jsonAbi;

    if (response.statusCode == 200) {
      jsonAbi = jsonDecode(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data from server ListaZelja');
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
        ContractAbi.fromJson(abiCode, "ListaZelja"), adresaUgovora);
    _lajkovanje = ugovor.function("lajkovanje");
    _dislajkovanje = ugovor.function("dislajkovanje");
    _dajLajkove = ugovor.function("dajLajkove");
  }

  Future<void> lajkovanje(int _idKorisnika, int _idProizvoda) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: _lajkovanje,
            parameters: [
              BigInt.from(_idKorisnika),
              BigInt.from(_idProizvoda)
            ]));
  }

  Future<void> dislajkovanje(int _idKorisnika, int _idProizvoda) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: _dislajkovanje,
            parameters: [
              BigInt.from(_idKorisnika),
              BigInt.from(_idProizvoda)
            ]));
  }

  Future<void> dajLajkove(int _idKorisnika) async {
    List lz = await client.call(
        contract: ugovor,
        function: _dajLajkove,
        params: [BigInt.from(_idKorisnika)]);

    for (var item in lz[0]) {
      int element = item.toInt();
      if (element != 0) {
        listaLajkovanihProizvoda.insert(0, element);
        print(element);
      } else {
        break;
      }
    }
  }
}
