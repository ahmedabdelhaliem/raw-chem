import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/features/chat/domain/model/chat_model.dart';
import 'package:raw_chem/common/model/paginated_response.dart';

abstract class ChatRepo {
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId);
  Future<Either<Failure, PaginatedResponse<MessageModel>>> getChatMessages(int chatId, {int page = 1});
  Future<Either<Failure, List<ChatModel>>> getChats();
  void connectSocket(String token);
  void disconnectSocket();
  void sendMessage(int chatId, String message);
  Stream<MessageModel> get messagesStream;
}
