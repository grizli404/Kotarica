import 'dart:async';

import 'package:app/model/chat_message.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  HubConnection hubConnection;
  Korisnik korisnikInfo = Korisnik(id: 1);

  ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages = [];
  List<ChatMessage> sending = [];
  String _url = "http://147.91.204.116:11094/ChatHub";
  // Widget chatInputField;
  @override
  void initState() {
    messages = [];
    super.initState();
    // chatInputField = ChatInputField(
    //   key: UniqueKey(),
    //   sendMessage: sendPrivate,
    // );
    _initConnection();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) =>
                  Message(message: messages[index]),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ChatInputField(
          sendMessage: sendPrivate,
        ),
      ],
    );
  }

  List<dynamic> _invokeGetMessageHistory(String senderID, String receiverID) {
    List<String> a = [];
    //ovde treba da se dobije id sagovornika sa korisnikModela??vrv
    a.add(senderID);
    a.add(receiverID);
    return a;
  }

  void _initConnection() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(_url, HttpConnectionOptions(logging: (l, m) => {print(m)}))
        .build();
    hubConnection.onclose((exception) {
      print(exception);
      print("\nCONNECTION CLOSED!");
    });
    hubConnection.on('newMessage', _handleNewMessage);
    await hubConnection.start();
    hubConnection.state == HubConnectionState.connected
        ? print("CONNECTED")
        : print("CONNECTING FAILED");
    var stream = await hubConnection.invoke('GetMessageHistory',
        args: <dynamic>[korisnikInfo.id, korisnikInfo.id]);
    print("PRINT:" + stream.toString());
  }

  void _handleNewMessage(var arguments) {
    if (arguments[0]['ko'] == korisnikInfo.id.toString()) {
      messages.forEach((element) {
        if (arguments[0]['sta'] == element.text) {
          setState(() {
            element.sent = true;
          });
        }
      });
    }
    if (arguments[0]['kome'] == korisnikInfo.id.toString()) {
      setState(() {
        messages.add(new ChatMessage(
          senderId: arguments[0]['ko'],
          receiverId: arguments[0]['kome'],
          text: arguments[0]['sta'],
          time: arguments[0]['kad'],
          isSender: false,
        ));
      });
    }
  }

  List<dynamic> _invokeSendPrivate(
      String senderID, String receiverID, String text) {
    List<dynamic> a = [senderID, receiverID, text];
    return a;
  }

  void sendPrivate(String receiverID, String text) async {
    if (hubConnection.state == HubConnectionState.disconnected) {
      await hubConnection.start();
    }
    setState(() {
      messages.add(new ChatMessage(
          senderId: korisnikInfo.id.toString(),
          receiverId: receiverID,
          text: text,
          time: TimeOfDay.now().toString(),
          isSender: true,
          sent: false));
    });
    await hubConnection.invoke('SendPrivate',
        args: _invokeSendPrivate(
            korisnikInfo.id.toString(), korisnikInfo.id.toString(), text));
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
