import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank/src/repositories/call_repository.dart';
import 'package:gank/src/utils/app_agora.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';

class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final AppAgora appAgora = AppAgora();
  bool _joined = false;
  int _remoteUid = null;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void dispose() async {
    var engine = await RtcEngine.create(appAgora.APIKEY);
    engine.leaveChannel();
    engine.destroy();
    context.bloc<CallBloc>().add(EndCallEvent());
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await [Permission.camera, Permission.microphone, Permission.storage]
        .request();

    var engine = await RtcEngine.create(appAgora.APIKEY);
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess ${channel} ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = null;
      });
    }));
    await engine.enableVideo();

    final channel = await CallRepository()
        .callStream(uid: FirebaseAuth.instance.currentUser.uid);

    await engine.joinChannel(null, channel['channelId'], null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(builder: (context, state) {
      if (state is CallEnd) {
        Navigator.pop(context);
      }
      if (state is CallStartCalling) {
        print(state.call);
        return WillPopScope(
          onWillPop: () => showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Warning'),
              content: Text('Do you really want to exit'),
              actions: [
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    context
                        .bloc<CallBloc>()
                        .add(EndCallEvent(call: state.call));
                    Navigator.pop(c, true);
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.pop(c, false),
                ),
              ],
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Video Room'),
            ),
            body: Stack(
              children: [
                Center(
                  child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _switch = !_switch;
                        });
                      },
                      child: Center(
                        child: _switch
                            ? _renderLocalPreview()
                            : _renderRemoteVideo(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Container();
    });
  }

  Widget _renderLocalPreview() {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
