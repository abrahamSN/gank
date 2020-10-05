part of 'call_bloc.dart';

@immutable
abstract class CallState extends Equatable {}

class CallInitial extends CallState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CallStartCalling extends CallState {
  final CallModel call;

  CallStartCalling({this.call});

  @override
  // TODO: implement props
  List<Object> get props => [call];
}

class CallStartRecving extends CallState {
  final CallModel call;

  CallStartRecving({this.call});

  @override
  // TODO: implement props
  List<Object> get props => [call];
}

class CallEnd extends CallState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
