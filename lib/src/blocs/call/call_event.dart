part of 'call_bloc.dart';

@immutable
abstract class CallEvent extends Equatable {}

class InitCallEvent extends CallEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StartCallEvent extends CallEvent {
  final String fromUid;
  final String fromName;
  final String toUid;
  final String toName;
  final String channel;

  StartCallEvent({this.fromUid, this.fromName, this.toUid, this.toName, this.channel});

  @override
  // TODO: implement props
  List<Object> get props => [fromUid, fromName, toUid, toName, channel];
}

class EndCallEvent extends CallEvent {
  final CallModel call;

  EndCallEvent({this.call});

  @override
  // TODO: implement props
  List<Object> get props => [call];
}

class RcvCallEvent extends CallEvent {
  final CallModel call;

  RcvCallEvent({this.call});

  @override
  // TODO: implement props
  List<Object> get props => [call];
}