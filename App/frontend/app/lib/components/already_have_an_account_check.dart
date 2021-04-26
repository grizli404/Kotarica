import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Nemate nalog ? " : "Imate nalog ? ",
          style: TextStyle(
              color: Theme.of(context).colorScheme == ColorScheme.dark()
                  ? Colors.grey.shade400
                  : kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Registrujte se" : "Prijavite se",
            style: TextStyle(
              color: Theme.of(context).colorScheme == ColorScheme.dark()
                  ? Colors.grey.shade400
                  : kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
