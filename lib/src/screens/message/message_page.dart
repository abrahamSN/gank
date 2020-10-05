import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessageBloc>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _appBar(context),
      body: _bodyBuilder(),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Messages",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.globe),
          onPressed: () {
            context.bloc<ChatGlobalBloc>().add(FetchingChatGlobal());
            Navigator.pushNamed(context, '/chat_global');
          },
        ),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state is MessageFetchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MessageFetchSuccess) {
          return StreamBuilder<QuerySnapshot>(
            stream: state.messages,
            builder: (context, snapshot) {
              int _count = 1;

              if (!snapshot.hasData) {
                return Center(
                  child: Text('There is no data.'),
                );
              }

              if (snapshot.data.docs.isNotEmpty) {
                _count = snapshot.data.docs.length;

                return ListView.builder(
                  itemCount: _count,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      uid: snapshot.data.docs[index].data()['uid'],
                      name: snapshot.data.docs[index].data()['name'],
                      chat: snapshot.data.docs[index].data()['text'],
                      time:
                          "${snapshot.data.docs[index].data()['timestamp'].toDate().hour.toString()} : ${snapshot.data.docs[index].data()['timestamp'].toDate().minute.toString()}",
                      onPress: () {
                        context.bloc<ChatPrivateBloc>().add(
                              FetchingChatPrivate(
                                selectedId:
                                    snapshot.data.docs[index].data()['uid'],
                              ),
                            );
                        Navigator.pushNamed(
                          context,
                          '/chat_private',
                          arguments: {
                            'currentUid': FirebaseAuth.instance.currentUser.uid,
                            'currentName': FirebaseAuth.instance.currentUser.displayName,
                            'selectedName':
                                snapshot.data.docs[index].data()['name'],
                            'selectedId':
                                snapshot.data.docs[index].data()['uid'],
                          },
                        );
                      },
                    );
                  },
                );
              }
              return Center(
                child: Text(
                  'You can press the globe button \n to join global chat channel.',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
        return Center(
          child: Text('test'),
        );
      },
    );
  }
}
