import 'package:app/components/text_field_container.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final validator;
  final Color color;
  final String value;
  final double sizeQ;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.validator,
    this.color = kPrimaryLightColor,
    this.value = '',
    this.sizeQ = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      sizeQ: sizeQ,
      color: color,
      child: TextFormField(
        initialValue: value,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorMaxLines: 2,
          icon: icon == null
              ? null
              : Icon(
                  icon,
                  color: Theme.of(context).accentColor,
                ),
          hintText: this.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
