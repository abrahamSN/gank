part of 'chat_global_bloc.dart';

@immutable
abstract class ChatGlobalState extends Equatable {}

class ChatGlobalInitial extends ChatGlobalState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}


class ChatGlobalFetchLoading extends ChatGlobalState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatGlobalFetchSuccess extends ChatGlobalState {
  final Stream<QuerySnapshot> chats;

  ChatGlobalFetchSuccess({this.chats});

  @override
  // TODO: implement props
  List<Object> get props => [chats];
}

class ChatGlobalFetchFailure extends ChatGlobalState {
  final String error;

  ChatGlobalFetchFailure({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}