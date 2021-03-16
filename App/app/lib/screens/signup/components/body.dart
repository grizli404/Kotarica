import 'package:app/api/api_signup.dart';
import 'package:app/components/already_have_an_account_check.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/model/signup_model.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/signup/components/background.dart';
// ignore: unused_import
import 'package:app/screens/signup/components/or_divider.dart';
// ignore: unused_import
import 'package:app/screens/signup/components/social_icon.dart';
import 'package:app/screens/welcome/welcome_screen.dart';
import 'package:crypt/crypt.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  SignupRequestModel requestModel;
  bool isApiCallProcess = false;
  final scaffoldKey;

  _BodyState({this.scaffoldKey});

  @override
  void initState() {
    super.initState();
    requestModel = new SignupRequestModel();
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
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: globalFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
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
              hintText: "Your Email",
              onChanged: (input) => requestModel.email = input,
              validator: (input) => !input.contains("@") ? "Missing @" : null,
            ),
            RoundedPasswordField(
              onChanged: (input) => requestModel.password = input,
              validator: (input) => input.length < 3 ? "Too short!" : null,
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                if (validateAndSave()) {
                  requestModel.password =
                      Crypt.sha256(requestModel.password).toString();
                  print(requestModel.password);
                  setState(() {
                    isApiCallProcess = true;
                  });
                  APISignup apiService = new APISignup();
                  apiService.signup(requestModel).then((value) {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (value.name.isNotEmpty) {
                      final snackBar = SnackBar(
                        content: Text("Signup success!"),
                      );
                      scaffoldKey.currentState.showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: Text("SIGNUP ERROR!"),
                      );
                      scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  });
                  print(requestModel.toJson());
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen();
                    },
                  ));
                }
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
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
