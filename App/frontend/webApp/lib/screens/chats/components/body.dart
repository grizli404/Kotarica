import 'package:app/main.dart';
import 'package:app/model/chats.dart';
import 'package:app/screens/conversation/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'chat_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool inAsyncCall = true;
  List<Chat> chats = [];
  HubConnection hubConnection;
  String _url = "http://147.91.204.116:11098/ChatHub";
  void _initConnection() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(_url, HttpConnectionOptions(logging: (l, m) => {print(m)}))
        .build();
    hubConnection.onclose((exception) {
      print(exception);
      print("\nCONNECTION CLOSED!");
    });
    await startConnection();
    List<dynamic> res = await hubConnection
        .invoke('GetInbox', args: <dynamic>[korisnikInfo.id]);

    for (dynamic index in res) {
      print(index);
    }
  }

  startConnection() async {
    if (hubConnection.state == HubConnectionState.disconnected) {
      print("Startujem konekciju");
      await hubConnection.start();
      setState(() {
        inAsyncCall = false;
      });
      print("STARTED CONNECTION");
    } else {
      print("Connection is open");
    }
  }

  @override
  void initState() {
    super.initState();
    _initConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => ChatCard(
                  chat: chats[index],
                  press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConversationScreen(),
                        ),
                      ))),
        ),
      ],
    );
  }
}
