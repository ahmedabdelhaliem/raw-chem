import 'package:raw_chem/common/http/api_consumer.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/common/http/either.dart';

abstract class ChatApiDataSource {
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId);
  Future<Either<Failure, List<MessageModel>>> getChatMessages(int chatId);
}

class ChatApiDataSourceImpl implements ChatApiDataSource {
  final ApiConsumer _apiConsumer;

  ChatApiDataSourceImpl(this._apiConsumer);

  @override
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId) async {
    final response = await _apiConsumer.post(
      EndPoints.chats,
      data: {'supplier_id': supplierId},
    );
    return response.fold(
      (failure) => Left(failure),
      (json) => Right(CreateChatResponse.fromJson(json)),
    );
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getChatMessages(int chatId) async {
    final response = await _apiConsumer.get(EndPoints.chatMessages(chatId));
    return response.fold(
      (failure) => Left(failure),
      (json) {
        final List data = json['data'] ?? [];
        return Right(data.map((e) => MessageModel.fromJson(e)).toList());
      },
    );
  }
}
