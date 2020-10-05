part of 'message_bloc.dart';

@immutable
abstract class MessageState extends Equatable {}

class MessageInitial extends MessageState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MessageFetchLoading extends MessageState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MessageFetchSuccess extends MessageState {
  final Stream<QuerySnapshot> messages;

  MessageFetchSuccess({this.messages});

  @override
  // TODO: implement props
  List<Object> get props => [messages];
}

class MessageFetchFailure extends MessageState {
  final String error;

  MessageFetchFailure({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}