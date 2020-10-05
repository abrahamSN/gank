import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CallRepository {
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection('calls');

  Future<Map<String, dynamic>> callStream({String uid}) async {
    try {
      bool exist;
      String channelId;

      await callCollection.doc(uid).get().then((data) {
        exist = data.exists;
        channelId = data['channel_id'];
      });

      return {
        'exist': exist,
        'channelId': channelId,
      };
    } catch (e) {
      print(e);
      return {
        'exist': false,
      };
    }
  }

  Future<CallModel> getCall() async {
    try {
      CallModel _callModel = CallModel();
      final uid = FirebaseAuth.instance.currentUser.uid;
      final call = callCollection.doc(uid).snapshots();

      callCollection.doc(uid).get().then((call) {
        _callModel.callerId = call['caller_id'];
        _callModel.callerName = call['caller_name'];
        _callModel.receiverId = call['receiver_id'];
        _callModel.receiverName = call['receiver_name'];
        _callModel.channelId = call['channel_id'];
        _callModel.hasDialled = call['has_dialled'];
      });

      print('ini call model: ${_callModel.callerId}');

      return _callModel;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<bool> makeCall({CallModel call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialMap = call.toMap(call);

      callCollection.doc(call.callerId).set(hasDialMap);
      callCollection.doc(call.receiverId).set(hasNotDialMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({CallModel call}) async {
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
