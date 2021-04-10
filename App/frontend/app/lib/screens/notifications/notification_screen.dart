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
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(36),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            return Container(
                child: NotificationBar(
              message: '${notificationList[index].message}',
            ));
          },
        ),
      ),
      bottomNavigationBar: DismissAllNotifications(),
    );
  }
}

class DismissAllNotifications extends StatelessWidget {
  final int token;

  const DismissAllNotifications({
    Key key,
    this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 16),
      child: SizedBox.expand(
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            "Dismiss All Notifications",
            style: TextStyle(color: kBackgroundColor),
          ),
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
