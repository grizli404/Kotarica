//import 'package:app/api/api_login.dart';
import 'dart:async';
import 'dart:convert';

import 'package:app/components/already_have_an_account_check.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/screens/login/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:crypt/crypt.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../token.dart';

class _BodyState extends State<Body> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool isApiCallProcess = false;
  final scaffoldKey;
  String _email, _password;
  _BodyState({this.scaffoldKey});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _loginSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _loginSetup(BuildContext context) {
    KorisniciModel korisnik = Provider.of<KorisniciModel>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: globalFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "PRIJAVA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SvgPicture.asset(
                Theme.of(context).colorScheme == ColorScheme.dark()
                    ? "assets/icons/shopping-basket-dark.svg"
                    : "assets/icons/shopping-basket.svg",
                height: size.height * 0.35,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedInputField(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Theme.of(context).primaryColor
                    : kPrimaryLightColor,
                hintText: "Email",
                onChanged: (input) => _email = input,
                validator: (input) =>
                    !input.contains("@") ? "Nedostaje @" : null,
              ),
              RoundedPasswordField(
                hintText: 'Lozinka',
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Theme.of(context).primaryColor
                    : kPrimaryLightColor,
                onChanged: (input) => _password = input,
                validator: (input) => !(input.contains(RegExp(
                        r"(^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$)")))
                    ? "Mora sadržati najmanje 8 karaktera, veliko slovo, malo slovo, broj!"
                    : null,
              ),
              RoundedButton(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                text: "PRIJAVA",
                press: () => loginAction(korisnik),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.popAndPushNamed(context, '/signup', arguments: {});
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginAction(var korisnik) async {
    if (validateAndSave()) {
      //    Crypt.sha256(requestModel.password).toString();
      setState(() {
        isApiCallProcess = true;
      });
      int id = 0;
      try {
        id = await korisnik.login(_email, _password).timeout(
              const Duration(seconds: 5),
            );
      } on TimeoutException catch (e) {
        print("TIMED OUT ON LOGIN 1!");
        id = 0;
      }

      var jwt = '';
      try {
        //await FlutterSession().set('email', _email);
        jwt = await KorisniciModel.checkUser(_email, _password);
        korisnikInfo = await korisnik
            .vratiKorisnikaMail(_email)
            .timeout(const Duration(seconds: 5));
      } on TimeoutException catch (e) {
        print("TIMED OUT ON LOGIN 2!");
        id = 0;
      }

      if (id != 0 && jwt != 'false') {
        !isWeb
            ? Token.setSecureStorage("jwt", jwt)
            : FlutterSession().set('jwt', jwt);
        // TokenWeb.setToken = jwt;
        //  print('TOKEN');
        //  print('jwt ' + jwt);
        var token = json.decode(
            ascii.decode(base64.decode(base64.normalize(jwt.split('.')[1]))));

        // print('token sub ' + token['unique_name']);

        if (!isWeb) Token.jwt = jwt;
        korisnikInfo = await korisnik.vratiKorisnikaMail(token['unique_name']);
        // print('korisnikInfo ' + korisnikInfo.ime);
        Navigator.popAndPushNamed(context, '/home', arguments: {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Uspešno prijavljivanje!"),
            duration: const Duration(milliseconds: 2000),
            width: MediaQuery.of(context).size.width *
                0.9, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      } else {
        setState(() {
          isApiCallProcess = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Neuspešno prijavljivanje!"),
            duration: const Duration(milliseconds: 2000),
            width: MediaQuery.of(context).size.width *
                0.9, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    }
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

class Body extends StatefulWidget {
  final scaffoldKey;
  Body({
    Key key,
    this.scaffoldKey,
  });

  _BodyState createState() => _BodyState(scaffoldKey: scaffoldKey);
}
