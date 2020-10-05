import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank/src/widgets/widgets.dart';

import '../../blocs/blocs.dart';
import '../../utils/utils.dart';
import '../screens.dart';

class ChatPrivatePage extends StatefulWidget {
  @override
  _ChatPrivatePageState createState() => _ChatPrivatePageState();
}

class _ChatPrivatePageState extends State<ChatPrivatePage> {
  TextEditingController _messageTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${args['selectedName']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              String channel_id = Random().nextInt(1000).toString();
              context.bloc<CallBloc>().add(
                StartCallEvent(
                    fromUid: args['currentUid'],
                    fromName: args['currentName'],
                    toUid: args['selectedId'],
                    toName: args['selectedName'],
                    channel: channel_id),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _bodyBuilder(context, args),
    );
  }

  Widget _bodyBuilder(BuildContext context, Map args) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: BlocBuilder<ChatPrivateBloc, ChatPrivateState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is ChatPrivateFetchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ChatPrivateFetchSuccess) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: state.chats,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Wanna start the conversation ?"),
                          );
                        }

                        if (snapshot.data.docs.isNotEmpty) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            // ignore: missing_return
                            itemBuilder: (BuildContext context, int index) {
                              return ChatItemContainer(
                                isGlobal: false,
                                currentUserId: args['currentUid'],
                                messageId: snapshot.data.docs[index].id,
                              );
                            },
                          );
                        }
                        return Center(
                          child: Text("Wanna start the conversation ?"),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor,
              border: Border(),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              boxShadow: [BoxShadow(blurRadius: 1.0)],
            ),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _messageTextController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message',
                      hintStyle: TextStyle(color: AppTheme().UNACTIVE_TEXT),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    if (_messageTextController.text != '') {
                      context.bloc<ChatPrivateActionBloc>().add(
                        SendingChatPrivateAction(
                          selectedUid: args['selectedId'],
                          selectedName: args['selectedName'],
                          text: _messageTextController.text,
                        ),
                      );
                      _messageTextController.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: AppTheme().SECONDARY_COLOR,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageTextController.dispose();
  }
}
