import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isSender;
  final String senderId;
  final String receiverId;
  final String time;

  ChatMessage({
    @required this.senderId,
    @required this.receiverId,
    @required this.time,
    @required this.text,
    @required this.isSender,
  });
}
