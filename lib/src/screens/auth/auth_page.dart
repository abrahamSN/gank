import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_button/sign_button.dart';
import 'package:video_player/video_player.dart';

import '../../blocs/blocs.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        _controller.play();
        _controller.setVolume(0);
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state is SigninFailure) {
          return Container(
            child: Center(
              child: Text('gagal'),
            ),
          );
        }
        if (state is SigninSuccess) {
          context.bloc<AuthBloc>().add(LoggedIn());
        }
      },
      child: Scaffold(
        body: _bodyBuilder(context),
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child:
                    VideoPlayer(_controller),
                    // Container(),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black54,
                  Colors.black,
                ],
              ),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, '/welcome');
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                            shadows: [
                              Shadow(
                                offset: Offset(0.0, 1.0),
                                blurRadius: 5.0,
                                color: Colors.black87,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                FlutterLogo(
                  size: 100.0,
                ),
                Spacer(),
                _btnSocial(context),
                _tos(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _btnSocial(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 70 / 100,
      child: Column(
        children: [
          SignInButton(
            buttonType: ButtonType.google,
            onPressed: () {
              context.bloc<SigninBloc>().add(SigninWithGooglePressed());
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 0.0,
            ),
            width: double.infinity,
            child: InkWell(
              onTap: () {},
              child: Text(
                'Trouble signin in?',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tos(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 70 / 100,
      padding: EdgeInsets.only(bottom: 20.0),
      child: Text(
        'By continuing, you agree to our \n'
        ' Terms of Service, Privacy Policy and Community Rules.\n'
        ' (CA residents: CCPA)',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
