import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/features/chat/domain/model/chat_model.dart';

abstract class ChatRepo {
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId);
  Future<Either<Failure, List<MessageModel>>> getChatMessages(int chatId);
  Future<Either<Failure, List<ChatModel>>> getChats();
  void connectSocket(String token);
  void disconnectSocket();
  void sendMessage(int chatId, String message);
  Stream<MessageModel> get messagesStream;
}
