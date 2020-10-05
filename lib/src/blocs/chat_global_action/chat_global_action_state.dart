part of 'chat_global_action_bloc.dart';

@immutable
abstract class ChatGlobalActionState extends Equatable {}

class ChatGlobalActionInitial extends ChatGlobalActionState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ChatGlobalActionSend extends ChatGlobalActionState {
  final String chatsfield;

  ChatGlobalActionSend({this.chatsfield});

  @override
  List<Object> get props => [chatsfield];
}
