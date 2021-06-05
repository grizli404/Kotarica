import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

import '../checkout_screen.dart';

class PaymentConfiguration extends StatefulWidget {
  PaymentConfiguration(
      {this.character = payment.online,
      this.korisnik,
      this.formKey,
      this.setChar});
  final formKey;
  Korisnik korisnik;
  payment character;
  var setChar;
  @override
  _PaymentConfigurationState createState() => _PaymentConfigurationState();
}

class _PaymentConfigurationState extends State<PaymentConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20),
        child:Center(child: Text('Plaća se pouzećem'))),
      
    );
  }
}
