//import 'package:app/api/api_login.dart';
import 'package:app/components/already_have_an_account_check.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/login_model.dart';
import 'package:app/screens/home/homeScreen.dart';
import 'package:app/screens/login/components/background.dart';
import 'package:app/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:crypt/crypt.dart';
import 'package:provider/provider.dart';

class _BodyState extends State<Body> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  final scaffoldKey;
  var _email, _password;
  _BodyState({this.scaffoldKey});

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
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
      child: Form(
        key: globalFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/shopping-basket.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              hintText: "Your email",
              onChanged: (input) => _email = input,
              // validator: (input) => !input.contains("@") ? "Missing @" : null,
            ),
            RoundedPasswordField(
              onChanged: (input) => _password = input,
              validator: (input) => input.length < 3 ? "Too short!" : null,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                if (validateAndSave()) {
                  //    Crypt.sha256(requestModel.password).toString();
                  setState(() {
                    isApiCallProcess = true;
                  });
                  int id = await korisnik.login(_email, _password);
                  if (id != 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }),
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("uspesno!")));
                  } else {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("neuspesno!")));
                    print("Neuspesan login!");
                  }

                  //print(requestModel.toJson());
                }
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
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

class Body extends StatefulWidget {
  final scaffoldKey;
  Body({
    Key key,
    this.scaffoldKey,
  });

  _BodyState createState() => _BodyState(scaffoldKey: scaffoldKey);
}
