import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../repositories/repositories.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthRepository _authRepository = AuthRepository();

  SigninBloc() : super(SigninInitial());

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is SigninWithGooglePressed) {
      try {
        await _authRepository.signInWithGoogle();

        final user = await _authRepository.getUser();
        final isFirstTime = await _authRepository.isFirstTime(user.uid);

        if (!isFirstTime) {
          await _authRepository.storeUser(user);
        }

        yield SigninSuccess();
      } catch (e) {
        yield SigninFailure(error: e.toString());
      }
    }
  }
}
