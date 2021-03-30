import 'package:app/components/drawer.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/screens/home/homeScreenLayout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        iphone: HomeScreenLayout(),
        ipad: Row(
          children: [
            Expanded(
              flex: _size.width > 1200 && _size.width < 1340 ? 2 : 4,
              child: ListenToDrawerEvent(),
            ),
            Expanded(
              flex: _size.width > 1200 && _size.width < 1340 ? 8 : 10,
              child: HomeScreenLayout(),
            ),
          ],
        ),
        macbook: Row(
          children: [
            //   Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
            Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: ListenToDrawerEvent(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: HomeScreenLayout(),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 130.0),
            // ),
          ],
        ),
      ),
    );
  }
}
