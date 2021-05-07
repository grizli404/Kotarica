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
  String _url = "http://localhost:5000/ChatHub";
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
    //hubConnection.invoke('GetMessageHistory', _handleGetMessageHistory);
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

  _handleGetMessageHistory() {}
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
    a.forEach((element) {
      print("foreach:");
      print(element);
    });
    return a;
  }

  void sendPrivate(String receiverID, String text) async {
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
        args: _invokeSendPrivate(korisnikInfo.id.toString(), receiverID, text));
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
