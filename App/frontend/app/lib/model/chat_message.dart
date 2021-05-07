import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isSender;
  final String senderId;
  final String receiverId;
  String time;
  bool sent;
  ChatMessage({
    this.sent,
    @required this.senderId,
    @required this.receiverId,
    @required this.time,
    @required this.text,
    @required this.isSender,
  });
}
