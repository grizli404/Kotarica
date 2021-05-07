import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Chats"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).accentColor,
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        hoverElevation: 20,
        tooltip: 'Nova konverzacija',
        child: Icon(Icons.message_rounded),
      ),
    );
  }
}
