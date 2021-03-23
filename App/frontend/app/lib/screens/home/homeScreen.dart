import 'package:app/components/customAppBar.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../components/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Body(),
      drawer: ListenToDrawerEvent(),
    );
  }
}
