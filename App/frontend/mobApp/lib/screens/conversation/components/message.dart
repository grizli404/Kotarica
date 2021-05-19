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
          if (message.isSender)
            MessageStatusDot(
              status: message.sent ? true : false,
            ),
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final bool status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(bool status) {
      switch (status) {
        case true:
          return Theme.of(context).primaryColor;
          break;
        case false:
          return Colors.red;
          break;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 3),
      height: 12,
      width: 12,
      decoration:
          BoxDecoration(color: dotColor(status), shape: BoxShape.circle),
      child: Icon(status ? Icons.done : Icons.close,
          size: 8, color: Theme.of(context).scaffoldBackgroundColor),
    );
  }
}
