part of 'chat_private_bloc.dart';

@immutable
abstract class ChatPrivateEvent extends Equatable {}

class FetchingChatPrivate extends ChatPrivateEvent {
  final String selectedId;

  FetchingChatPrivate({this.selectedId});

  @override
  // TODO: implement props
  List<Object> get props => [selectedId];
}
