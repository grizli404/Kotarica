import 'package:app/components/customAppBar.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/model/personal_data.dart';
import 'package:app/screens/checkout/components/confirm_configuration.dart';
import 'package:app/screens/checkout/components/payment_configuration.dart';
import 'package:app/screens/checkout/components/shipping_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/chooser.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    this.shippingConfig = true,
    this.paymentConfig = false,
    this.confirmConfig = false,
    this.personalData,
  });
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Chooser(
                shipping: widget.shippingConfig,
                payment: widget.paymentConfig,
                confirm: widget.confirmConfig,
              ),
              if (widget.shippingConfig == true) ...[
                ShippingConfiguration(
                  personalData: widget.personalData,
                ),
              ],
              if (widget.paymentConfig == true) ...[
                PaymentConfiguration(
                  personalData: widget.personalData,
                )
              ],
              if (widget.confirmConfig == true) ...[
                ConfirmConfiguration(
                  personalData: widget.personalData,
                )
              ],
              Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: widget.shippingConfig ? null : setPrevious,
                    disabledColor: Colors.grey,
                    child: Row(children: [
                      Icon(Icons.arrow_back_rounded),
                      Text("Nazad")
                    ]),
                    color: Colors.purple,
                    textColor: Colors.white,
                  ),
                  if (!widget.confirmConfig) ...[
                    FlatButton(
                      onPressed: () {
                        setNext();
                      },
                      child: Row(children: [
                        Text("Dalje"),
                        Icon(Icons.arrow_forward_rounded)
                      ]),
                      color: Colors.purple,
                      textColor: Colors.white,
                    )
                  ] else ...[
                    FlatButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("Naruci!"),
                        Icon(Icons.check_rounded)
                      ]),
                      color: Colors.purple,
                      textColor: Colors.white,
                    )
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  setPrevious() {
    if (widget.paymentConfig == true) {
      setState(() {
        widget.shippingConfig = true;
        widget.paymentConfig = false;
        widget.confirmConfig = false;
      });
    } else if (widget.confirmConfig == true) {
      setState(() {
        widget.confirmConfig = false;
        widget.paymentConfig = true;
        widget.shippingConfig = false;
      });
    }
  }

  setNext() {
    if (widget.shippingConfig == true) {
      setState(() {
        widget.paymentConfig = true;
        widget.shippingConfig = false;
        widget.confirmConfig = false;
      });
    } else if (widget.paymentConfig == true) {
      setState(() {
        widget.confirmConfig = true;
        widget.paymentConfig = false;
        widget.shippingConfig = false;
      });
    }
  }

  void setProgressHud(bool value) {
    setState(() {
      widget.isApiCallProcess = value;
    });
  }
}
