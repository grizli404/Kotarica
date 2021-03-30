import 'package:app/components/customAppBar.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../components/drawer.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isIphone(context)) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Body(),
        drawer: ListenToDrawerEvent(),
      );
    } else {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Body(),
      );
    }
  }
}
