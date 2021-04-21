//import 'dart:html';

import 'package:app/api/api_signup.dart';
import 'package:app/components/already_have_an_account_check.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/signup_model.dart';
import 'package:app/screens/home/homeScreen.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/signup/components/background.dart';
// ignore: unused_import
import 'package:app/screens/signup/components/or_divider.dart';
// ignore: unused_import
import 'package:app/screens/signup/components/social_icon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class Body extends StatefulWidget {
  final scaffoldKey;
  Body({
    Key key,
    this.scaffoldKey,
  });

  _BodyState createState() => _BodyState(scaffoldKey: scaffoldKey);
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool isApiCallProcess = false;
  final scaffoldKey;

  String _email, _password, _ime, _prezime, _kontakt, _adresa, _username;

  _BodyState({this.scaffoldKey});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _signupSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _signupSetup(BuildContext context) {
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
                "SIGN UP",
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
                hintText: "Your Email",
                onChanged: (input) => _email = input,
                validator: (input) => !input.contains("@") ? "Missing @" : null,
                icon: Icons.mail_rounded,
              ),
              RoundedPasswordField(
                hintText: 'Password',
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Theme.of(context).primaryColor
                    : kPrimaryLightColor,
                onChanged: (input) => _password = input,
                validator: (input) => input.length < 3 ? "Too short!" : null,
              ),
              RoundedInputField(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Theme.of(context).primaryColor
                    : kPrimaryLightColor,
                hintText: "Ime",
                onChanged: (input) => _ime = input,
                validator: (input) => !(input.contains(RegExp(
                        r"([^0-9\.\,\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+)")))
                    ? "Unesite regularno ime"
                    : null,
              ),
              RoundedInputField(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Theme.of(context).primaryColor
                    : kPrimaryLightColor,
                hintText: "Prezime",
                onChanged: (input) => _prezime = input,
                validator: (input) => !(input.contains(RegExp(
                        r"([^0-9\.\,\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+)")))
                    ? "Unesite regularno prezime"
                    : null,
              ),
              RoundedInputField(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Theme.of(context).primaryColor
                    : kPrimaryLightColor,
                hintText: "Kontakt telefon",
                onChanged: (input) => _kontakt = input,
                validator: (input) => !(input.contains(RegExp(
                        r"(\+?( |-|\.)?\d{1,2}( |-|\.)?)?(\(?\d{3}\)?|\d{3})( |-|\.)?(\d{3}( |-|\.)?\d{4})")))
                    ? "Unesite regularan kontakt telefon"
                    : null,
                icon: Icons.phone,
              ),
              RoundedInputField(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Theme.of(context).primaryColor
                    : kPrimaryLightColor,
                hintText: "Adresa i postanski broj",
                onChanged: (input) => _adresa = input,
                icon: Icons.location_city_rounded,
              ),
              RoundedButton(
                color: Theme.of(context).colorScheme == ColorScheme.dark()
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                text: "SIGN UP",
                press: () async {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    _username = _email;
                    await FlutterSession().set('email', _email);
                    korisnikInfo = await korisnik.vratiKorisnikaMail(_email);
                    var response = await korisnik.dodavanjeNovogKorisnika(
                        _email, _password, _ime, _prezime, _kontakt, _adresa);
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (response != 0) {
                      Navigator.popAndPushNamed(context, '/home',
                          arguments: {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Korisnik vec postoji!")));
                    }
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.popAndPushNamed(context, '/login', arguments: {});
                },
              ),
              /*OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: "assets\icons\facebook.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              ),*/
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
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
