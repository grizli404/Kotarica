import 'package:app/api/api_login.dart';
import 'package:app/components/already_have_an_account_check.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/model/login_model.dart';
import 'package:app/screens/login/components/background.dart';
import 'package:app/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypt/crypt.dart';

class _BodyState extends State<Body> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  final scaffoldKey;

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
              onChanged: (input) => requestModel.email = input,
              validator: (input) => !input.contains("@") ? "Missing @" : null,
            ),
            RoundedPasswordField(
              onChanged: (input) => requestModel.password = input,
              validator: (input) => input.length < 3 ? "Too short!" : null,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                if (validateAndSave()) {
                  requestModel.password =
                      Crypt.sha256(requestModel.password).toString();
                  print(requestModel.password);
                  setState(() {
                    isApiCallProcess = true;
                  });
                  APILogin apiService = new APILogin();
                  apiService.login(requestModel).then((value) {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (value.token.isNotEmpty) {
                      final snackBar = SnackBar(
                        content: Text("Login success!"),
                      );
                      scaffoldKey.currentState.showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: Text(value.error),
                      );
                      scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  });
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }),
                  );*/
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
