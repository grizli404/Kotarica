import 'package:app/components/customAppBar.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/contracts.dart';

import 'components/chooser.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    this.shippingConfig = true,
    this.paymentConfig = false,
    this.confirmConfig = false,
    this.onArrival = false,
    this.online = true,
  });
  bool onArrival;
  bool online;
  bool shippingConfig;
  bool paymentConfig;
  bool confirmConfig;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Widget build(BuildContext context) {
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
          if (widget.shippingConfig == true) ...[ShippingConfiguration()],
          if (widget.paymentConfig == true) ...[
            PaymentConfiguration(
              onArrival: widget.onArrival,
              online: widget.online,
              setPaymentMethod: setPaymentMethod,
            )
          ],
          if (widget.confirmConfig == true) ...[ConfirmConfiguration()]
        ],
      )),
    );
  }

  void setShipping(bool value) {
    setState(() {
      widget.shippingConfig = value;
    });
  }

  void setPayment(bool value) {
    setState(() {
      widget.paymentConfig = value;
    });
  }

  void setConfirm(bool value) {
    setState(() {
      widget.confirmConfig = value;
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PaymentConfiguration extends StatefulWidget {
  PaymentConfiguration(
      {this.online = true, this.onArrival = false, this.setPaymentMethod});
  bool online;
  bool onArrival;
  bool value = true;
  Function setPaymentMethod;
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
                          widget.setPaymentMethod(value, false);
                          widget.online = value;
                          widget.onArrival = false;
                        });
                      },
                    ),
                    SizedBox(width: 20),
                    Text('Plati pouzecu'),
                    Checkbox(
                      value: widget.onArrival,
                      checkColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          widget.setPaymentMethod(false, value);
                          widget.online = false;
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
                  icon: Icons.payment,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class ShippingConfiguration extends StatelessWidget {
  ShippingConfiguration();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                color: Colors.white,
                icon: Icons.person,
                hintText: 'Ime i prezime',
                value: 'Vasa S. Tajcic',
              ),
              RoundedInputField(
                  color: Colors.white,
                  icon: Icons.phone,
                  hintText: 'Kontakt Telefon',
                  value: '069420007'),
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
                        value: 'Kragujevac 34000',
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
                          value: 'Novosadska 3/1'),
                    ),
                  ],
                ),
              ),
              RoundedInputField(
                  color: Colors.white,
                  icon: Icons.superscript,
                  hintText: 'Nesto fali, ne znam sta',
                  value: 'Nesto fali, ne znam sta'),
            ],
          ),
        ),
      ),
    );
  }
}
