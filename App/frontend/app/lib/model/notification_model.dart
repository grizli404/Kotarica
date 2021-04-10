import 'package:flutter/cupertino.dart';

class NotificationModel {
  final String message;
  final int id;

  NotificationModel({@required this.message, @required this.id});
}

List<NotificationModel> notificationList = [
  NotificationModel(message: "Narudzbina1", id: 1),
  NotificationModel(message: "Narudzbina2", id: 1),
];
