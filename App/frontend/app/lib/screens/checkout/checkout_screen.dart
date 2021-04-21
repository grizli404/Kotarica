import 'package:app/components/customAppBar.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/constants.dart';
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
      appBar: AppBar(
        title: Text("Kotarica"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/cart', arguments: {});
                }, // korpa
              ),
            ],
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Container(
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
                  ),
                ],
                if (widget.confirmConfig == true) ...[
                  ConfirmConfiguration(
                    personalData: widget.personalData,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme == ColorScheme.dark()
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              onPressed: widget.shippingConfig ? null : setPrevious,
              disabledColor: Colors.grey,
              child: Row(
                  children: [Icon(Icons.arrow_back_rounded), Text("Nazad")]),
              color: kPrimaryLightColor,
              textColor: Theme.of(context).primaryColor,
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
                color: kPrimaryLightColor,
                textColor: Theme.of(context).primaryColor,
              )
            ] else ...[
              FlatButton(
                onPressed: () {},
                child:
                    Row(children: [Text("Naruci!"), Icon(Icons.check_rounded)]),
                color: kPrimaryLightColor,
                textColor: Theme.of(context).primaryColor,
              )
            ],
          ],
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
