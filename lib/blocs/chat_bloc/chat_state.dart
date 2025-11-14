import 'package:equatable/equatable.dart';
import '../../models/chat_message.dart';

enum ChatStatus { initial, loading, loaded, failure }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatMessage> messages;
  final String? error;
  final String? chatId;

  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.error,
    this.chatId,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessage>? messages,
    String? error,
    String? chatId,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      error: error,
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  List<Object?> get props => [status, messages, error, chatId];
}
