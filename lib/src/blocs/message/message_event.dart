part of 'message_bloc.dart';

@immutable
abstract class MessageEvent extends Equatable {}

class FetchingMessage extends MessageEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
