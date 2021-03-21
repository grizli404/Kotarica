<<<<<<< HEAD
import 'package:app/screens/login/components/body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Body(
        scaffoldKey: scaffoldKey,
      ),
    );
  }
}
=======
import 'package:app/screens/login/components/body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Body(
        scaffoldKey: scaffoldKey,
      ),
    );
  }
}
>>>>>>> 2ef4c09f107e2e28241f6bbd5d22ff5e1f235d19
