import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'ether_setup.dart';

class KorisniciModel extends ChangeNotifier {
  Korisnik ulogovaniKorisnik;

  var abiCode; //ovde ce da bude smesten json file iz src/abis/korisnici.json
  EthereumAddress adresaUgovora;

  Credentials credentials;
  EthereumAddress nasaAdresa;

  DeployedContract ugovor;

  int brKorisnika = 0;
  //F-je na ethereumu
  ContractFunction brojKorisnika;
  ContractFunction korisnici;
  ContractFunction korisniciMail;
  ContractFunction logovanje;
  ContractFunction proveriUsername;
  ContractFunction dodajKorisnika;
  ContractFunction _dodajSliku;

  Web3Client client;

  KorisniciModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedCotract();
    //Korisnik k = await vratiKorisnikaMail("mika.mikic@gmail.com");
    //print(k.ime);

    //await dodavanjeNovogKorisnika("mika@mikic", "mika", "Mika", "Mikic", "mika.mikic@gmail.com", "060987654321", "2/2");
    /*int broj = await login("mika@mikic", "mika");
    if(broj > 0) {
      print(ulogovaniKorisnik.ime + " " + ulogovaniKorisnik.prezime);
    }*/
    //await dodajSliku(1, "promena");
    print("promenio sam");
  }

  Future<void> getAbi() async {
    /**************************  WEB  ********************************** */
    String abiStringFile =
        await rootBundle.loadString("assets/src/Korisnici.json");

    var jsonAbi = jsonDecode(abiStringFile);
    /**************************  WEB  ********************************** */


    /**************************  MOB  ********************************** */
    // final response =
    //     await http.get(Uri.http('147.91.204.116:11091', 'Korisnici.json'));
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

  //Ovde treba da budu navedene sve f-je koje se nalaze na ugovoru
  Future<void> getDeployedCotract() async {
    ugovor = DeployedContract(
        ContractAbi.fromJson(abiCode, "Korisnici"), adresaUgovora);

    brojKorisnika = ugovor.function("brojKorisnika");
    korisnici = ugovor.function("korisnici");
    korisniciMail = ugovor.function("korisniciMail");
    logovanje = ugovor.function("prijavljivanje");
    proveriUsername = ugovor.function("proveriUsername");
    dodajKorisnika = ugovor.function("dodajKorisnika");
    _dodajSliku = ugovor.function("dodajSliku");
  }

  //Logovanje
  Future<int> login(String username, String password) async {
    var temp = await client.call(
        contract: ugovor, function: logovanje, params: [username, password]);
    //Vraca nula ako nije nasao username i password
    //id korisnika ako ga je nasao
    BigInt tempInt = temp[0];
    int _id = tempInt.toInt();
    print(_id);
    if (_id > 0) {
      await vratiKorisnika(_id);
      print("Prijavio");
      return _id;
    } else {
      print("Nisam");
      return 0;
    }
  }

  //Setuje prijavljenog korisnika
  Future<void> vratiKorisnika(int _id) async {
    if (_id > 0) {
      var k = await client.call(
          contract: ugovor, function: korisnici, params: [BigInt.from(_id)]);

      ulogovaniKorisnik = Korisnik(
          id: _id,
          mail: k[1],
          password: k[2],
          ime: k[3],
          prezime: k[4],
          brojTelefona: k[5],
          adresa: k[6],
          slika: k[7]);
    }
  }

  //Registracija
  //dodavanjeNovogKorisnika(String)
  dodavanjeNovogKorisnika(String _mail, String _password, String _ime,
      String _prezime, String _broj, String _adresa) async {
    int postoji;

    postoji = await proveraDaLiPostojiUsername(_mail);
    if (postoji == 1) {
      // znaci da ne postoji taj username
      var k = await client.sendTransaction(
          credentials,
          Transaction.callContract(
              maxGas: 6721975,
              contract: ugovor,
              function: dodajKorisnika,
              parameters: [_mail, _password, _ime, _prezime, _broj, _adresa]));
      if (k != 0) {
        return await login(_mail, _password);
      }
    }

    // kada se uspesno registrovao, odma prijavimo tog korisnika
  }

  Future<int> proveraDaLiPostojiUsername(String _username) async {
    var k = await client
        .call(contract: ugovor, function: proveriUsername, params: [_username]);

    BigInt tempInt = k[0];
    return tempInt.toInt();
  }

  Future<Korisnik> vratiKorisnikaMail(String mail) async {
    if (mail != "") {
      var k = await client
          .call(contract: ugovor, function: korisniciMail, params: [mail]);

      BigInt bigId = k[0];
      int _id = bigId.toInt();
      if (_id != 0) {
        return Korisnik(
            id: _id,
            mail: k[1],
            password: k[2],
            ime: k[3],
            prezime: k[4],
            brojTelefona: k[5],
            adresa: k[6],
            slika: k[7]);
      }
    }
  }

  Future<void> dodajSliku(int id, String slika) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: _dodajSliku,
            parameters: [BigInt.from(id), slika]));
  }
}

class Korisnik {
  int id;
  String mail;
  String password;
  String ime;
  String prezime;
  String brojTelefona;
  String adresa;
  String slika;

  Korisnik(
      {this.id,
      this.mail,
      this.password,
      this.ime,
      this.prezime,
      this.brojTelefona,
      this.adresa,
      this.slika});
}
