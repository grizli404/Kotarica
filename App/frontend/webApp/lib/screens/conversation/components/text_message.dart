import 'package:app/model/chat_message.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: message.isSender
              ? Colors.purple[300]
              : Colors.purple[300].withOpacity(0.1),
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        message.text,
        style: TextStyle(
            color: Theme.of(context).colorScheme == ColorScheme.dark()
                ? Colors.white
                : Colors.deepPurple),
        maxLines: 20,
        textDirection: TextDirection.ltr,
        softWrap: true,
      ),
    );
  }
}
