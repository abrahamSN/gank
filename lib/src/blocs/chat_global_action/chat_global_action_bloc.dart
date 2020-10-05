import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../repositories/repositories.dart';

part 'chat_global_action_event.dart';

part 'chat_global_action_state.dart';

class ChatGlobalActionBloc
    extends Bloc<ChatGlobalActionEvent, ChatGlobalActionState> {
  final AuthRepository _authRepository = AuthRepository();
  final MessageRepository _messageRepository = MessageRepository();

  ChatGlobalActionBloc() : super(ChatGlobalActionInitial());

  @override
  Stream<ChatGlobalActionState> mapEventToState(
    ChatGlobalActionEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SendingChatGlobalAction) {
      final User user = await _authRepository.getUser();

      final field = event.props[0];
      _messageRepository.sendGlobalChat(
        senderId: user.uid,
        senderName: user.displayName,
        text: field,
      );

      yield ChatGlobalActionSend(chatsfield: field);
    }
  }
}
