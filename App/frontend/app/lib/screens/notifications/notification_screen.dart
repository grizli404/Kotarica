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
              key: Key(notification.message),
              child: NotificationBar(
                message: notification.message,
                proizvod: notification.proizvod,
              ),
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
