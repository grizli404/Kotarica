import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class PaymentConfiguration extends StatefulWidget {
  PaymentConfiguration(
      {this.character = payment.online, this.korisnik, this.formKey});
  final formKey;
  Korisnik korisnik;
  payment character;
  @override
  _PaymentConfigurationState createState() => _PaymentConfigurationState();
}

enum payment { online, onArrival }

class _PaymentConfigurationState extends State<PaymentConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Plati online'),
                  Radio<payment>(
                    value: payment.online,
                    groupValue: widget.character,
                    onChanged: (payment value) {
                      setState(() {
                        widget.character = value;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  Text('Plati pouzecem'),
                  Radio<payment>(
                    value: payment.onArrival,
                    groupValue: widget.character,
                    onChanged: (payment value) {
                      setState(() {
                        widget.character = value;
                      });
                    },
                  ),
                ],
              ),
              if (widget.character == payment.online) ...[
                RoundedInputField(
                  color: Theme.of(context).colorScheme == ColorScheme.dark()
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  hintText: 'Adresa Ethereum naloga',
                  icon: Icons.payment,
                  // value: korisnikInfo.EthereumAddress,
                  //onChanged: (value){widget.korisnik.EthereumAddress=value},
                ),
                RoundedPasswordField(
                  hintText: 'Privatni kljuc',
                  //value: widget.korisnik.privateKey,
                  onChanged: (value) {
                    //widget.korisnik.privateKey!=null?"dsaf": value;
                  },
                  color: Theme.of(context).colorScheme == ColorScheme.dark()
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                )
              ],
              if (widget.character == payment.onArrival) ...[
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Placa se pouzecem')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
