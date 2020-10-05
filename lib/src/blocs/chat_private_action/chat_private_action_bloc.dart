import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../repositories/repositories.dart';

part 'chat_private_action_event.dart';
part 'chat_private_action_state.dart';

class ChatPrivateActionBloc extends Bloc<ChatPrivateActionEvent, ChatPrivateActionState> {
  final AuthRepository _authRepository = AuthRepository();
  final MessageRepository _messageRepository = MessageRepository();

  ChatPrivateActionBloc() : super(ChatPrivateActionInitial());

  @override
  Stream<ChatPrivateActionState> mapEventToState(
    ChatPrivateActionEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SendingChatPrivateAction) {
      final User user = await _authRepository.getUser();

      final field = event.text;
      final selectedId = event.selectedUid;
      final selectedName = event.selectedName;

      _messageRepository.sendPrivateChat(
        senderId: user.uid,
        senderName: user.displayName,
        selectedUid: selectedId,
        selectedName: selectedName,
        text: field,
      );

      yield ChatPrivateActionSend(chatsfield: field);
    }
  }
}
