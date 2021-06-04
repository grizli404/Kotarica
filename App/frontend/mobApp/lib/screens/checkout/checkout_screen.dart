import 'dart:async';

import 'package:app/components/progress_hud.dart';
import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/kupovineModel.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/checkout/components/confirm_configuration.dart';
import 'package:app/screens/checkout/components/payment_configuration.dart';
import 'package:app/screens/checkout/components/shipping_configuration.dart';
import 'package:app/screens/home/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../main.dart';

enum payment { online, onArrival }

class CheckoutScreen extends StatefulWidget {
  Korisnik korisnik = Korisnik.clone(korisnikInfo);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  KupovineModel kupovina;
  ProizvodiModel proizvodi;
  payment character = payment.online;

  @override
  initState() {
    super.initState();
  }

  void setChar(payment char) {
    character = char;
  }

  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _build(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _build(BuildContext context) {
    var carts = Provider.of<Carts>(context);
    proizvodi = Provider.of<ProizvodiModel>(context, listen: true);
    kupovina = Provider.of<KupovineModel>(context, listen: true);
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
                  setChar: setChar,
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
              disabledColor: Colors.grey,
              onPressed: kupovina.ugovor != null
                  ? proizvodi.ugovor != null
                      ? () => placeOrder(carts)
                      : null
                  : null,
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

  placeOrder(Carts carts) async {
    if (validateAndSave(formKey1)) {
      setState(() {
        isApiCallProcess = true;
      });
      List<Cart> kupljeni = List<Cart>();
      for (Cart index in carts.demoCarts) {
        try {
          bool ind = false;
          ind = await proizvodi
              .smanjiPrilikomKupovine(index.product.id, index.numOfItems)
              .timeout(const Duration(seconds: 30));

          if (ind) {
            print("smanjen,dodajem u nove kupovine...");
            kupljeni.add(index);
            await kupovina
                .dodavanjeNoveKupovine(index.product.idKorisnika,
                    korisnikInfo.id, index.product.id, index.numOfItems)
                .timeout(const Duration(seconds: 30));
            var res = await kupovina
                .daLiPostojiKupovinaZaOcenjivanjeProizvoda(korisnikInfo.id,
                    index.product.idKorisnika, index.product.id)
                .timeout(const Duration(seconds: 30));

            if (hubConnection.state == HubConnectionState.disconnected) {
              print("Startujem konekciju");
              await hubConnection.start();
              print("STARTED CONNECTION");
            } else {
              print("Connection is open");
            }
            await hubConnection.invoke('Notifikacija', args: <dynamic>[
              korisnikInfo.ime,
              korisnikInfo.brojTelefona,
              korisnikInfo.adresa,
              index.product.naziv,
              index.numOfItems,
              index.product.idKorisnika
            ]);
          }
        } catch (e) {
          print(e);
        }
      }
      setState(() {
        isApiCallProcess = false;
        carts.removeAll();
      });
      var string = '';
      kupljeni.forEach((element) {
        string += element.product.naziv;
        string += ', ';
      });
      if (kupljeni.length != 0)
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Center(child: Text("Narudžbina poslata:")),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 150,
                      ),
                      Text(
                        string,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Plaća se pouzećem!")
                    ],
                  ),
                ),
            barrierDismissible: true);
      else if (kupljeni.isEmpty)
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Center(child: Text("Narudžbina nije poslata")),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cancel_outlined,
                        size: 150,
                      ),
                      Text("Nema dovoljno proizvoda na stanju!")
                    ],
                  ),
                ),
            barrierDismissible: true);
    }
  }

  bool validateAndSave(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
