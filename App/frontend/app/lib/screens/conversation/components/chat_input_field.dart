import 'package:app/components/text_field_container.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final Function sendMessage;
  final TextEditingController _controller = TextEditingController();
  ChatInputField({
    this.sendMessage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              color: kPrimaryColor.withOpacity(1))
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: TextFieldContainer(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: TextField(
                  onSubmitted: (input) {
                    if (_controller.text != '')
                      sendMessage("NEKO", _controller.text);
                    _controller.clear();
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Pošalji poruku...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              child: Icon(
                Icons.send,
                color: kPrimaryLightColor,
              ),
              onTap: () {
                if (_controller.text != '')
                  sendMessage("NEKO", _controller.text);
                _controller.clear();
              },
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
