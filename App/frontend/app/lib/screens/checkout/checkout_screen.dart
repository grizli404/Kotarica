import 'package:app/components/customAppBar.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:app/model/personal_data.dart';
import 'package:app/screens/checkout/components/confirm_configuration.dart';
import 'package:app/screens/checkout/components/payment_configuration.dart';
import 'package:app/screens/checkout/components/shipping_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
    this.personalData,
  });
  bool onArrival;
  bool online;
  bool shippingConfig;
  bool paymentConfig;
  bool confirmConfig;
  PersonalData personalData;
  bool isApiCallProcess = false;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _build(context),
      inAsyncCall: widget.isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _build(BuildContext context) {
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
              setShipping: setShipping,
              setPaymentMethod: setPaymentMethod,
              personalData: widget.personalData,
            )
          ],
          if (widget.confirmConfig == true) ...[
            ConfirmConfiguration(
              personalData: widget.personalData,
              setPayment: setPayment,
              setProgressHud: setProgressHud,
            )
          ]
        ],
      )),
    );
  }

  void shippingInfo({
    String ime = '',
    String kontakt = '',
    String adresa = '',
    String postanskiBroj = '',
    String opis = '',
    String privateKey = '',
  }) {
    setState(() {
      if (ime != '') widget.personalData.ime = ime;
      if (kontakt != '') widget.personalData.kontakt = kontakt;
      if (adresa != '') widget.personalData.adresa = adresa;
      if (postanskiBroj != '')
        widget.personalData.postanskiBroj = postanskiBroj;
      if (opis != '') widget.personalData.opis = opis;
      if (privateKey != '') widget.personalData.privateKey = privateKey;
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

  void setProgressHud(bool value) {
    setState(() {
      widget.isApiCallProcess = value;
    });
  }
}
