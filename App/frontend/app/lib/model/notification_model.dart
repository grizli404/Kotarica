import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/cupertino.dart';

class Notification {
  final String message;
  final Proizvod proizvod;
  final int id;

  Notification({this.proizvod, @required this.message, @required this.id});
}

Proizvod demoProizvod = Proizvod(
    cena: 100,
    id: 10,
    idKategorije: 1,
    idKorisnika: 1,
    kolicina: 10,
    naziv: "jaja-test");

List<Notification> notificationList = [
  Notification(message: "Narudzbina1", id: 1, proizvod: demoProizvod),
  Notification(message: "Narudzbina2", id: 1),
];

void dismissAllNotifications() {
  notificationList.clear();
  //remove from block or cookie implementation
}
