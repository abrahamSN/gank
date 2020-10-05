import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank/src/widgets/widgets.dart';

import '../../blocs/blocs.dart';
import '../../utils/utils.dart';

class ChatGlobalPage extends StatefulWidget {
  @override
  _ChatGlobalPageState createState() => _ChatGlobalPageState();
}

class _ChatGlobalPageState extends State<ChatGlobalPage> {
  TextEditingController _messageTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Global Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: _bodyBuilder(context),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: BlocBuilder<ChatGlobalBloc, ChatGlobalState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is ChatGlobalFetchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ChatGlobalFetchSuccess) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: state.chats,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("No data"),
                          );
                        }

                        if (snapshot.data.docs.isNotEmpty) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            // ignore: missing_return
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data.docs.isNotEmpty) {
                                return ChatItemContainer(
                                  isGlobal: true,
                                  currentUserId:
                                      FirebaseAuth.instance.currentUser.uid,
                                  messageId: snapshot.data.docs[index].id,
                                );
                              }
                            },
                          );
                        }
                        return Center(
                          child: Text("Wanna start the conversation?"),
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
                color: Theme.of(context).primaryColor,
                border: Border(),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                boxShadow: [BoxShadow(blurRadius: 1.0)]),
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
                      context.bloc<ChatGlobalActionBloc>().add(
                            SendingChatGlobalAction(
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
