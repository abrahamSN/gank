part of 'signin_bloc.dart';

@immutable
abstract class SigninState extends Equatable {}

class SigninInitial extends SigninState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SigninSuccess extends SigninState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SigninFailure extends SigninState {
  final String error;

  SigninFailure({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];

}