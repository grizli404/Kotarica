import 'dart:math';

import 'package:app/model/chat_message.dart';
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

  ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages;
  String _url = "http://147.91.204.116:11091/ChatHub";

  @override
  void initState() {
    messages = [];
    super.initState();
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
          sendMessage: sendMessage,
        ),
      ],
    );
  }

  void _initConnection() async {
    hubConnection = HubConnectionBuilder().withUrl(_url).build();
    hubConnection.onclose((exception) {
      print(exception);
      print("\nCONNECTION CLOSED!");
    });
    hubConnection.on('ReceiveMessage', _handleReceiveMessage);
    await hubConnection.start();
  }

  void _handleReceiveMessage(List arguments) {
    setState(() {
      messages.add(new ChatMessage(
          senderId: arguments[0],
          receiverId: arguments[1],
          text: arguments[2],
          time: arguments[3],
          isSender: false));
    });
  }

  void sendMessage(String receiverId, String text) async {
    // await hubConnection.invoke('SendMessage',
    //     args: <Object>["JASAM", receiverId.toString(), text]);
    setState(() {
      messages.add(new ChatMessage(
          senderId: "arguments[0]",
          receiverId: "arguments[1]",
          text: text,
          time: "arguments[3]",
          isSender: Random().nextInt(2) % 2 == 0 ? true : false));
    });
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
