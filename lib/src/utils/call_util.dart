import 'dart:math';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'package:gank/src/repositories/call_repository.dart';
import 'package:gank/src/screens/screens.dart';

class CallUtil {
  static final CallRepository callRepository = CallRepository();

  static dial({fromUid, fromName, toUid, toName, context}) async {
    CallModel call = CallModel(
      callerId: fromUid,
      callerName: fromName,
      receiverId: toUid,
      receiverName: toName,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callRepository.makeCall(call: call);

    bool hasDialed = true;

    if (callMade) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => PickupLayout()),
      );
    }
  }
}
