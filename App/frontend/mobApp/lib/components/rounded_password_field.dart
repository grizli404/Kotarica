import 'package:app/components/text_field_container.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final validator;
  final Color color;
  final String value;
  final double sizeQ;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.validator,
    this.hintText,
    this.icon,
    this.color,
    this.value,
    this.sizeQ,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState(
      onChanged: onChanged,
      validator: validator,
      hintText: hintText,
      value: value,
      color: color);
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;
  final String hintText;
  final IconData icon;
  final onChanged;
  final validator;
  final Color color;
  final String value;
  final double sizeQ;

  _RoundedPasswordFieldState({
    this.hintText = 'Password',
    this.icon,
    this.color,
    this.value,
    this.sizeQ,
    this.validator,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: Theme.of(context).colorScheme == ColorScheme.dark()
          ? Theme.of(context).primaryColor
          : kPrimaryLightColor,
      child: TextFormField(
        initialValue: value,
        validator: validator,
        onChanged: widget.onChanged,
        obscureText: _isHidden,
        decoration: InputDecoration(
          errorMaxLines: 2,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).accentColor,
          ),
          suffixIcon: InkWell(
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).accentColor,
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
