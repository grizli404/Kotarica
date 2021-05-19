import 'package:app/model/chats.dart';
import 'package:app/screens/conversation/conversation_screen.dart';
import 'package:flutter/material.dart';
//import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'chat_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                  chat: chatsData[index],
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
