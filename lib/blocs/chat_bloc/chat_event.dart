import 'package:equatable/equatable.dart';
import '../../models/chat_message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatStarted extends ChatEvent {
  final String currentUserId;
  final String peerUserId;

  const ChatStarted({
    required this.currentUserId,
    required this.peerUserId,
  });

  @override
  List<Object?> get props => [currentUserId, peerUserId];
}

class ChatMessageSent extends ChatEvent {
  final String text;

  const ChatMessageSent(this.text);

  @override
  List<Object?> get props => [text];
}

class ChatMessagesUpdated extends ChatEvent {
  final List<ChatMessage> messages;

  const ChatMessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}
