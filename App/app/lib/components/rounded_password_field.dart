import 'package:app/components/text_field_container.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _isHidden,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: InkWell(
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onTap: _togglePasswordView,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
