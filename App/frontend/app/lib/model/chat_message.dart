import 'package:flutter/material.dart';

class ChatMessage {
  final int id;
  final String text;
  final bool isSender;
  final int senderId;
  final int receiverId;
  String time;
  bool sent;
  ChatMessage({
    @required this.id,
    this.sent = false,
    @required this.senderId,
    @required this.receiverId,
    @required this.time,
    @required this.text,
    @required this.isSender,
  });
}
