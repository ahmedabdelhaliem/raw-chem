import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/features/chat/domain/repo/chat_repo.dart';
import 'package:raw_chem/common/model/paginated_response.dart';

class ChatCubit extends Cubit<BaseState<MessageModel>> {
  final ChatRepo _chatRepo;
  final AppPreferences _appPreferences;
  StreamSubscription? _socketSubscription;
  final Set<String> _messageIds = {};
  late final PaginationHandler<MessageModel, ChatCubit> paginationHandler;

  ChatCubit(this._chatRepo, this._appPreferences) : super(const BaseState()) {
    paginationHandler = PaginationHandler<MessageModel, ChatCubit>(
      bloc: this,
    );
  }

  Future<void> initChat(int chatId) async {
    emit(state.copyWith(status: Status.loading, items: []));

    await paginationHandler.loadFirstPage(
      (page, limit, [params]) => _chatRepo.getChatMessages(chatId, page: page),
    );

    if (state.isSuccess) {
       _messageIds.clear();
       for (var msg in state.items) {
         _messageIds.add(msg.id);
       }
       _connectSocket();
    }
  }

  Future<Either<Failure, PaginatedResponse<MessageModel>>> getChatMessages({
    required int chatId,
    required int page,
  }) async {
    final result = await _chatRepo.getChatMessages(chatId, page: page);
    result.fold((l) => null, (response) {
      for (var msg in response!.data) {
        _messageIds.add(msg.id);
      }
    });
    return result;
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
