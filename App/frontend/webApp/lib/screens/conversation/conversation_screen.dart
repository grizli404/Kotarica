import 'package:app/model/korisniciModel.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ConversationScreen extends StatelessWidget {
  final Korisnik sagovornik;

  const ConversationScreen({Key key, this.sagovornik}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(sagovornik: sagovornik),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackButton(),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircleAvatar(
          //   backgroundImage: AssetImage("assets/images/cookiechoco.jpg"),
          // ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sagovornik.ime + ' ' + sagovornik.prezime,
                style: TextStyle(fontSize: 16),
              )
            ],
          )
        ],
      ),
      actions: [],
    );
  }
}
