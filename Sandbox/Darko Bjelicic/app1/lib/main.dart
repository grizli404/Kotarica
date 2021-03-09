import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String rpcUrl = "http://127.0.0.1:7545";
  String wsUrl = "ws://127.0.0.1:7545/";
  Future<void> sendEther() async {
    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    String privateKey =
        "2050a178c8ebe43d5b71df3edc759155cba5521892a182b959d70dfd783d7f71";
    Credentials credentials =
        await client.credentialsFromPrivateKey(privateKey);
    EthereumAddress recAddress =
        EthereumAddress.fromHex("0x0Fa61d16B0D7da8F7f0492dCcC06Ad1EC19A13CD");
    EthereumAddress ownAddress = await credentials.extractAddress();

    print(ownAddress);

    client.sendTransaction(
        credentials,
        Transaction(
            from: ownAddress,
            to: recAddress,
            value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 5)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Pocetna"),
      ),
      body: new Center(
        child: new ElevatedButton(
          child: new Text("Posalji"),
          onPressed: sendEther,
        ),
      ),
    );
  }
}
