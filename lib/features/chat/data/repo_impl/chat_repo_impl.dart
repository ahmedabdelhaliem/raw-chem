import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/chat/data/data_source/chat_api_data_source.dart';
import 'package:raw_chem/features/chat/data/data_source/chat_socket_service.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/features/chat/domain/model/chat_model.dart';
import 'package:raw_chem/features/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatApiDataSource _apiDataSource;
  final ChatSocketService _socketService;

  ChatRepoImpl(this._apiDataSource, this._socketService);

  @override
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId) {
    return _apiDataSource.createChat(supplierId);
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getChatMessages(int chatId) {
    return _apiDataSource.getChatMessages(chatId);
  }

  @override
  void connectSocket(String token) {
    _socketService.connect(token);
  }

  @override
  void disconnectSocket() {
    _socketService.disconnect();
  }

  @override
  void sendMessage(int chatId, String message) {
    _socketService.sendMessage({
      "type": "message",
      "chat_id": chatId,
      "message": message,
    });
  }

  @override
  Future<Either<Failure, List<ChatModel>>> getChats() {
    return _apiDataSource.getChats();
  }

  @override
  Stream<MessageModel> get messagesStream =>
      _socketService.messagesStream.map((json) => MessageModel.fromJson(json));
}
