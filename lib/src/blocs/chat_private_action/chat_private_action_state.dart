part of 'chat_private_action_bloc.dart';

@immutable
abstract class ChatPrivateActionState extends Equatable {}

class ChatPrivateActionInitial extends ChatPrivateActionState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatPrivateActionSend extends ChatPrivateActionState {
  final String chatsfield;

  ChatPrivateActionSend({this.chatsfield});

  @override
  List<Object> get props => [chatsfield];
}
