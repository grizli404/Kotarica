import 'package:app/components/customAppBar.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/contracts.dart';

import 'components/chooser.dart';

class PersonalData {
  PersonalData(
      {@required this.ime,
      @required this.kontakt,
      @required this.adresa,
      @required this.postanskiBroj,
      @required this.opis,
      @required this.privateKey});
  String ime, kontakt, adresa, postanskiBroj, opis, privateKey;
}

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    this.shippingConfig = true,
    this.paymentConfig = false,
    this.confirmConfig = false,
    this.onArrival = false,
    this.online = true,
    this.personalData,
  });
  bool onArrival;
  bool online;
  bool shippingConfig;
  bool paymentConfig;
  bool confirmConfig;
  PersonalData personalData;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Widget build(BuildContext context) {
    print(
        "${widget.personalData.ime}\n${widget.personalData.kontakt}\n${widget.personalData.adresa}\n${widget.personalData.postanskiBroj}\n${widget.personalData.opis}");
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Chooser(
            shippingSetter: setShipping,
            paymentSetter: setPayment,
            confirmSetter: setConfirm,
            shipping: widget.shippingConfig,
            payment: widget.paymentConfig,
            confirm: widget.confirmConfig,
          ),
          if (widget.shippingConfig == true) ...[
            ShippingConfiguration(
              personalData: widget.personalData,
              setInfo: shippingInfo,
              setPayment: setPayment,
            )
          ],
          if (widget.paymentConfig == true) ...[
            PaymentConfiguration(
              onArrival: widget.onArrival,
              online: widget.online,
              setConfirm: setConfirm,
              setPaymentMethod: setPaymentMethod,
              personalData: widget.personalData,
            )
          ],
          if (widget.confirmConfig == true) ...[
            ConfirmConfiguration(
              personalData: widget.personalData,
            )
          ]
        ],
      )),
    );
  }

  void shippingInfo(
      {String ime = '',
      String kontakt = '',
      String adresa = '',
      String postanskiBroj = '',
      String opis = ''}) {
    setState(() {
      if (ime != '') widget.personalData.ime = ime;
      if (kontakt != '') widget.personalData.kontakt = kontakt;
      if (adresa != '') widget.personalData.adresa = adresa;
      if (postanskiBroj != '')
        widget.personalData.postanskiBroj = postanskiBroj;
      if (opis != '') widget.personalData.opis = opis;
    });
  }

  void setShipping(bool value) {
    setState(() {
      widget.shippingConfig = value;
      widget.paymentConfig = !value;
      widget.confirmConfig = !value;
    });
  }

  void setPayment(bool value) {
    setState(() {
      widget.paymentConfig = value;
      widget.shippingConfig = !value;
      widget.confirmConfig = !value;
    });
  }

  void setConfirm(bool value) {
    setState(() {
      widget.confirmConfig = value;
      widget.paymentConfig = !value;
      widget.shippingConfig = !value;
    });
  }

  void setPaymentMethod(bool online, bool onArrival) {
    setState(() {
      widget.online = online;
      widget.onArrival = onArrival;
    });
  }
}

class ConfirmConfiguration extends StatelessWidget {
  ConfirmConfiguration({this.personalData});
  PersonalData personalData;
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
        child: Column(
          children: [
            if (personalData.ime != '') ...[
              Text("Ime i prezime: ${personalData.ime}")
            ],
            if (personalData.kontakt != '') ...[
              Text("Kontakt telefon: ${personalData.kontakt}")
            ],
            if (personalData.postanskiBroj != '') ...[
              Text("Postanski broj: ${personalData.postanskiBroj}")
            ],
            if (personalData.adresa != '') ...[
              Text("Adresa: ${personalData.adresa}")
            ],
            if (personalData.opis != '') ...[
              Text("Opis: ${personalData.opis}")
            ],
            if (personalData.privateKey != '') ...[
              Text("Personal Key: ${personalData.privateKey}")
            ]
          ],
        ),
      ),
    );
  }
}

class PaymentConfiguration extends StatefulWidget {
  PaymentConfiguration(
      {this.online = true,
      this.onArrival = false,
      this.setPaymentMethod,
      this.setConfirm,
      this.personalData});
  bool online;
  bool onArrival;
  bool value = true;
  PersonalData personalData;
  Function setPaymentMethod;
  Function setConfirm;
  @override
  _PaymentConfigurationState createState() => _PaymentConfigurationState();
}

class _PaymentConfigurationState extends State<PaymentConfiguration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                Text('Placa se pouzecem'),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Text("< Nazad"),
                    color: Colors.purple,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                  ),
                  FlatButton(
                    onPressed: () {
                      widget.setConfirm(true);
                    },
                    child: Text("Dalje >"),
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

class ShippingConfiguration extends StatelessWidget {
  ShippingConfiguration({this.setInfo, this.setPayment, this.personalData});
  final _formKey = GlobalKey<FormState>();
  final Function setInfo;
  final Function setPayment;
  PersonalData personalData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                color: Colors.white,
                icon: Icons.person,
                hintText: 'Ime i prezime',
                value: personalData.ime,
                onChanged: (value) => {personalData.ime = value},
              ),
              RoundedInputField(
                color: Colors.white,
                icon: Icons.phone,
                hintText: 'Kontakt Telefon',
                value: personalData.kontakt,
                onChanged: (value) => {personalData.kontakt = value},
              ),
              Container(
                width: size.width * 0.8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RoundedInputField(
                        color: Colors.white,
                        icon: Icons.location_city_rounded,
                        hintText: 'Grad i postanski broj',
                        value: personalData.postanskiBroj,
                        onChanged: (value) =>
                            {personalData.postanskiBroj = value},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RoundedInputField(
                        color: Colors.white,
                        icon: Icons.location_on,
                        hintText: 'Adresa i broj',
                        value: personalData.adresa,
                        onChanged: (value) => {personalData.adresa = value},
                      ),
                    ),
                  ],
                ),
              ),
              RoundedInputField(
                color: Colors.white,
                icon: Icons.superscript,
                hintText: 'Nesto fali, ne znam sta',
                value: personalData.opis,
                onChanged: (value) => {personalData.opis = value},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Text("< Nazad"),
                    color: Colors.purple,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                  ),
                  FlatButton(
                    onPressed: () {
                      setInfo(
                        ime: personalData.ime,
                        kontakt: personalData.kontakt,
                        adresa: personalData.adresa,
                        postanskiBroj: personalData.postanskiBroj,
                        opis: personalData.opis,
                      );
                      setPayment(true);
                    },
                    child: Text("Dalje >"),
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
