import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';
import 'components/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      drawer: ListenToDrawerEvent(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset('assets/icons/menu.svg'),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: [
        Row(
          children: [
            Text(
              'Kotarica',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {}, // strana za profil
            ),
          ],
        ),
      ],
    );
  }
}
