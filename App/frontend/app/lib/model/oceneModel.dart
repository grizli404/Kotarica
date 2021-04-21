import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'ether_setup.dart';

class OceneModel extends ChangeNotifier {
  List<Ocena> listaOcena = [];

  Credentials credentials;
  EthereumAddress nasaAdresa;

  Web3Client client;

  bool isLoading = true;
  var abiCode;
  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  ContractFunction brojOcena;
  ContractFunction ocene;
  ContractFunction dodajOcenu;
  ContractFunction _prosecnaOcenaZaProdavca;
  
  OceneModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedCotract();

    //await oceniProizvod(1, 1, 2, 4, "Bez komentara");
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/Ocene.json");
    var jsonAbi = jsonDecode(abiStringFile);
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
    ugovor =
        DeployedContract(ContractAbi.fromJson(abiCode, "Ocene"), adresaUgovora);

    brojOcena = ugovor.function("brojOcena");
    ocene = ugovor.function("ocene");
    dodajOcenu = ugovor.function("dodajOcenu");
    _prosecnaOcenaZaProdavca = ugovor.function("prosecnaOcenaZaProdavca");
  }

  Future<void> oceniProizvod(int _idKupca, int _idKategorije, int _idProizvoda,
      int _ocena, String _komentar) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: dodajOcenu,
            parameters: [
              BigInt.from(_idKupca),
              BigInt.from(_idKategorije),
              BigInt.from(_idProizvoda),
              BigInt.from(_ocena),
              _komentar
            ]));
  }

  Future<double> prosecnaOcenaZaProdavca(int _idProdavca) async{
    var temp = await client.call(
        contract: ugovor, function: _prosecnaOcenaZaProdavca, params: [BigInt.from(_idProdavca)]);

    BigInt tempInt = temp[0];
    int vrednost = tempInt.toInt();
    double srednjaVresnot = vrednost / 100;
    return srednjaVresnot;
  }

  /*
  Future<void> dajSveOcene() async {
    var brojPom = await client.call(contract: ugovor, function: brojOcena, params: []);

    BigInt brojBig = brojPom[0];
    int _brojOcena = brojBig.toInt();

    int _idKupovine;
    int _idKategorije;
    int _idProizvoda;
    int _ocena;

    listaOcena.clear();
    if(_brojOcena > 0) {
      for (var i = 1; i <= _brojOcena; i++) {
        var ocena = await client.call(contract: ugovor, function: ocene, params: [BigInt.from(i)]);


        brojBig = ocena[1];
        _idKupovine = brojBig.toInt();
        brojBig = ocena[2];
        _idKategorije = brojBig.toInt();
        brojBig = ocena[3];
        _idProizvoda = brojBig.toInt();
        brojBig = ocena[4];
        _ocena = brojBig.toInt();

        listaOcena.add(
          Ocena(
            id: i,
            idKupovine: _idKupovine,
            idKategorije: _idKategorije,
            idProizvoda: _idProizvoda,
            ocena: _ocena,
            komentar: ocena[5]
          )
        );
      }
    }
    //Ovde treba napraviti da se sacuva u csv file

    // ignore: deprecated_member_use
    List<List<dynamic>> rows = List<List<dynamic>>();
    // ignore: deprecated_member_use
    List<dynamic> zaglavlje = List(); // Prvo zaglavlje
    zaglavlje.add("id");
    zaglavlje.add("idKupovine");
    zaglavlje.add("idKategorije");
    zaglavlje.add("idProizvoda");
    zaglavlje.add("ocena");
    zaglavlje.add("ocena");

    rows.add(zaglavlje);

    for (var i = 0; i < listaOcena.length; i++) {
      // ignore: deprecated_member_use
      List<dynamic> row = new List();
      row.add(listaOcena[i].id);
      row.add(listaOcena[i].idKupovine);
      row.add(listaOcena[i].idKategorije);
      row.add(listaOcena[i].idProizvoda);
      row.add(listaOcena[i].ocena);
      row.add(listaOcena[i].ocena);

      rows.add(row);
    }
    
    String csv = const ListToCsvConverter().convert(rows);
    print(csv);
    //File csvFile = new File("/myCsvFile.csv");
    //csvFile.writeAsString(csv);
  }
  */
}

class Ocena {
  int id;
  int idKupovine;
  int idKategorije;
  int idProizvoda;
  int ocena;
  String komentar;

  Ocena(
      {this.id,
      this.idKupovine,
      this.idKategorije,
      this.idProizvoda,
      this.ocena,
      this.komentar});
}