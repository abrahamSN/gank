import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../models/models.dart';

class MessageRepository {
  final _fbMessages = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAll({String currentUid}) {
    try {
      final res = _fbMessages
          .collection('users')
          .doc(currentUid)
          .collection('chats')
          .orderBy('timestamp', descending: false)
          .snapshots();

      return res;
    } catch (e) {
      return e;
    }
  }

  Stream<QuerySnapshot> getGlobalChat() {
    try {
      final res = _fbMessages
          .collection('messages_global')
          .orderBy('timestamp', descending: false)
          .snapshots();

      return res;
    } catch (e) {
      return e;
    }
  }

  Future<QuerySnapshot> sendGlobalChat(
      {String senderName, String senderId, String text}) async {
    try {
      DocumentReference msgRef =
          _fbMessages.collection('messages_global').doc();
      await msgRef.set({
        'sendername': senderName,
        'senderid': senderId,
        'text': text,
        'timestamp': DateTime.now()
      });
    } catch (e) {
      return e;
    }
  }

  Future<MessageModel> getGlobalChatData({String messageId}) async {
    try {
      MessageModel _message = MessageModel();
      DocumentReference msgRef =
          _fbMessages.collection('messages_global').doc(messageId);

      await msgRef.get().then((msg) {
        _message.senderId = msg['senderid'];
        _message.senderName = msg['sendername'];
        _message.timeStamp = msg['timestamp'];
        _message.text = msg['text'];
      });

      return _message;
    } catch (e) {
      return e;
    }
  }

  Stream<QuerySnapshot> getPrivateChat({
    @required String currentUid,
    @required String selectedUid,
  }) {
    try {
      print('$currentUid - $selectedUid');
      final res = _fbMessages
          .collection('users')
          .doc(currentUid)
          .collection('chats')
          .doc(selectedUid)
          .collection('list')
          .orderBy('timestamp', descending: false)
          .snapshots();

      return res;
    } catch (e) {
      return e;
    }
  }

  Future sendPrivateChat({
    String senderId,
    String senderName,
    String selectedUid,
    String selectedName,
    String text,
  }) async {
    try {
      // msgRef
      DocumentReference msgRef = _fbMessages.collection('messages').doc();

      // senderRef
      CollectionReference senderRef = _fbMessages
          .collection('users')
          .doc(senderId)
          .collection('chats')
          .doc(selectedUid)
          .collection('list');

      // sendUserRef
      CollectionReference sendUserRef = _fbMessages
          .collection('users')
          .doc(selectedUid)
          .collection('chats')
          .doc(senderId)
          .collection('list');

      // store chat into message collection
      await msgRef.set({
        'sendername': senderName,
        'senderid': senderId,
        'text': text,
        'timestamp': DateTime.now(),
      });

      senderRef.doc(msgRef.id).set({
        'sendername': senderName,
        'senderid': senderId,
        'text': text,
        'timestamp': DateTime.now(),
      });

      sendUserRef.doc(msgRef.id).set({
        'sendername': senderName,
        'senderid': senderId,
        'text': text,
        'timestamp': DateTime.now(),
      });

      _fbMessages
          .collection('users')
          .doc(senderId)
          .collection('chats')
          .doc(selectedUid)
          .set({
        'name': selectedName,
        'uid': selectedUid,
        'text': text,
        'timestamp': DateTime.now(),
      });

      _fbMessages
          .collection('users')
          .doc(senderId)
          .collection('chats')
          .doc(selectedUid)
          .update({
        'name': selectedName,
        'uid': selectedUid,
        'text': text,
        'timestamp': DateTime.now()
      });

      await _fbMessages
          .collection('users')
          .doc(selectedUid)
          .collection('chats')
          .doc(senderId)
          .set({
        'name': senderName,
        'uid': senderId,
        'text': text,
        'timestamp': DateTime.now()
      });

      await _fbMessages
          .collection('users')
          .doc(selectedUid)
          .collection('chats')
          .doc(senderId)
          .update({
        'name': senderName,
        'uid': senderId,
        'text': text,
        'timestamp': DateTime.now()
      });
    } catch (e) {
      return e;
    }
  }

  Future<MessageModel> getPrivateChatData({String messageId}) async {
    try {
      MessageModel _message = MessageModel();
      DocumentReference msgRef =
      _fbMessages.collection('messages').doc(messageId);

      await msgRef.get().then((msg) {
        _message.senderId = msg['senderid'];
        _message.senderName = msg['sendername'];
        _message.timeStamp = msg['timestamp'];
        _message.text = msg['text'];
      });

      return _message;
    } catch (e) {
      return e;
    }
  }
}
