import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'ether_setup.dart';

class KategorijeModel extends ChangeNotifier {
  
  List<Kategorija> listaKategorija = [];
  List<Kategorija> trenutnaKategorija = [];

  bool isLoading = true;
  /*
  Web3Client client;

  
  var abiCode;
  EthereumAddress adresaUgovora;
  DeployedContract ugovor;

  //F-je u Kategorije.sol
  ContractFunction brojKategorija;
  ContractFunction kategorije;
  */

  KategorijeModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    /*
    client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getDeployedCotract();
    
    print(listaKategorija.length);
    // if(listaKategorija.length > 0) {
    //   print(listaKategorija[0].naziv);
    // }
    */
    await dajSveKategorije();
  }

  /*
  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/Kategorije.json");
    var jsonAbi = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonAbi["abi"]);

    adresaUgovora =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getDeployedCotract() async {
    ugovor = DeployedContract(
        ContractAbi.fromJson(abiCode, "kategorije"), adresaUgovora);

    brojKategorija = ugovor.function("brojKategorija");
    kategorije = ugovor.function("kategorije");
  }
  */

  //dajSveKategorije
  Future<void> dajSveKategorije() async {

    String abiStringFile =
        await rootBundle.loadString("assets/kategorije.json");
    print(abiStringFile);
    //var jsonAbi = jsonDecode(abiStringFile);

    listaKategorija = parseJson(abiStringFile);
    print(listaKategorija[0].naziv);

    isLoading = false;
    notifyListeners();
    /*
    var temp = await client
        .call(contract: ugovor, function: brojKategorija, params: []);

    BigInt tempInt = temp[0];
    int bk = tempInt.toInt(); //ukupan broj kategorija

    int kat = 0;
    int roditelj = 0;
    for (int i = 1; i <= bk; i++) {
      BigInt _id = BigInt.from(i);
      var kategorija = await client
          .call(contract: ugovor, function: kategorije, params: [_id]);

      tempInt = kategorija[0];
      kat = tempInt.toInt(); //idKategorije
      tempInt = kategorija[1];
      roditelj = tempInt.toInt(); //idRoditelja

      listaKategorija
          .add(Kategorija(id: i, idRoditelja: roditelj, naziv: kategorija[2]));

      isLoading = false;
      notifyListeners();
    }
    */
  }

  List<Kategorija> parseJson(String response) {
    if(response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Kategorija>((json) => Kategorija.fromJson(json)).toList();
  }

  

  void dajKategoriju(int _roditeljKategorija) {
    
    trenutnaKategorija.clear();
    for (var i = 0; i < listaKategorija.length; i++) {
      if (listaKategorija[i].idRoditelja == _roditeljKategorija) {
        trenutnaKategorija.add(listaKategorija[i]);
      }
    }
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
