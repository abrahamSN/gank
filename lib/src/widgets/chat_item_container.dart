import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank/src/blocs/chat_private/chat_private_bloc.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';
import '../utils/utils.dart';

class ChatItemContainer extends StatefulWidget {
  final bool isGlobal;
  final String currentUserId;
  final String messageId;

  ChatItemContainer({this.isGlobal, this.messageId, this.currentUserId});

  @override
  _ChatItemContainerState createState() => _ChatItemContainerState();
}

class _ChatItemContainerState extends State<ChatItemContainer> {
  MessageRepository _messageRepository = new MessageRepository();

  MessageModel _chat;

  Future getDetails() async {
    if (widget.isGlobal == true) {
      _chat = await _messageRepository.getGlobalChatData(
        messageId: widget.messageId,
      );
    } else {
      _chat = await _messageRepository.getPrivateChatData(
        messageId: widget.messageId,
      );
    }

    return _chat;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getDetails(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Container();
        } else {
          return Column(
            crossAxisAlignment: snap.data.senderId == widget.currentUserId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              snap.data.text != null
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        snap.data.senderId == widget.currentUserId
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Text(
                                  snap.data.timeStamp.toDate().hour.toString() +
                                      ":" +
                                      snap.data.timeStamp
                                          .toDate()
                                          .minute
                                          .toString(),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.all(size.height * 0.01),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.7,
                            ),
                            child: InkWell(
                              onTap: () {
                                if (!widget.isGlobal ||
                                    snap.data.senderId ==
                                        widget.currentUserId) {
                                  return null;
                                } else {
                                  context.bloc<ChatPrivateBloc>().add(
                                      FetchingChatPrivate(
                                          selectedId: snap.data.senderId));

                                  return Navigator.popAndPushNamed(
                                    context,
                                    '/chat_private',
                                    arguments: {
                                      'currentUid': widget.currentUserId,
                                      'selectedName': snap.data.senderName,
                                      'selectedId': snap.data.senderId,
                                    },
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      snap.data.senderId == widget.currentUserId
                                          ? AppTheme().SECONDARY_COLOR
                                          : AppTheme().PRIMARY_COLOR,
                                  borderRadius:
                                      snap.data.senderId == widget.currentUserId
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(
                                                size.height * 0.02,
                                              ),
                                              topRight: Radius.circular(
                                                size.height * 0.02,
                                              ),
                                              bottomLeft: Radius.circular(
                                                size.height * 0.02,
                                              ),
                                            )
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(
                                                size.height * 0.02,
                                              ),
                                              topRight: Radius.circular(
                                                size.height * 0.02,
                                              ),
                                              bottomRight: Radius.circular(
                                                size.height * 0.02,
                                              ),
                                            ),
                                ),
                                padding: EdgeInsets.all(size.height * 0.01),
                                child: Column(
                                  crossAxisAlignment:
                                      snap.data.senderId == widget.currentUserId
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    snap.data.senderId != widget.currentUserId
                                        ? Text(
                                            snap.data.senderName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Text(
                                      snap.data.text,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        snap.data.senderId == widget.currentUserId
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01,
                                ),
                                child: Text(
                                  snap.data.timeStamp.toDate().hour.toString() +
                                      ":" +
                                      snap.data.timeStamp
                                          .toDate()
                                          .minute
                                          .toString(),
                                ),
                              ),
                      ],
                    )
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        snap.data.senderId == widget.currentUserId
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Text(snap.data.timeStamp
                                        .toDate()
                                        .hour
                                        .toString() +
                                    ":" +
                                    snap.data.timeStamp
                                        .toDate()
                                        .minute
                                        .toString()),
                              )
                            : Container(),
                        snap.data.senderId == widget.currentUserId
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Text(
                                  snap.data.timeStamp.toDate().hour.toString() +
                                      ":" +
                                      snap.data.timeStamp
                                          .toDate()
                                          .minute
                                          .toString(),
                                ),
                              ),
                      ],
                    ),
            ],
          );
        }
      },
    );
  }
}
