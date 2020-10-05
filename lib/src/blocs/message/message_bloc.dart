import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final AuthRepository _authRepository = AuthRepository();
  final MessageRepository _messageRepository = MessageRepository();

  MessageBloc() : super(MessageInitial());

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchingMessage) {
      yield MessageFetchLoading();

      try {
        final user = await _authRepository.getUser();
        Stream<QuerySnapshot> messages = await _messageRepository.getAll(
          currentUid: user.uid,
        );

        yield MessageFetchSuccess(messages: messages);
      } catch (e) {
        yield MessageFetchFailure(error: e.toString());
      }
    }
  }
}
