import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key key,
  }) : super(key: key);

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
            RoundedInputField(
              icon: null,
              hintText: "Posalji poruku",
              onChanged: (input) {},
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.send,
              color: kPrimaryLightColor,
            )
          ],
        ),
      ),
    );
  }
}
