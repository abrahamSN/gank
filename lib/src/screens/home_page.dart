import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens.dart';

import '../blocs/blocs.dart';
import '../utils/utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GameBloc>(context);
    BlocProvider.of<NavbarBloc>(context);
    BlocProvider.of<MessageBloc>(context);

    return Scaffold(
      body: _bodyBuilder(),
      bottomNavigationBar: _btmNavBar(),
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        if (state is NavbarChangedPage) {
          switch (state.props[1]) {
            case NavbarItem.GAME:
              context.bloc<GameBloc>().add(FetchingGame());
            return GamePage();
              break;
            case NavbarItem.MESSAGE:
              context.bloc<MessageBloc>().add(FetchingMessage());
            return MessagePage();
              break;
            case NavbarItem.ACCOUNT:
              return AccountPage();
              break;
          }
        }
        return Container();
      },
    );
  }

  Widget _btmNavBar() {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        if (state is NavbarInitial) {
          context.bloc<NavbarBloc>().add(PickItem(index: 0));
        }
        if (state is NavbarChangedPage) {
          return BottomNavigationBar(
            currentIndex: state.props[0],
            onTap: (i) {
              context.bloc<NavbarBloc>().add(PickItem(index: i));
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.game_controller),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.rosette),
                label: 'Account',
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
