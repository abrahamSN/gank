import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderName;
  String senderId;
  String selectedUserId;
  String text;
  Timestamp timeStamp;

  MessageModel({
    this.text,
    this.senderName,
    this.senderId,
    this.selectedUserId,
    this.timeStamp,
  });
}