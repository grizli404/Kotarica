import 'package:app/components/progress_hud.dart';
import 'package:app/main.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/notification_model.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/notifications/components/notification_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationScreenState();
  }
}

class NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> res;
  List<Notification> notifikacije = [];
  bool inAsyncCall = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _getNotifications();
  }

  _getNotifications() async {
    res = await hubConnection
        .invoke("GetNotificationsHistory", args: <dynamic>[korisnikInfo.id]);
    _loadNotifications();
  }

  _loadNotifications() async {
    if (res != null) {
      for (dynamic index in res) {
        if (index['kome'] == korisnikInfo.id) {
          var poruka = index['poruka'].split("Informacije o isporuci:");
          notifikacije.add(new Notification(
            poruka: poruka[0],
            info: poruka[1],
          ));
        }
      }
    }
    setState(() {
      inAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _build(context), inAsyncCall: inAsyncCall);
  }

  Widget _build(BuildContext context) {
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
          itemCount: notifikacije.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(notifikacije[index].poruka),
              children: [
                Text("Informacije o isporuci:"),
                Text(notifikacije[index].info)
              ],
            );
            //final notification = notificationList[index];
            // return Dismissible(
            //   key: Key(notification.nazivProizoda),
            //   child: NotificationBar(message: notification.nazivProizoda),
            //   onDismissed: (direction) {
            //     setState(() {
            //       notificationList.removeAt(index);
            //     });
            //     //removeFromBlock();
            //     //ili
            //     //removeCookie();
            //   },
            // );
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

class Notification {
  // Korisnik porucilac;
  // Proizvod poruceno;
  final String poruka, info;
//final String ime, broj, adresa;

  const Notification({
    this.poruka,
    this.info,
  });
}
