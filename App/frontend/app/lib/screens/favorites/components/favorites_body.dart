import 'package:app/components/product_card.dart';
import 'package:app/model/favoritesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ListView.builder(
          itemCount: favoritesList.length,
          itemBuilder: (context, index) {
            return Text("test");
          },
        ),
      ),
    );
  }
}
