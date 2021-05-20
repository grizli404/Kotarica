import 'dart:convert';

import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/navigationBar.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/body.dart';
import 'package:app/screens/home/homeScreenLayout.dart';
import 'package:flutter/material.dart';

import '../../token.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Body(proizvodi: ProizvodiModel().listaProizvoda),
      drawer: ListenToDrawerEvent(),
      extendBody: true,
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}
