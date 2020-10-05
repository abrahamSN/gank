part of 'chat_global_action_bloc.dart';

@immutable
abstract class ChatGlobalActionEvent extends Equatable {}

class SendingChatGlobalAction extends ChatGlobalActionEvent {
  final String text;

  SendingChatGlobalAction({@required this.text});

  @override
  List<Object> get props => [text];
}
