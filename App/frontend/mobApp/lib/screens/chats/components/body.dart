import 'dart:core';
import 'package:intl/intl.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/main.dart';
import 'package:app/model/chats.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/screens/conversation/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  }

  startConnection() async {
    if (hubConnection.state == HubConnectionState.disconnected) {
      print("Startujem konekciju");
      await hubConnection.start();

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

  void didChangeDependencies() {
    super.didChangeDependencies();
    uzmiInbox();
  }

  uzmiInbox() async {
    await startConnection();
    try {
      List<dynamic> res = await hubConnection
          .invoke('GetInbox', args: <dynamic>[korisnikInfo.id]);
      print(res);
      Korisnik korisnik;
      if (Provider.of<KorisniciModel>(context, listen: false).ugovor != null) {
        for (dynamic index in res) {
          korisnik = await Provider.of<KorisniciModel>(context, listen: false)
              .dajKorisnikaZaId(
                  korisnikInfo.id == index['ko'] ? index['kome'] : index['ko']);
          chats.add(new Chat(
              image: '',
              message: index['sta'],
              sagovornik: korisnik,
              time: TimeAgo.timeAgoSinceDate(index['kada']).toString()));
        }
        setState(() {
          inAsyncCall = false;
        });
      } else
        Provider.of<KorisniciModel>(context, listen: false)
            .addListener(() async {
          for (dynamic index in res) {
            korisnik = await Provider.of<KorisniciModel>(context, listen: false)
                .dajKorisnikaZaId(korisnikInfo.id == index['ko']
                    ? index['kome']
                    : index['ko']);
            chats.add(new Chat(
                image: '',
                message: index['sta'],
                sagovornik: korisnik,
                time: TimeAgo.timeAgoSinceDate(index['kada']).toString()));
          }
          setState(() {
            inAsyncCall = false;
          });
        });
    } catch (e) {
      print(e);
    }

    hubConnection.stop();
  }

  Widget build(BuildContext context) {
    return ProgressHUD(child: _build(context), inAsyncCall: inAsyncCall);
  }

  @override
  Widget _build(BuildContext context) {
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

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    final date1 = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date1) - Duration(minutes: 732);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? 'pre 1 nedelje' : 'prošle nedelje';
    } else if (difference.inDays >= 2) {
      return 'pre ${difference.inDays} dana';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'pre 1 dana' : 'juče';
    } else if (difference.inHours >= 2) {
      return 'pre ${difference.inHours} sati';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? 'pre 1 sat' : 'pre sat';
    } else if (difference.inMinutes >= 2) {
      return 'pre ${difference.inMinutes} minuta';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? 'pre 1 minuta' : 'pre minut';
    } else if (difference.inSeconds >= 3) {
      return 'pre ${difference.inSeconds} sekundi';
    } else {
      return 'upravo...';
    }
  }
}
