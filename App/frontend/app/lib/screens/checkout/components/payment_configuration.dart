import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class PaymentConfiguration extends StatefulWidget {
  PaymentConfiguration(
      {this.online = true,
      this.onArrival = false,
      this.setPaymentMethod,
      this.setConfirm,
      this.setShipping,
      this.personalData});
  bool online;
  bool onArrival;
  bool value = true;
  PersonalData personalData;
  Function setPaymentMethod;
  Function setConfirm;
  Function setShipping;
  @override
  _PaymentConfigurationState createState() => _PaymentConfigurationState();
}

class _PaymentConfigurationState extends State<PaymentConfiguration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: kPrimaryColor),
              bottom: BorderSide(color: kPrimaryColor),
              left: BorderSide(color: kPrimaryColor),
              right: BorderSide(color: kPrimaryColor)),
          borderRadius: BorderRadius.all(Radius.circular(15))),
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
                          widget.setPaymentMethod(value, !value);
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
                          widget.setPaymentMethod(!value, value);
                          widget.online = !value;
                          widget.onArrival = value;
                        });
                      },
                    )
                  ]),
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
                )
              ],
              if (widget.onArrival == true) ...[
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Placa se pouzecem')),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {
                      widget.setShipping(true);
                    },
                    child: Row(children: [
                      Icon(Icons.arrow_back_rounded),
                      Text("Nazad")
                    ]),
                    color: Colors.purple,
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    onPressed: () {
                      widget.setConfirm(true);
                    },
                    child: Row(children: [
                      Text("Dalje"),
                      Icon(Icons.arrow_forward_rounded),
                    ]),
                    color: Colors.purple,
                    textColor: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
