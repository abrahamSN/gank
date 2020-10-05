part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticatedButNotSet extends AuthState {
  final User user;

  AuthenticatedButNotSet(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class Authenticated extends AuthState {
  final User user;

  Authenticated({this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class UnAuthenticated extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ErrorAuthenticated extends AuthState {
  final String msg;

  ErrorAuthenticated({this.msg});

  @override
  List<Object> get props => [msg];
}