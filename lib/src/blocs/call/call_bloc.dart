import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../repositories/repositories.dart';
import '../../models/models.dart';

part 'call_event.dart';

part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository _callRepository = CallRepository();

  CallBloc() : super(CallInitial());

  @override
  Stream<CallState> mapEventToState(
    CallEvent event,
  ) async* {
    if (event is InitCallEvent) {
      yield CallInitial();
    } else if (event is StartCallEvent) {
      final uid = FirebaseAuth.instance.currentUser.uid;
      CallModel call = CallModel(
        callerId: event.fromUid,
        callerName: event.fromName,
        receiverId: event.toUid,
        receiverName: event.toName,
        channelId: event.channel,
      );
      final callData = await _callRepository.callStream(uid: uid);
      if (!callData['exist']) {
        bool callMade = await _callRepository.makeCall(call: call);

        bool hasDialed = true;
        print('ini call made $callMade');

        if (callMade) {
          yield CallStartCalling(call: call);
        }
      } else {
        call.channelId = callData['channelId'];
        yield CallStartCalling(call: call);
      }
    } else if (event is EndCallEvent) {
      final call = event.call;

      bool callDelete = await _callRepository.endCall(call: call);

      if (callDelete) {
        yield CallInitial();
      }
    } else if (event is RcvCallEvent) {
      final call = event.call;

      yield CallStartRecving(call: call);
    }
  }
}
