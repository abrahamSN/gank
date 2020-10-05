import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gank/src/repositories/message_repository.dart';
import 'package:meta/meta.dart';

part 'chat_global_event.dart';
part 'chat_global_state.dart';

class ChatGlobalBloc extends Bloc<ChatGlobalEvent, ChatGlobalState> {
  final MessageRepository _messageRepository = MessageRepository();
  ChatGlobalBloc() : super(ChatGlobalInitial());

  @override
  Stream<ChatGlobalState> mapEventToState(
    ChatGlobalEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchingChatGlobal) {
      yield ChatGlobalFetchLoading();

      try {
        final resChat = await _messageRepository.getGlobalChat();
        yield ChatGlobalFetchSuccess(chats: resChat);
      } catch (e) {
        yield ChatGlobalFetchFailure(error: e.toString());
      }
    }
  }
}
