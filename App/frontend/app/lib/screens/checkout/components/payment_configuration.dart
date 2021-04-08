import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class PaymentConfiguration extends StatefulWidget {
  PaymentConfiguration(
      {this.online = true, this.onArrival = false, this.personalData});
  bool online;
  bool onArrival;
  PersonalData personalData;
  @override
  _PaymentConfigurationState createState() => _PaymentConfigurationState();
}

class _PaymentConfigurationState extends State<PaymentConfiguration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Plati online'),
                  Checkbox(
                    checkColor: kPrimaryColor,
                    value: widget.online,
                    onChanged: (value) {
                      setState(() {
                        widget.online = value;
                        widget.onArrival = !value;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  Text('Plati pouzecem'),
                  Checkbox(
                    value: widget.onArrival,
                    checkColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        widget.online = !value;
                        widget.onArrival = value;
                      });
                    },
                  )
                ],
              ),
              if (widget.online == true) ...[
                RoundedInputField(
                  color: Colors.white,
                  hintText: 'Adresa Ethereum naloga',
                  icon: Icons.payment,
                ),
                RoundedInputField(
                  color: Colors.white,
                  hintText: 'Kljuc Ethereum naloga',
                  value: widget.personalData.privateKey,
                  icon: Icons.payment,
                  onChanged: (value) {
                    widget.personalData.privateKey = value;
                  },
                )
              ],
              if (widget.onArrival == true) ...[
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
