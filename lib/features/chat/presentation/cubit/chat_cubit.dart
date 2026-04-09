import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/features/chat/domain/repo/chat_repo.dart';

class ChatCubit extends Cubit<BaseState<MessageModel>> {
  final ChatRepo _chatRepo;
  final AppPreferences _appPreferences;
  StreamSubscription? _socketSubscription;
  final Set<String> _messageIds = {};

  ChatCubit(this._chatRepo, this._appPreferences) : super(const BaseState());

  Future<void> initChat(int chatId) async {
    emit(state.copyWith(status: Status.loading));

    // 1. Fetch History
    final result = await _chatRepo.getChatMessages(chatId);
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, failure: failure)),
      (messages) {
        _messageIds.clear();
        for (var msg in messages) {
          _messageIds.add(msg.id);
        }
        emit(state.copyWith(status: Status.success, items: messages.reversed.toList()));
        
        // 2. Connect Socket after history is loaded
        _connectSocket();
      },
    );
  }

  void _connectSocket() {
    final token = _appPreferences.getToken();
    if (token.isEmpty) return;

    _chatRepo.connectSocket(token);
    _socketSubscription?.cancel();
    _socketSubscription = _chatRepo.messagesStream.listen(
      (message) {
        _handleIncomingMessage(message);
      },
      onError: (error) {
        // Handle stream error if necessary
      },
    );
  }

  void _handleIncomingMessage(MessageModel message) {
    if (_messageIds.contains(message.id)) return;

    _messageIds.add(message.id);
    final updatedMessages = [message, ...state.items]; // Newest at top for reversed list
    emit(state.copyWith(items: updatedMessages));
  }

  void sendMessage(int chatId, String messageText) {
    if (messageText.trim().isEmpty) return;
    _chatRepo.sendMessage(chatId, messageText);
  }

  @override
  Future<void> close() {
    _socketSubscription?.cancel();
    _chatRepo.disconnectSocket();
    return super.close();
  }
}
