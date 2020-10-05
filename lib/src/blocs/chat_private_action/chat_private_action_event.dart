part of 'chat_private_action_bloc.dart';

@immutable
abstract class ChatPrivateActionEvent extends Equatable {}

class SendingChatPrivateAction extends ChatPrivateActionEvent {
  final String text;
  final String selectedUid;
  final String selectedName;

  SendingChatPrivateAction({
    @required this.text,
    @required this.selectedUid,
    @required this.selectedName,
  });

  @override
  List<Object> get props => [text, selectedUid, selectedName];
}
