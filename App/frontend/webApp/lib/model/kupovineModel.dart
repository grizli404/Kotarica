import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'ether_setup.dart';
import 'package:app/model/proizvodiModel.dart';

class KupovineModel extends ChangeNotifier {
  Credentials credentials;
  EthereumAddress nasaAdresa;

  Web3Client client;

  bool isLoading = true;
  var abiCode;
  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  ContractFunction brojKupovina;
  ContractFunction kupovine;
  ContractFunction dodajKupovinu;
  ContractFunction daLiPostojiKupovina;
  ContractFunction daLiPostojiKupovinaBiloKogProizvoda;

  KupovineModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedCotract();
    notifyListeners();
    //await oceniProizvod(1, 1, 2, 4, "Bez komentara");
  }

  Future<void> getAbi() async {
    /**************************  WEB  ********************************** */
    // String abiStringFile = await rootBundle.loadString("assets/src/Ocene.json");
    // var jsonAbi = jsonDecode(abiStringFile);
    /**************************  WEB  ********************************** */

    /**************************  MOB  ********************************** */
    final response =
        await http.get(Uri.http('147.91.204.116:11096', 'Kupovine.json'));
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
        ContractAbi.fromJson(abiCode, "Kupovine"), adresaUgovora);

    brojKupovina = ugovor.function("brojKupovina");
    kupovine = ugovor.function("kupovine");
    dodajKupovinu = ugovor.function("dodajKupovinu");
    daLiPostojiKupovina = ugovor.function("daLiPostojiKupovina");
    daLiPostojiKupovinaBiloKogProizvoda =
        ugovor.function("daLiPostojiKupovinaBiloKogProizvoda");
  }

  dodavanjeNoveKupovine(
      int _idProdavca, int _idKupca, int _idProizvoda, int _kolicina) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: dodajKupovinu,
            parameters: [
              BigInt.from(_idProdavca),
              BigInt.from(_idKupca),
              BigInt.from(_idProizvoda),
              BigInt.from(_kolicina)
            ]));
  }

  Future<int> daLiPostojiKupovinaZaOcenjivanjeProizvoda(
      int _idKupca, int _idProdavca, int _idProizvoda) async {
    var temp = await client.call(
        contract: ugovor,
        function: daLiPostojiKupovina,
        params: [
          BigInt.from(_idKupca),
          BigInt.from(_idProdavca),
          BigInt.from(_idProizvoda)
        ]);

    return temp[0].toInt();
  }

  Future<int> daLiPostojiKupovinaZaOcenjivanjeKorisnika(
      int _idKupca, int _idProdavca) async {
    var temp = await client.call(
        contract: ugovor,
        function: daLiPostojiKupovinaBiloKogProizvoda,
        params: [BigInt.from(_idKupca), BigInt.from(_idProdavca)]);

    return temp[0].toInt();
  }

  Future<List<int>> najprodavanije(
      List<Kupovina> listaKupovina, List<Proizvod> listaProizvoda) async {
    List<Popularnost> idNajpopularnijih = [];
    idNajpopularnijih.clear();

    var brProizvoda = listaProizvoda.length;
    var brKupovina = listaKupovina.length;
    for (var i = 1; i < brProizvoda; i++) {
      idNajpopularnijih[i].id = i;
      idNajpopularnijih[i].brKupovina = 0;
    }

    for (var i = 1; i <= brKupovina; i++) {
      for (var j = 1; j <= brProizvoda; j++) {
        if (listaKupovina[i].idProizvoda == listaProizvoda[j].id) {
          idNajpopularnijih[j].brKupovina++;
          break;
        }
      }
    }
    Popularnost pom;
    for (var i = 1; i < brProizvoda; i++) {
      for (var j = i + 1; j <= brProizvoda; j++) {
        if (idNajpopularnijih[i].brKupovina < idNajpopularnijih[j].brKupovina) {
          pom = idNajpopularnijih[i];
          idNajpopularnijih[i] = idNajpopularnijih[j];
          idNajpopularnijih[j] = pom;
        }
      }
    }

    List<int> prvihDvadeset = [];
    for (var i = 1; i <= 20; i++) {
      prvihDvadeset.add(idNajpopularnijih[i].id);
    }

    return prvihDvadeset;
  }
}

class Kupovina {
  int id;
  int idKupca;
  int idProdavca;
  int idProizvoda;
  int kolicina;

  Kupovina(
      {this.id,
      this.idKupca,
      this.idProdavca,
      this.idProizvoda,
      this.kolicina});
}

class Popularnost {
  int id;
  int brKupovina;

  Popularnost({this.id, this.brKupovina});
}
