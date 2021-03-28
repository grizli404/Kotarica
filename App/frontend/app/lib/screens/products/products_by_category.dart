import '../../constants.dart';

import 'package:flutter/material.dart';

class ProductByCategory extends StatelessWidget {
  final String category;

  const ProductByCategory({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proizvodi "' + category + '" kategorije'),
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(36),
        )),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
