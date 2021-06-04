import 'package:app/components/progress_hud.dart';
import 'package:app/model/chat_message.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'chat_input_field.dart';
import 'message.dart';
import 'package:app/main.dart';

class Body extends StatefulWidget {
  final Korisnik sagovornik;

  const Body({Key key, this.sagovornik}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  HubConnection hubConnection;

  ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages = [];
  List<ChatMessage> sending = [];
  bool inAsyncCall = true;
  String _url = "http://147.91.204.116:11098/ChatHub";
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

  Widget build(BuildContext context) {
    return ProgressHUD(child: _build(context), inAsyncCall: inAsyncCall);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    hubConnection.stop();
  }

  @override
  Widget _build(BuildContext context) {
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

  void _initConnection() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(_url, HttpConnectionOptions(logging: (l, m) => {print(m)}))
        .build();
    hubConnection.onclose((exception) {
      print(exception);
      print("\nCONNECTION CLOSED!");
    });
    hubConnection.on('newMessage', _handleNewMessage);
    hubConnection.on('sendingStatus', _handleSendingStatus);
    await startConnection();
    getMessageHistory(korisnikInfo.id, widget.sagovornik.id);
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

  void _handleSendingStatus(var arguments) {
    if (arguments[0] is int) {
      messages.forEach((element) {
        if (arguments[0] == element.id) {
          setState(() {
            element.sent = true;
          });
        }
      });
    }
  }

  void _handleNewMessage(var arguments) {
    print("primljeno...");
    if (arguments[0]['kome'] == korisnikInfo.id) {
      setState(() {
        messages.add(new ChatMessage(
          id: messages.length,
          senderId: arguments[0]['ko'],
          receiverId: arguments[0]['kome'],
          text: arguments[0]['sta'],
          time: arguments[0]['kada'],
          isSender: false,
        ));
      });
    }
  }

  void sendPrivate(String text) async {
    startConnection();
    int id;
    setState(() {
      messages.add(new ChatMessage(
          id: id = messages.length,
          senderId: korisnikInfo.id,
          receiverId: 1,
          text: text,
          time: TimeOfDay.now().toString(),
          isSender: true,
          sent: false));
    });
    await hubConnection.invoke('SendPrivate',
        args: <dynamic>[id, korisnikInfo.id, widget.sagovornik.id, text]);
  }

  void getMessageHistory(int senderId, int receiverId) async {
    messages = [];
    startConnection();
    List<dynamic> res = await hubConnection
        .invoke('GetMessageHistory', args: <dynamic>[senderId, receiverId]);

    for (dynamic index in res) {
      setState(() {
        messages.add(new ChatMessage(
            id: messages.length,
            isSender: index['ko'] == korisnikInfo.id ? true : false,
            receiverId: index['kome'],
            senderId: index['ko'],
            text: index['sta'],
            time: index['kada'],
            sent: true));
      });
    }
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
