import 'package:app/model/chat_message.dart';
import 'package:flutter/material.dart';

import 'text_message.dart';

class Message extends StatelessWidget {
  const Message({
    this.message,
    Key key,
  }) : super(key: key);
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/cookiechoco.jpg"),
            ),
            SizedBox(width: 5)
          ] else
            ...[],
          if (message.isSender) ...[
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          ] else
            ...[],
          Flexible(
            fit: FlexFit.loose,
            child: TextMessage(message: message),
          ),
          if (message.isSender)
            ...[]
          else ...[
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          ],
        ],
      ),
    );
  }
}
