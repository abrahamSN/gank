import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../utils/utils.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitial());

  @override
  Stream<NavbarState> mapEventToState(
    NavbarEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is PickItem) {
      switch (event.props[0]) {
        case 0:
          yield NavbarChangedPage(
            index: 0,
            navbarItem: NavbarItem.GAME,
          );
          break;
        case 1:
          yield NavbarChangedPage(
            index: 1,
            navbarItem: NavbarItem.MESSAGE,
          );
          break;
        case 2:
          yield NavbarChangedPage(
            index: 2,
            navbarItem: NavbarItem.ACCOUNT,
          );
          break;
      }
    }
  }
}
