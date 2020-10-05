import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<CallBloc>(create: (context) => CallBloc()),
        BlocProvider<ChatGlobalBloc>(create: (context) => ChatGlobalBloc()),
        BlocProvider<ChatGlobalActionBloc>(
            create: (context) => ChatGlobalActionBloc()),
        BlocProvider<ChatPrivateBloc>(create: (context) => ChatPrivateBloc()),
        BlocProvider<ChatPrivateActionBloc>(
            create: (context) => ChatPrivateActionBloc()),
        BlocProvider<GameBloc>(create: (context) => GameBloc()),
        BlocProvider<MessageBloc>(create: (context) => MessageBloc()),
        BlocProvider<NavbarBloc>(create: (context) => NavbarBloc()),
        BlocProvider<SigninBloc>(create: (context) => SigninBloc()),
      ],
      child: MaterialApp(
        title: 'Gank',
        initialRoute: '/',
        theme: ThemeData(
          primaryColor: AppTheme().PRIMARY_COLOR,
          scaffoldBackgroundColor: AppTheme().BACKGROUND_COLOR,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: AppTheme().PRIMARY_COLOR,
            selectedIconTheme: IconThemeData(color: AppTheme().SECONDARY_COLOR),
            selectedItemColor: AppTheme().SECONDARY_COLOR,
            unselectedIconTheme: IconThemeData(color: AppTheme().UNACTIVE_TEXT),
            unselectedItemColor: AppTheme().UNACTIVE_TEXT,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: AppTheme().ACTIVE_TEXT,
            ),
            bodyText2: TextStyle(
              color: AppTheme().ACTIVE_TEXT,
            ),
          ),
        ),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial) {
                  return AuthPage();
                }
                if (state is Authenticated) {
                  return HomePage();
                }
                if (state is UnAuthenticated) {
                  return AuthPage();
                }
                return Container();
              },
            );
          },
          '/chat_global': (context) => ChatGlobalPage(),
          '/chat_private': (context) => ChatPrivatePage(),
          '/drink_details': (context) => DrinkDetails(),
        },
      ),
    );
  }
}
