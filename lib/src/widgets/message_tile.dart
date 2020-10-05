import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gank/src/repositories/message_repository.dart';

import '../models/models.dart';
import '../repositories/auth_repository.dart';
import '../utils/utils.dart';

class MessageTile extends StatelessWidget {
  final String uid;
  final String name;
  final String time;
  final String chat;
  final Function onPress;

  const MessageTile(
      {Key key, this.uid, this.name, this.time, this.chat, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: CircleAvatar(
        backgroundColor: AppTheme().SECONDARY_COLOR,
        child: Text(
          name[0] + name[1],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            name,
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            time,
            style: new TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: new Text(
          chat,
          style: new TextStyle(
            color: Colors.grey,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
