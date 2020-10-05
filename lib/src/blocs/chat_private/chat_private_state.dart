part of 'chat_private_bloc.dart';

@immutable
abstract class ChatPrivateState {}

class ChatPrivateInitial extends ChatPrivateState {}


class ChatPrivateFetchLoading extends ChatPrivateState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatPrivateFetchSuccess extends ChatPrivateState {
  final Stream<QuerySnapshot> chats;

  ChatPrivateFetchSuccess({this.chats});

  @override
  // TODO: implement props
  List<Object> get props => [chats];
}

class ChatPrivateFetchFailure extends ChatPrivateState {
  final String error;

  ChatPrivateFetchFailure({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}