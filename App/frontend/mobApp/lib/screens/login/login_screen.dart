import 'package:app/model/korisniciModel.dart';
import 'package:app/screens/login/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KorisniciModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        body: Body(
          scaffoldKey: scaffoldKey,
        ),
      ),
    );
  }
}
