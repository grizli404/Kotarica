import 'package:app/main.dart';
import 'package:app/model/notification_model.dart';
import 'package:app/screens/notifications/components/notification_bar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationScreenState();
  }
}

class NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> res = [];
  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  _getNotifications() async {
    res = await hubConnection
        .invoke("GetNotificationsHistory", args: <dynamic>[korisnikInfo.id]);
    for (dynamic index in res) {
      print(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Obaveštenja",
          style: TextStyle(color: kBackgroundColor),
        ),
        centerTitle: true,
        //backgroundColor: kPrimaryColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(36),
        //   ),
        // ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            final notification = notificationList[index];
            return Dismissible(
              key: Key(notification.nazivProizoda),
              child: NotificationBar(message: notification.nazivProizoda),
              onDismissed: (direction) {
                setState(() {
                  notificationList.removeAt(index);
                });
                //removeFromBlock();
                //ili
                //removeCookie();
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(top: 16),
        child: SizedBox.expand(
          child: RaisedButton(
            onPressed: () {
              dismissAllNotifications();
              setState(() {});
            },
            child: Text(
              "Izbrišite sva obaveštenja",
              style: TextStyle(color: kBackgroundColor),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
