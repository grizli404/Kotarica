<<<<<<< HEAD
import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
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
import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
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
