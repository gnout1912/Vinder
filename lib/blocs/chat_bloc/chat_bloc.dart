import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore _firestore;
  String? _currentUserId;
  // String? _peerUserId; // ❌ nếu chưa dùng thì có thể xoá

  StreamSubscription? _messagesSub;

  ChatBloc({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(const ChatState()) {
    on<ChatStarted>(_onChatStarted);
    on<ChatMessageSent>(_onMessageSent);
    on<ChatMessagesUpdated>(_onMessagesUpdated); // ✅ ĐỔI TÊN Ở ĐÂY
  }

  String _buildChatId(String a, String b) {
    if (a.compareTo(b) < 0) {
      return '${a}_$b';
    }
    return '${b}_$a';
  }

  Future<void> _onChatStarted(
    ChatStarted event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(status: ChatStatus.loading));

    _currentUserId = event.currentUserId;
    // _peerUserId = event.peerUserId; // nếu cần thì giữ lại

    final chatId = _buildChatId(event.currentUserId, event.peerUserId);

    await _messagesSub?.cancel();

    _messagesSub = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs
          .map((doc) => ChatMessage.fromMap(doc.id, doc.data()))
          .toList();
      add(ChatMessagesUpdated(messages)); // ✅ ĐỔI TÊN Ở ĐÂY
    });

    emit(state.copyWith(
      status: ChatStatus.loaded,
      chatId: chatId,
    ));
  }

  Future<void> _onMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    if (event.text.trim().isEmpty) return;
    if (_currentUserId == null || state.chatId == null) return;

    final message = ChatMessage(
      id: '',
      chatId: state.chatId!,
      senderId: _currentUserId!,
      text: event.text.trim(),
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection('chats')
        .doc(state.chatId)
        .collection('messages')
        .add(message.toMap());
  }

  void _onMessagesUpdated(
    ChatMessagesUpdated event, // ✅ TYPE MỚI
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(
      status: ChatStatus.loaded,
      messages: event.messages,
    ));
  }

  @override
  Future<void> close() {
    _messagesSub?.cancel();
    return super.close();
  }
}
