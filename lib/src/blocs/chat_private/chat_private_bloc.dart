import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../repositories/repositories.dart';

part 'chat_private_event.dart';

part 'chat_private_state.dart';

class ChatPrivateBloc extends Bloc<ChatPrivateEvent, ChatPrivateState> {
  final AuthRepository _authRepository = AuthRepository();
  final MessageRepository _messageRepository = MessageRepository();

  ChatPrivateBloc() : super(ChatPrivateInitial());

  @override
  Stream<ChatPrivateState> mapEventToState(
    ChatPrivateEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchingChatPrivate) {
      yield ChatPrivateFetchLoading();

      try {
        final selectedUid = event.selectedId;

        final User user = await _authRepository.getUser();

        final resChat = await _messageRepository.getPrivateChat(
          currentUid: user.uid,
          selectedUid: selectedUid,
        );

        yield ChatPrivateFetchSuccess(chats: resChat);
      } catch (e) {
        yield ChatPrivateFetchFailure(error: e.toString());
      }
    }
  }
}
