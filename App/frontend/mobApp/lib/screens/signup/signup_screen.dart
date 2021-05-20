import 'package:app/model/korisniciModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
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
