import 'package:app/components/customAppBar.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/constants.dart';
import 'package:app/main.dart';
import 'package:app/model/cart.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/kupovineModel.dart';
import 'package:app/model/personal_data.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/checkout/components/confirm_configuration.dart';
import 'package:app/screens/checkout/components/payment_configuration.dart';
import 'package:app/screens/checkout/components/shipping_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    this.shippingConfig = true,
    this.paymentConfig = false,
    this.confirmConfig = false,
  });
  bool shippingConfig;
  bool paymentConfig;
  bool confirmConfig;
  bool isApiCallProcess = false;
  Korisnik korisnik = Korisnik.clone(korisnikInfo);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  var kupovine;
  @override
  initState() {
    super.initState();
    kupovine = KupovineModel();
  }

  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _build(context),
      inAsyncCall: widget.isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _build(BuildContext context) {
    var carts = Provider.of<Carts>(context);
    var kupovina = Provider.of<KupovineModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // title: Chooser(
        //   shipping: widget.shippingConfig,
        //   payment: widget.paymentConfig,
        //   confirm: widget.confirmConfig,
        // ),
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
                // if (widget.shippingConfig == false) ...[
                // AbsorbPointer(
                //   absorbing: true,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         backgroundBlendMode: BlendMode.darken,
                //         color: Colors.black.withOpacity(0.3)),
                //     child: ShippingConfiguration(
                //       korisnik: korisnikInfo,
                //       personalData: widget.personalData,
                //     ),
                //   ),
                // ),
                // ] else ...[
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Divider(
                          height: 5,
                          thickness: 4,
                          color: Theme.of(context).colorScheme ==
                                  ColorScheme.dark()
                              ? Colors.black
                              : kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("ISPORUKA:"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          height: 5,
                          thickness: 4,
                          color: Theme.of(context).colorScheme ==
                                  ColorScheme.dark()
                              ? Colors.black
                              : kPrimaryColor,
                        ),
                      ),
                    ]),
                ShippingConfiguration(
                  formKey: formKey1,
                  korisnik: widget.korisnik,
                ),
                // ],
                // if (widget.paymentConfig == false) ...[
                // AbsorbPointer(
                //   absorbing: true,
                //   child: Container(
                //       decoration: BoxDecoration(
                //           backgroundBlendMode: BlendMode.darken,
                //           color: Colors.black.withOpacity(0.3)),
                //       child: PaymentConfiguration(
                //         personalData: widget.personalData,
                //       )),
                // ),
                // ] else ...[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Divider(
                          height: 5,
                          thickness: 4,
                          color: Theme.of(context).colorScheme ==
                                  ColorScheme.dark()
                              ? Colors.black
                              : kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("NAČIN PLAĆANJA:"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          height: 5,
                          thickness: 4,
                          color: Theme.of(context).colorScheme ==
                                  ColorScheme.dark()
                              ? Colors.black
                              : kPrimaryColor,
                        ),
                      ),
                    ]),
                PaymentConfiguration(
                  formKey: formKey2,
                  korisnik: widget.korisnik,
                ),
                // ],
                // if (widget.confirmConfig == false) ...[
                //   AbsorbPointer(
                //     absorbing: true,
                //     child: Container(
                //         decoration: BoxDecoration(
                //             backgroundBlendMode: BlendMode.darken,
                //             color: Colors.black.withOpacity(0.3)),
                //         child: ConfirmConfiguration(
                //           personalData: widget.personalData,
                //         )),
                //   ),
                // ] else ...[

                Row(children: [
                  Expanded(
                    child: Divider(
                      height: 5,
                      thickness: 4,
                      color: Theme.of(context).colorScheme == ColorScheme.dark()
                          ? Colors.black
                          : kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('KORPA:'),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Divider(
                      height: 5,
                      thickness: 4,
                      color: Theme.of(context).colorScheme == ColorScheme.dark()
                          ? Colors.black
                          : kPrimaryColor,
                    ),
                  ),
                ]),

                ConfirmConfiguration()
                //   ]
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
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
            // FlatButton(
            //   onPressed: widget.shippingConfig ? null : setPrevious,
            //   disabledColor: Colors.grey,
            //   child: Row(
            //       children: [Icon(Icons.arrow_back_rounded), Text("Nazad")]),
            //   color: kPrimaryLightColor,
            //   textColor: Theme.of(context).primaryColor,
            // ),
            // if (!widget.confirmConfig) ...[
            //   FlatButton(
            //     onPressed: () {
            //       setNext();
            //     },
            //     child: Row(children: [
            //       Text("Dalje"),
            //       Icon(Icons.arrow_forward_rounded)
            //     ]),
            //     color: kPrimaryLightColor,
            //     textColor: Theme.of(context).primaryColor,
            //   )
            // ] else ...[
            FlatButton(
              onPressed: () {
                setState(() {
                  widget.isApiCallProcess = true;
                });
                for (Cart index in carts.demoCarts) {
                  kupovine.dodavanjeNoveKupovine(index.product.idKorisnika,
                      korisnikInfo.id, index.product.id, index.numOfItems);
                  print(index.product.idKorisnika.toString() +
                      korisnikInfo.id.toString() +
                      index.product.id.toString() +
                      index.numOfItems.toString());
                }

                setState(() {
                  widget.isApiCallProcess = false;
                });
              },
              child: Row(children: [Text("Naruči"), Icon(Icons.check_rounded)]),
              color: kPrimaryLightColor,
              textColor: Theme.of(context).primaryColor,
            )
            // ],
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
