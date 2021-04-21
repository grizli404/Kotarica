import 'package:app/screens/favorites/components/favorites_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Omiljeni proizvodi"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(36),
        )),
      ),
      body: Container(),
    );
  }
}
